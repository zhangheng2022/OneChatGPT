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
final database = AppDatabase();
const uuid = Uuid();

class ChatPage extends StatefulWidget {
  const ChatPage({super.key, required this.chatid});

  final String chatid;

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  static const String defaultAppBarTitle = "新的对话";
  static const int messageThresholdForTitleUpdate = 3;
  static const int maxMessagesBeforeTitleUpdate = 6;

  String appBarTitle = defaultAppBarTitle;
  final List<types.Message> _messages = []; // 消息列表
  late types.User _user; // 当前用户
  final _model = types.User(id: uuid.v4()); // 模型用户，用于表示非当前用户的消息

  @override
  void initState() {
    super.initState();
    _user = types.User(id: widget.chatid); // 初始化当前用户
    _initMessage(); // 初始化消息
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(appBarTitle), // 设置AppBar标题
        centerTitle: true,
      ),
      body: Chat(
        messages: _messages, // 消息列表
        onSendPressed: _sendMessage, // 发送消息的回调
        user: _user, // 当前用户
        showUserAvatars: true, // 显示用户头像
        l10n: const ChatL10nZhCN(), // 设置中文本地化
      ),
    );
  }

  Future<void> _initMessage() async {
    final messages = await _fetchMessagesFromDatabase(); // 从数据库获取消息
    if (messages.isNotEmpty) {
      _populateChatWithMessages(messages); // 如果有消息，则填充到聊天界面
    } else {
      _addWelcomeMessage(); // 如果没有消息，则添加欢迎消息
    }
  }

  // 从数据库获取消息的实现
  Future _fetchMessagesFromDatabase() async {
    return (database.select(database.chatContentTableData)
          ..where((tbl) => tbl.parentid.equals(int.parse(_user.id))))
        .get();
  }

// 将消息填充到聊天界面的实现
  void _populateChatWithMessages(List messages) {
    for (var message in messages) {
      final chatMessage = _createTextMessage(
        content: message.content,
        isUserMessage: message.contentType == 'user',
      );
      _addMessage(chatMessage);
    }
  }

// 添加欢迎消息的实现
  void _addWelcomeMessage() async {
    const welcomeText = "你好，有什么可以帮你的吗？";
    final welcomeMessage =
        _createTextMessage(content: welcomeText, isUserMessage: false);
    _addMessage(welcomeMessage);
    await _insertMessageIntoDatabase(welcomeText, 'model');
  }

// 创建文本消息的实现
  types.TextMessage _createTextMessage(
      {required String content, required bool isUserMessage}) {
    return types.TextMessage(
      author: isUserMessage ? _user : _model,
      id: uuid.v4(),
      text: content,
    );
  }

// 将消息添加到聊天界面的实现
  Future<void> _addMessage(types.Message message) async {
    setState(() => _messages.insert(0, message));
  }

// 发送消息的实现
  Future<void> _sendMessage(types.PartialText message) async {
    final textMessage =
        _createTextMessage(content: message.text, isUserMessage: true);
    await _addMessage(textMessage);
    await _insertMessageIntoDatabase(message.text, 'user');
    await _fetchAndDisplayModelResponse(message.text);
  }

// 将消息插入数据库的实现
  Future<void> _insertMessageIntoDatabase(
      String content, String contentType) async {
    await database.into(database.chatContentTableData).insert(
          ChatContentTableDataCompanion.insert(
            title: appBarTitle,
            content: content,
            parentid: int.parse(_user.id),
            contentType: contentType,
          ),
        );
  }

// 获取并显示模型响应的实现
  Future<void> _fetchAndDisplayModelResponse(String userMessage) async {
    try {
      final response = await _fetchModelResponse(userMessage);
      final modelMessage =
          _createTextMessage(content: response.text, isUserMessage: false);
      await _addMessage(modelMessage);
      await _insertMessageIntoDatabase(response.text, 'model');
      if (_shouldUpdateAppBarTitle()) {
        _updateAppBarTitle();
      }
    } catch (err) {
      Log.e(err);
    }
  }

// 从模型获取响应的实现
  Future<ChatMessage> _fetchModelResponse(String message) async {
    final res = await supabase.functions.invoke(
      'google/gemini-pro',
      body: {'message': message},
    );
    return ChatMessage.fromJson(res.data);
  }

  // 判断是否应更新AppBar标题的实现
  bool _shouldUpdateAppBarTitle() {
    return _messages.length >= messageThresholdForTitleUpdate &&
        _messages.length < maxMessagesBeforeTitleUpdate;
  }

  // 更新AppBar标题的实现
  Future<void> _updateAppBarTitle() async {}
}
