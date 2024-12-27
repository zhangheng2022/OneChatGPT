import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:one_chatgpt_flutter/database/database.dart';
import 'package:one_chatgpt_flutter/models/network_chat/request_chat.dart';
import 'package:one_chatgpt_flutter/models/network_chat/response_chat.dart';
import 'package:one_chatgpt_flutter/services/dio_singleton.dart';
import 'package:one_chatgpt_flutter/ui/chat/drift_chat_controller.dart';
import 'package:one_chatgpt_flutter/ui/chat/widgets/chat_custom_input.dart';
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
  const ChatHome({super.key, required this.chatId});

  @override
  State<ChatHome> createState() => _ChatHomeState();
}

class _ChatHomeState extends State<ChatHome> {
  final _scrollController = ScrollController();

  late final ChatController _chatController;

  bool _isDisableSend = false;

  CancelToken _cancelToken = CancelToken();

  void _modelMessageCancel() {
    _cancelToken.cancel();
    _cancelToken = CancelToken();
    final index = _chatController.messages.indexWhere(
      (message) => message.metadata?.containsKey('init') == true,
    );
    if (index != -1) {
      final message = _chatController.messages[index];
      if (message is TextMessage) {
        final newMessage = message.copyWith(
          text: '已停止生成',
          metadata: null,
        );
        _chatController.update(message, newMessage);
      }
    }
  }

  Stream<String> _getModelMessage() async* {
    final List<RequestChatMessage> historyMessages = _chatController.messages
        .where((message) => message is TextMessage && message.text.isNotEmpty)
        .map(
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

    final params = RequestChat(
      messages: historyMessages,
      preset: "chat",
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
                  .content ??
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
    await _chatController.insert(
      TextMessage(
        id: messageId,
        author: User(id: 'assistant'),
        createdAt: DateTime.now(),
        text: '',
        metadata: {'init': true},
      ),
    );
    await for (final content in _getModelMessage()) {
      final index = _chatController.messages.indexWhere(
        (message) => message.id == messageId,
      );
      if (index != -1) {
        final oldMessage = _chatController.messages[index];
        if (oldMessage is TextMessage) {
          final newMessage = oldMessage.copyWith(
            text: oldMessage.text + content,
            metadata: null,
          );
          await _chatController.update(oldMessage, newMessage);
        }
      } else {
        await _chatController.insert(
          TextMessage(
            id: messageId,
            author: User(id: 'assistant'),
            createdAt: DateTime.now(),
            text: content,
          ),
        );
      }
    }

    setState(() {
      _isDisableSend = false;
    });
  }

  void _handleAttachmentTap() async {
    // final picker = ImagePicker();

    // final image = await picker.pickImage(source: ImageSource.gallery);

    // if (image == null) return;

    // await _crossCache.downloadAndSave(image.path);
  }

  @override
  void initState() {
    super.initState();
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
            Text("聊一聊"),
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
          textMessageBuilder: (context, message) =>
              ChatTextMessage(message: message),
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
        themeMode: ThemeMode.light,
      ),
    );
  }
}
