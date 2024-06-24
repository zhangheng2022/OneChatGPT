import 'dart:async';
import 'dart:convert';
import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:one_chatgpt_flutter/database/database.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';
import 'package:one_chatgpt_flutter/common/log.dart';

final supabase = Supabase.instance.client;
const uuid = Uuid();

class ChatPage extends StatefulWidget {
  const ChatPage({super.key, required this.chatid, this.refreshChatList});

  final String chatid;
  final VoidCallback? refreshChatList;

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  static const String defaultAppBarTitle = "新的对话";
  bool _isWaitingForReply = false;
  bool _isAutoUpdateTitle = true; // 是否自动更新标题
  String appBarTitle = defaultAppBarTitle;
  final List<types.Message> _messages = []; // 消息列表
  late types.User _user; // 当前用户
  final _model = types.User(
    id: uuid.v4(),
    firstName: "Google",
    lastName: "Gemini Pro",
    imageUrl:
        "https://jkdxuuhjdoxqsjyhlubj.supabase.co/storage/v1/object/public/common/logo.png",
  ); // 模型用户，用于表示非当前用户的消息
  late AppDatabase database;

  @override
  void initState() {
    super.initState();
    _user = types.User(id: widget.chatid); // 初始化当前用户
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    database = Provider.of<AppDatabase>(context); // 初始化数据库
    _initMessage(); // 初始化消息
  }

  // 初始化消息
  Future<void> _initMessage() async {
    final messages = await _getChatContentTableDatabase(); // 从数据库获取消息
    if (messages.isNotEmpty) {
      _populateChatWithMessages(messages); // 如果有消息，则填充到聊天界面
    } else {
      _addWelcomeMessage(); // 如果没有消息，则添加欢迎消息
    }
    final chatTable = await _getChatTableDatabase();
    if (chatTable != null) {
      _isAutoUpdateTitle = chatTable.isupdate;
    }
  }

  // 从数据库获取聊天内容
  Future _getChatContentTableDatabase() async {
    return (database.select(database.chatContentTableData)
          ..where((tbl) => tbl.parentid.equals(int.parse(_user.id))))
        .get();
  }

  // 从数据库获取聊天表
  Future _getChatTableDatabase() async {
    return (database.select(database.chatTableData)
          ..where((tbl) => tbl.id.equals(int.parse(_user.id))))
        .getSingleOrNull();
  }

  // 将消息填充到聊天界面
  void _populateChatWithMessages(List messages) {
    for (var message in messages) {
      final chatMessage = _createTextMessage(
        content: message.content,
        isUserMessage: message.contentType == 'user',
      );
      _addMessage(chatMessage);
    }
  }

  // 添加欢迎消息
  void _addWelcomeMessage() async {
    const welcomeText = "你好，有什么可以帮你的吗？";
    final welcomeMessage =
        _createTextMessage(content: welcomeText, isUserMessage: false);
    _addMessage(welcomeMessage);
    await _insertMessageIntoDatabase(welcomeText, 'model');
  }

  // 创建文本消息
  types.TextMessage _createTextMessage(
      {required String content, required bool isUserMessage}) {
    return types.TextMessage(
      author: isUserMessage ? _user : _model,
      id: uuid.v4(),
      text: content,
    );
  }

  // 将消息添加到聊天界面
  Future<void> _addMessage(types.Message message) async {
    setState(() => _messages.insert(0, message));
  }

  // 发送消息
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
      await _fetchModelResponse(message.text);
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

  // 将消息插入数据库
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

  // 获取并显示模型响应
  Future<void> _fetchModelResponse(String userMessage) async {
    final response = await supabase.functions.invoke(
      'google/gemini-pro',
      body: {'message': userMessage},
    );
    final messageid = uuid.v4();
    String message = '';
    var completer = Completer<void>(); // 创建Completer
    response.data.transform(const Utf8Decoder()).listen(
      (val) {
        message += val;
        final modelMessage = types.TextMessage(
          author: _model,
          id: messageid,
          text: message,
        );
        _addOrUpdateMessage(modelMessage);
      },
      onDone: () {
        _insertMessageIntoDatabase(message, 'model');
        completer.complete(); // 在onDone中完成Completer
      },
      onError: (e) {
        completer.completeError(e); // 处理错误
      },
    );
    return completer.future; // 返回Completer的Future
  }

  // 更新或添加消息
  void _addOrUpdateMessage(types.TextMessage message) {
    final index = _messages.indexWhere((m) => m.id == message.id);
    if (index != -1) {
      setState(() {
        _messages[index] = message;
      });
    } else {
      _addMessage(message);
    }
  }

  // 更新聊天标题
  Future<void> updateChatTitle(String chatId, String newTitle) async {
    try {
      final int chatIdInt = int.parse(chatId);
      await (database.update(database.chatTableData)
            ..where((tbl) => tbl.id.equals(chatIdInt)))
          .write(ChatTableDataCompanion(
              title: Value(newTitle), isupdate: const Value(false)));
    } catch (e) {
      Log.e("Error updating chat title: $e");
    }
  }

  // 构建发送按钮图标
  Widget _sendButtonIcon() {
    if (_isWaitingForReply) {
      return const SizedBox(
        width: 20,
        height: 20,
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
        ),
      );
    } else {
      return const Icon(Icons.send, color: Colors.white);
    }
  }

  // 显示编辑标题对话框
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(appBarTitle), // 设置AppBar标题
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.draw),
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
        showUserNames: true, // 显示用户昵称
        l10n: const ChatL10nZhCN(), // 设置中文本地化
        theme: DefaultChatTheme(
          primaryColor: Theme.of(context).primaryColor,
          sendButtonIcon: _sendButtonIcon(),
          userNameTextStyle: TextStyle(color: Theme.of(context).primaryColor),
        ),
        inputOptions: InputOptions(
          sendButtonVisibilityMode: SendButtonVisibilityMode.always,
          enabled: !_isWaitingForReply,
        ),
      ),
    );
  }
}
