import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:one_chatgpt_flutter/database/chat_record.dart';
import 'package:one_chatgpt_flutter/database/database.dart';
import 'package:one_chatgpt_flutter/models/network_chat/request_chat.dart';
import 'package:one_chatgpt_flutter/models/network_chat/response_chat.dart';
import 'package:one_chatgpt_flutter/services/dio_singleton.dart';
import 'package:one_chatgpt_flutter/state/theme.dart';
import 'package:one_chatgpt_flutter/ui/chat/drift_chat_controller.dart';
import 'package:one_chatgpt_flutter/ui/chat/widgets/chat_custom_input.dart';
import 'package:one_chatgpt_flutter/ui/chat/widgets/chat_image_message.dart';
import 'package:one_chatgpt_flutter/ui/chat/widgets/chat_text_message.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_chat_core/flutter_chat_core.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supabase;
import 'package:uuid/uuid.dart';

// 初始化 Supabase 客户端
final supabaseClient = supabase.Supabase.instance.client;
final supabaseUrl = dotenv.get('SUPABASE_URL', fallback: null);

class ChatHome extends StatefulWidget {
  final String chatId;
  const ChatHome({
    super.key,
    required this.chatId,
  });

  @override
  State<ChatHome> createState() => _ChatHomeState();
}

class _ChatHomeState extends State<ChatHome> {
  final _scrollController = ScrollController();

  late final ChatController _chatController;

  bool _isDisableSend = false;

  CancelToken _cancelToken = CancelToken();

  PresetEnum _preset = PresetEnum.chat;

  void _modelMessageCancel() {
    _cancelToken.cancel();
    _cancelToken = CancelToken();
    final index = _chatController.messages
        .indexWhere((message) => message.metadata?['status'] == 'init');
    if (index != -1) {
      final oldMessage = _chatController.messages[index];
      if (oldMessage is TextMessage) {
        final newMessage = oldMessage.copyWith(
          text: "已停止生成",
          metadata: null,
        );
        _chatController.update(oldMessage, newMessage);
      }
      if (oldMessage is ImageMessage) {
        final newMessage = oldMessage.copyWith(
          source: "",
          metadata: {'status': 'stop'},
        );
        _chatController.update(oldMessage, newMessage);
      }
    }
  }

  Future<ResponseChat?> _imageMessage() async {
    final List<RequestChatMessage> historyMessages =
        _chatController.messages.map(
      (message) {
        if (message is TextMessage) {
          return RequestChatMessage(
            content: message.text,
            role: message.author.id,
          );
        }
        return RequestChatMessage(
          content: "不支持的消息类型",
          role: message.author.id,
        );
      },
    ).toList();
    historyMessages.removeLast();
    int startIndex =
        (historyMessages.length - 3).clamp(0, historyMessages.length);
    final params = RequestChat(
      messages: historyMessages.sublist(startIndex),
      preset: _preset.name,
    );
    print(params);
    final session = supabaseClient.auth.currentSession;
    try {
      final response = await DioSingleton.instance.post(
        '${dotenv.env['SUPABASE_URL']}/functions/v1/portkeyai/generateimage',
        options: Options(
          headers: {'Authorization': 'Bearer ${session?.accessToken}'},
        ),
        data: params.toJson(),
        cancelToken: _cancelToken,
      );
      debugPrint('===${response.data}===');
      return ResponseChat.fromJson(response.data);
    } on DioException catch (e) {
      if (e.type == DioExceptionType.cancel) {
        debugPrint('图片停止生成: ${e.message}');
      }
    } catch (e) {
      debugPrint('图片生成错误: $e');
    }
    return null;
  }

  Stream<String> _assistantMessage() async* {
    final List<RequestChatMessage> historyMessages =
        _chatController.messages.map(
      (message) {
        if (message is TextMessage) {
          return RequestChatMessage(
            content: message.text,
            role: message.author.id,
          );
        } else {
          return RequestChatMessage(
            content: "不支持的消息类型",
            role: message.author.id,
          );
        }
      },
    ).toList();
    historyMessages.removeLast();
    int startIndex =
        (historyMessages.length - 5).clamp(0, historyMessages.length);

    final RequestChat params = RequestChat(
      messages: historyMessages.sublist(startIndex),
      preset: _preset.name,
    );

    final session = supabaseClient.auth.currentSession;
    try {
      final response = await DioSingleton.instance.post(
        '${dotenv.env['SUPABASE_URL']}/functions/v1/portkeyai/completions',
        options: Options(
          headers: {'Authorization': 'Bearer ${session?.accessToken}'},
          responseType: ResponseType.stream,
        ),
        data: params.toJson(),
        cancelToken: _cancelToken,
      );

      StreamTransformer<Uint8List, List<int>> unit8Transformer =
          StreamTransformer.fromHandlers(
        handleData: (data, sink) {
          sink.add(List<int>.from(data));
        },
      );

      await for (final chunk in response.data!.stream
          .transform(unit8Transformer)
          .transform(const Utf8Decoder())
          .transform(const LineSplitter())) {
        if (chunk.startsWith('data: ')) {
          final jsonString = chunk.substring(6);
          final messageContent = ResponseChat.fromJson(json.decode(jsonString))
                  .choices[0]
                  .delta
                  ?.content ??
              '';
          yield messageContent;
        }
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.cancel) {
        debugPrint('completions停止生成: ${e.message}');
      }
    } catch (e) {
      debugPrint('completions错误: $e');
    }
  }

