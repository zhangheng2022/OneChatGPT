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

  bool _isWaitingForReply = false; // 新增状态变量

  @override
  void initState() {
    super.initState();
    _user = types.User(id: widget.chatid); // 初始化当前用户
    _initMessage(); // 初始化消息
  }

  Widget _sendButtonIcon() {
    if (_isWaitingForReply) {
      return const SizedBox(
        width: 20, // Match the expected size of an icon
        height: 20,
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(
              Colors.white), // Adjust the color as needed
        ),
      );
    } else {
      return const Icon(
        Icons.send,
        color: Colors.white,
      ); // Your default send icon
    }
  }

  Future<String?> _showEditTitleDialog(BuildContext context) async {
    String? newTitle;
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('修改标题'),
          content: TextField(
            autofocus: true,
            maxLength: 10,
            decoration: const InputDecoration(hintText: '输入新的对话标题'),
            onChanged: (value) {
              newTitle = value;
            },
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('取消'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('确定'),
              onPressed: () {
                Navigator.of(context).pop(newTitle);
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> test() async {
    // 假设我们更新第一个聊天数据的标题
    final firstChat = await database.select(database.chatTableData).getSingle();
    final updatedTitle = "updatedTitle"; // 创建一个基于当前时间的新标题，以确保它是唯一的

    await (database.update(database.chatTableData)
          ..where((tbl) => tbl.id.equals(firstChat.id)))
        .write(ChatTableDataCompanion(
      title: Value(updatedTitle),
    ));

    // 打印日志以确认方法被调用
    print("Test method executed: title updated to $updatedTitle");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(appBarTitle), // 设置AppBar标题
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () async {
              final String? newTitle = await _showEditTitleDialog(context);
              if (newTitle != null && newTitle.isNotEmpty) {
                setState(() {
                  appBarTitle = newTitle;
                  updateChatTitle(widget.chatid, newTitle);
                });
              }
            },
          ),
        ],
      ),
      body: Chat(
        messages: _messages, // 消息列表
        onSendPressed: _sendMessage, // 发送消息的回调
        user: _user, // 当前用户
        showUserAvatars: true, // 显示用户头像
        l10n: const ChatL10nZhCN(), // 设置中文本地化
        theme: DefaultChatTheme(
          primaryColor: Theme.of(context).primaryColor,
          sendButtonIcon: _sendButtonIcon(),
        ),
        inputOptions: const InputOptions(
            sendButtonVisibilityMode: SendButtonVisibilityMode.always),
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
    if (_isWaitingForReply) return; // 如果正在等待回复，则不执行发送操作

    setState(() {
      _isWaitingForReply = true; // 开始发送消息，设置等待回复状态为true
    });

    final textMessage =
        _createTextMessage(content: message.text, isUserMessage: true);
    await _addMessage(textMessage);
    await _insertMessageIntoDatabase(message.text, 'user');

    try {
      await _fetchAndDisplayModelResponse(message.text);
    } catch (err) {
      Log.e(err);
    } finally {
      if (mounted) {
        setState(() {
          _isWaitingForReply = false; // 收到回复或发生错误，设置等待回复状态为false
        });
      }
    }
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
  Future<void> updateChatTitle(String chatId, String newTitle) async {
    try {
      final int chatIdInt = int.parse(chatId);
      await (database.update(database.chatTableData)
            ..where((tbl) => tbl.id.equals(chatIdInt)))
          .write(ChatTableDataCompanion(title: Value(newTitle)));
    } catch (e) {
      // Consider logging the error or handling it appropriately
      print("Error updating chat title: $e");
    }
  }

  Future<void> _updateAppBarTitle() async {}
}
