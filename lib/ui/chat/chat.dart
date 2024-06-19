import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:one_chatgpt_flutter/database/database.dart';
import 'package:one_chatgpt_flutter/models/response/chat_message.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';
import 'package:one_chatgpt_flutter/common/log.dart';

final supabase = Supabase.instance.client;
final User? user = supabase.auth.currentUser;
final database = AppDatabase();
const uuid = Uuid();

class ChatPage extends StatefulWidget {
  const ChatPage({super.key, required this.chatid});

  final String chatid;

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  void initState() {
    super.initState();
    _user = types.User(
      id: widget.chatid,
    );
    initMessage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(appBarTitle),
          centerTitle: true,
        ),
        body: Chat(
          messages: _messages,
          onSendPressed: _sendMessage,
          user: _user,
          showUserAvatars: true,
          l10n: const ChatL10nZhCN(),
        ));
  }

  String appBarTitle = "新的对话";

  final List<types.Message> _messages = [];

  var _user = const types.User(
    id: "",
  );
  final _model = types.User(
    id: uuid.v4(),
  );

  Future<void> initMessage() async {
    final messages = await (database.select(database.chatContentTables)
          ..where((tbl) => tbl.parentid.equals(int.parse(_user.id))))
        .get();
    if (messages.isNotEmpty) {
      for (var i = 0; i < messages.length; i++) {
        final chatMessage = types.TextMessage(
          author: messages[i].contentType == 'user' ? _user : _model,
          id: uuid.v4(),
          text: messages[i].content,
        );
        _addMessage(chatMessage);
      }
      return;
    }
    final chatMessage = types.TextMessage(
      author: _model,
      id: uuid.v4(),
      text: "你好，有什么可以帮你的吗？",
    );
    _addMessage(chatMessage);
    await database.into(database.chatContentTables).insert(
          ChatContentTablesCompanion.insert(
            title: "新的对话",
            content: "你好，有什么可以帮你的吗？",
            parentid: int.parse(_user.id),
            contentType: 'model',
          ),
        );
  }

  Future<void> _addMessage(types.Message message) async {
    // 添加消息
    setState(() {
      _messages.insert(0, message);
    });
  }

  // Future<void> _updateMessage(types.Message message, int index) async {}

  /// 发送用户输入的消息并获取模型生成的响应。
  ///
  /// 该方法接收一个 [types.PartialText] 消息，代表用户输入的文本。然后执行以下操作：
  /// 1. 根据用户的输入构造一个 [types.TextMessage] 并将其添加到聊天中。
  /// 2. 将用户的消息插入到数据库中。
  /// 3. 调用 Supabase 函数获取模型生成的响应。
  /// 4. 用模型的响应构造一个新的 [types.TextMessage] 并将其添加到聊天中。
  /// 5. 将模型的响应插入到数据库中。
  ///
  /// 参数：
  /// - [message]: 一个包含用户消息文本的 [types.PartialText] 对象。
  ///
  /// 返回值：
  /// 该方法不返回值；它是异步的，并且作为副作用更新 UI 和数据库。
  Future<void> _sendMessage(types.PartialText message) async {
    try {
      final textMessage = types.TextMessage(
        author: _user,
        id: uuid.v4(),
        text: message.text,
      );
      _addMessage(textMessage);
      // 写入数据库
      await database.into(database.chatContentTables).insert(
            ChatContentTablesCompanion.insert(
              title: appBarTitle,
              content: message.text,
              parentid: int.parse(_user.id),
              contentType: 'user',
            ),
          );
      // 获取模型回复
      final res = await supabase.functions.invoke(
        'google/gemini-pro',
        body: {'message': message.text},
      );
      final data = ChatMessage.fromJson(res.data);
      // 发送模型回复消息
      final chatMessage = types.TextMessage(
        author: _model,
        id: uuid.v4(),
        text: data.text,
      );
      _addMessage(chatMessage);
      // 写入数据库
      await database.into(database.chatContentTables).insert(
            ChatContentTablesCompanion.insert(
              title: appBarTitle,
              content: data.text,
              parentid: int.parse(_user.id),
              contentType: 'model',
            ),
          );
      // 如果_messages.length == 2, 那么就更新appBarTitle
      if (_messages.length >= 3 && _messages.length < 6) _updateAppBarTitle();
    } catch (err) {
      Log.e(err);
    }
  }

  // 获取历史消息
  Future<List<Map<String, Object>>> _getHistoryMessages() async {
    final messages = await (database.select(database.chatContentTables)
          ..where((tbl) => tbl.parentid.equals(int.parse(_user.id))))
        .get();
    final historyMessages = messages
        .map((e) => {
              "role": e.contentType,
              'parts': [
                {'text': e.content}
              ]
            })
        .skip(1)
        .toList();
    Log.w(historyMessages);
    return historyMessages;
  }

  // 更新数据Title
  Future<void> _updateAppBarTitle() async {
    try {
      final historyMessages = await _getHistoryMessages();
      final res = await supabase.functions.invoke(
        'google/chat-title',
        body: {'history': historyMessages},
      );
      Log.d(res);
      final data = ChatMessage.fromJson(res.data);
      await (database.update(database.chatTables)
            ..where((t) => t.id.isValue(int.parse(_user.id))))
          .write(ChatTablesCompanion(
        title: Value(data.text),
      ));
      setState(() {
        appBarTitle = data.text;
      });
    } catch (err) {
      Log.e(err);
    }
  }

  // Future<void> _handleImageSelection() async {
  //   final result = await ImagePicker().pickImage(
  //     imageQuality: 70,
  //     maxWidth: 1440,
  //     source: ImageSource.gallery,
  //   );

  //   if (result != null) {
  //     final bytes = await result.readAsBytes();
  //     final image = await decodeImageFromList(bytes);

  //     final message = types.ImageMessage(
  //       author: _user,
  //       createdAt: DateTime.now().millisecondsSinceEpoch,
  //       height: image.height.toDouble(),
  //       id: randomString(),
  //       name: result.name,
  //       size: bytes.length,
  //       uri: result.path,
  //       width: image.width.toDouble(),
  //     );

  //     _addMessage(message);
  //   }
  // }
}