  void _handleMessageSend(String text) async {
    if (text.isEmpty) return;

    setState(() {
      _isDisableSend = true;
    });

    await _chatController.insert(
      TextMessage(
        id: const Uuid().v4(),
        author: User(id: 'user'),
        createdAt: DateTime.now(),
        text: text,
      ),
    );

    final messageId = const Uuid().v4();

    if (_preset == PresetEnum.chat) {
      await _chatController.insert(
        TextMessage(
          id: messageId,
          author: User(id: 'assistant'),
          createdAt: DateTime.now(),
          text: '',
          metadata: {'status': 'init'},
        ),
      );
      await for (final content in _assistantMessage()) {
        final oldMessage = _chatController.messages
            .singleWhere((message) => message.id == messageId);
        if (oldMessage is TextMessage) {
          final newMessage = oldMessage.copyWith(
            text: oldMessage.text + content,
            metadata: null,
          );
          await _chatController.update(oldMessage, newMessage);
        }
      }
    }
    if (_preset == PresetEnum.createImage) {
      await _chatController.insert(
        ImageMessage(
          id: messageId,
          author: User(id: 'assistant'),
          createdAt: DateTime.now(),
          source: '',
          metadata: {'status': 'init'},
        ),
      );
      final message = await _imageMessage();

      final oldMessage = _chatController.messages
          .singleWhere((message) => message.id == messageId);

      if (message == null) {
        await _chatController.update(
          oldMessage,
          ImageMessage(
            id: messageId,
            author: User(id: 'assistant'),
            createdAt: DateTime.now(),
            source: '',
            metadata: {'status': 'error'},
          ),
        );
        return;
      }
      if (message.imageData!.isNotEmpty) {
        await _chatController.update(
          oldMessage,
          ImageMessage(
            id: messageId,
            author: User(id: 'assistant'),
            createdAt: DateTime.now(),
            source: message.imageData ?? '',
          ),
        );
      } else {
        await _chatController.update(
          oldMessage,
          TextMessage(
            id: messageId,
            author: User(id: 'assistant'),
            createdAt: DateTime.now(),
            text: message.choices[0].message?.content ?? '',
          ),
        );
      }
    }

    if (!mounted) return;
    setState(() {
      _isDisableSend = false;
    });
  }

  static const Map<PresetEnum, String> _presetTitle = {
    PresetEnum.chat: "聊一聊",
    PresetEnum.createImage: "生成图片",
  };

  void _initPreset() async {
    final chatRecord = await Provider.of<AppDatabase>(context, listen: false)
        .managers
        .chatRecord
        .filter((row) => row.id.equals(int.parse(widget.chatId)))
        .getSingle();
    setState(() {
      _preset = chatRecord.preset;
    });
  }

  @override
  void initState() {
    super.initState();
    _initPreset();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _chatController = DriftChatController(
      database: Provider.of<AppDatabase>(context),
      chatId: widget.chatId,
    );
  }

  @override
  void dispose() {
    _modelMessageCancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String currentThemeKey = context.watch<ThemeProvider>().currentThemeKey;
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              'assets/logos/logo.png',
              width: 30,
              height: 30,
            ),
            SizedBox(width: 10),
            Text(_presetTitle[_preset] ?? ''),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.volume_off_outlined),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
      body: Chat(
        builders: Builders(
          textMessageBuilder: (context, textMessage, index) =>
              ChatTextMessage(message: textMessage, index: index),
          imageMessageBuilder: (context, imageMessage, index) =>
              ChatImageMessage(message: imageMessage, index: index),
          inputBuilder: (context) => ChatCustomInput(
            disableSend: _isDisableSend,
            onCancel: _modelMessageCancel,
          ),
        ),
        onMessageSend: _handleMessageSend,
        // onAttachmentTap: _handleAttachmentTap,
        chatController: _chatController,
        user: User(id: 'user'),
        scrollController: _scrollController,
        themeMode: currentThemeKey == 'dark' ? ThemeMode.dark : ThemeMode.light,
        darkTheme: ChatTheme.dark().copyWith(backgroundColor: Colors.white),
      ),
    );
  }
}
