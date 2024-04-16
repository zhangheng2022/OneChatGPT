import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:one_chatgpt_flutter/database/database.dart';
import 'package:one_chatgpt_flutter/models/response/chat_message.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

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
          onSendPressed: _handleSendText,
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
    setState(() {
      _messages.insert(0, message);
    });
    _updateAppBarTitle();
  }

  Future<void> _updateMessage(types.Message message, int index) async {}

  Future<void> _handleSendText(types.PartialText message) async {
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
    } catch (err) {
      print(err);
    }
  }

  void _updateAppBarTitle() {
    print(_messages);
    final msg = _messages.map((e) => e.toJson());
    print(msg);
    // final msgText = _messages.firstWhere((element) => element.);
    // String text = _messages.last;
    // final res = await supabase.functions.invoke(
    //   'google/chat-title',
    //   body: {'message': text},
    // );
    // final data = ChatMessage.fromJson(res.data);
    // (database.update(database.chatTables)
    //       ..where((t) => t.id.isValue(int.parse(_user.id))))
    //     .write(ChatTablesCompanion(
    //   title: Value(data.text),
    // ));
    // return data.text;
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
