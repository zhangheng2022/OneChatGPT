import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:image_picker/image_picker.dart';
import 'package:one_chatgpt_flutter/models/model_config.dart';
import 'package:one_chatgpt_flutter/models/request/function_chat_body.dart';
import 'package:one_chatgpt_flutter/models/response/channel_model.dart';
import 'package:one_chatgpt_flutter/models/response/stream_chat_message.dart';
import 'package:one_chatgpt_flutter/state/model_config.dart';
import 'package:one_chatgpt_flutter/utils/util.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';
import 'package:path/path.dart' as path;
import 'package:one_chatgpt_flutter/common/log.dart';
import 'package:one_chatgpt_flutter/database/database.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

// 初始化 Supabase 客户端
final supabase = Supabase.instance.client;
final supabaseUrl = dotenv.get('SUPABASE_URL', fallback: null);

// 定义聊天页面
class ChatPage extends StatefulWidget {
  // 构造函数
  const ChatPage({super.key, required this.chatid, this.refreshChatList});

  // 聊天 ID
  final String chatid;
  // 刷新聊天列表回调函数
  final VoidCallback? refreshChatList;

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  // 定义默认标题
  static const String defaultAppBarTitle = "新的对话";
  // 等待回复状态
  bool _isWaitingForReply = false;
  // 是否自动更新标题
  bool _isAutoUpdateTitle = true;
  // 聊天标题
  String appBarTitle = defaultAppBarTitle;
  // 聊天消息列表
  final List<types.Message> _messages = [];
  // 用户信息
  late types.User _user;
  // 模型信息
  late types.User _model;
  // 数据库实例
  late AppDatabase database;

  @override
  void initState() {
    super.initState();
    // 初始化用户信息
    _user = types.User(id: widget.chatid);

    ChannelModel currentModel =
        context.read<ModelConfigProvider>().currentModel;
    _model = types.User(
      id: const Uuid().v4(),
      firstName: currentModel.label,
      lastName: currentModel.model,
      imageUrl: "$supabaseUrl/storage/v1/object/public/common/logo.png",
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // 获取数据库实例
    database = Provider.of<AppDatabase>(context);
    // 初始化聊天消息
    _initMessage();
  }

  // 初始化聊天消息
  Future<void> _initMessage() async {
    // 从数据库获取聊天内容
    final messages = await _getChatContentTableDatabase();
    // 如果有聊天记录，则填充聊天消息列表
    if (messages.isNotEmpty) {
      _populateChatWithMessages(messages);
    } else {
      // 否则添加欢迎消息
      _addWelcomeMessage();
    }
    // 获取聊天信息
    final chatTable = await _getChatTableDatabase();
    // 如果有聊天信息，则更新标题和自动更新状态
    if (chatTable != null) {
      _isAutoUpdateTitle = chatTable.isupdate;
      appBarTitle = chatTable.title ?? defaultAppBarTitle;
    }
  }

  // 从数据库获取聊天内容
  Future<List<ChatContentTableDataData>> _getChatContentTableDatabase() async {
    // 查询所有 parentid 等于用户 ID 的聊天记录
    return (database.select(database.chatContentTableData)
          ..where((tbl) => tbl.parentid.equals(int.parse(_user.id))))
        .get();
  }

  // 从数据库获取聊天信息
  Future<ChatTableDataData?> _getChatTableDatabase() async {
    // 查询 ID 等于用户 ID 的聊天信息
    return (database.select(database.chatTableData)
          ..where((tbl) => tbl.id.equals(int.parse(_user.id))))
        .getSingleOrNull();
  }

  // 填充聊天消息列表
  void _populateChatWithMessages(List<ChatContentTableDataData> messages) {
    // 循环遍历所有聊天记录并添加到列表中
    for (var message in messages) {
      _addMessage(
        _createMessage(
          message.textarea ?? '',
          message.contentType,
          message.role,
          message.role == 'user',
          message.fileUri ?? '',
          message.fileSize ?? 0,
        ),
      );
    }
  }

  // 添加欢迎消息
  void _addWelcomeMessage() async {
    // 欢迎文本
    const welcomeText = "你好，有什么可以帮你的吗？";
    // 创建欢迎消息
    final welcomeMessage = _createTextMessage(
      content: welcomeText,
      isUserMessage: false,
      role: "system",
    );
    // 添加欢迎消息到列表
    _addMessage(welcomeMessage);
    // 将欢迎消息插入数据库
    await _insertMessageIntoDatabase(
      text: welcomeText,
      role: 'system',
    );
  }

  // 创建消息对象
  types.Message _createMessage(
    String content,
    String contentType,
    String role,
    bool isUserMessage,
    String fileUri,
    int fileSize,
  ) {
    // 根据 contentType 创建不同类型的消息
    if (contentType == 'text') {
      return _createTextMessage(
        content: content,
        isUserMessage: isUserMessage,
        role: role,
      );
    } else if (contentType == 'file') {
      return _createImageMessage(
        content: fileUri,
        isUserMessage: isUserMessage,
        size: fileSize,
      );
    } else {
      return types.TextMessage(
        author: isUserMessage ? _user : _model,
        id: const Uuid().v4(),
        text: '未知消息类型',
      );
    }
  }

  // 创建文本消息对象
  types.TextMessage _createTextMessage({
    required String content,
    required bool isUserMessage,
    required String role,
  }) {
    // 创建文本消息对象
    return types.TextMessage(
      author: isUserMessage ? _user : _model,
      id: const Uuid().v4(),
      text: content,
      metadata: {'role': role},
    );
  }

  // 创建图片消息对象
  types.ImageMessage _createImageMessage({
    required String content,
    required bool isUserMessage,
    required int size,
  }) {
    // 创建图片消息对象
    return types.ImageMessage(
      author: isUserMessage ? _user : _model,
      id: const Uuid().v4(),
      uri: content,
      size: size,
      name: const Uuid().v4(),
    );
  }

  // 添加消息到列表
  Future<void> _addMessage(types.Message message) async {
    // 将消息插入列表头部
    setState(() => _messages.insert(0, message));
  }

  // 发送消息
  Future<void> _sendMessage(types.PartialText message) async {
    // 如果正在等待回复，则不发送消息
    if (_isWaitingForReply) return;

    // 设置等待回复状态
    setState(() {
      _isWaitingForReply = true;
    });

    // 创建文本消息
    final textMessage = _createTextMessage(
      content: message.text,
      isUserMessage: true,
      role: "user",
    );
    // 添加消息到列表
    await _addMessage(textMessage);
    // 将消息插入数据库
    await _insertMessageIntoDatabase(
      text: message.text,
      role: 'user',
    );

    // 尝试获取模型回复
    try {
      await _fetchModelResponse();
    } catch (err) {
      // 处理错误
      Log.e(err);
      final messageid = const Uuid().v4();
      const message = "系统错误，请稍后再试";
      final modelMessage = types.TextMessage(
        author: _model,
        id: messageid,
        text: message,
        metadata: const {'role': "assistant"},
      );
      // 添加或更新消息到列表
      _addOrUpdateMessage(modelMessage);
      // 将回复消息插入数据库
      _insertMessageIntoDatabase(
        text: message,
        role: 'assistant',
      );
    } finally {
      // 设置等待回复状态为 false
      if (mounted) {
        setState(() {
          _isWaitingForReply = false;
        });
      }
    }
  }

  // 将消息插入数据库
  Future<void> _insertMessageIntoDatabase({
    required String text,
    required String role,
    String contentType = 'text',
    int fileSize = 0,
  }) async {
    // 插入消息到数据库
    await database.into(database.chatContentTableData).insert(
          ChatContentTableDataCompanion.insert(
            parentid: int.parse(_user.id),
            title: appBarTitle,
            role: role,
            contentType: contentType,
            textarea:
                contentType == 'text' ? Value(text) : const Value.absent(),
            fileUri: contentType == 'file' ? Value(text) : const Value.absent(),
            fileSize: Value(fileSize),
          ),
        );
  }

  // 获取历史消息
  List<FunctionChatBodyMessage> _getHistoryMessages() {
    // Convert messages to the required format for Supabase API
    return _messages.reversed.map((message) {
      if (message is types.TextMessage) {
        return FunctionChatBodyMessage(
          content: message.text,
          role: message.metadata?['role'],
        );
      } else {
        return FunctionChatBodyMessage(
          content: "Unknown message type",
          role: message.metadata?['role'],
        );
      }
    }).toList();
  }

  // 获取模型回复
  Future<void> _fetchModelResponse() async {
    final completer = Completer<void>();

    final currentModelConfig =
        context.read<ModelConfigProvider>().currentModelConfig;
    final currentModel = context.read<ModelConfigProvider>().currentModel;

    final messages = _getHistoryMessages();
    // 调用 Supabase 函数
    final params = FunctionChatBody(
      messages: messages,
      model: currentModel.model,
      maxTokens: currentModelConfig.maxTokens,
      temperature: currentModelConfig.temperature,
      topP: currentModelConfig.topP,
    );
    FunctionResponse response = await supabase.functions.invoke(
      'function-chat/completions',
      body: params.toJson(),
    );
    final messageid = const Uuid().v4();
    String message = '';
    String buffer = '';
    // 监听回复消息
    response.data.transform(const Utf8Decoder()).listen(
      (chunk) {
        // 提取 JSON 片段
        buffer += chunk.toString();
        while (true) {
          final endOfEvent = buffer.indexOf('\n\n');
          if (endOfEvent == -1) {
            // 没有找到完整的事件块，等待更多数据
            break;
          }
          // 提取完整的事件块
          final event = buffer.substring(0, endOfEvent).trim();
          buffer = buffer.substring(endOfEvent + 2); // 跳过 \n\n
          if (event.isNotEmpty) {
            Log.d('原始字符串：$event');
            List<Map<String, dynamic>> jsonList =
                Util.extractJsonObjects(event);
            // 解析并打印 JSON 片段
            for (Map<String, dynamic> jsonData in jsonList) {
              if (jsonData['error'] != null) {
                message += jsonData['error']['message'];
              } else {
                try {
                  final messageContent = StreamChatMessage.fromJson(jsonData)
                          .choices[0]
                          .delta
                          .content ??
                      '';
                  message += messageContent;
                } catch (e) {
                  Log.e(e);
                }
              }
              // 创建文本消息对象
              final modelMessage = types.TextMessage(
                author: _model,
                id: messageid,
                text: message,
                metadata: const {'role': "assistant"},
              );
              // 添加或更新消息到列表
              _addOrUpdateMessage(modelMessage);
            }
          }
        }
      },
      onDone: () {
        if (message.isEmpty) {
          message = "获取消息错误，请稍后再试";
          final modelMessage = types.TextMessage(
            author: _model,
            id: messageid,
            text: message,
            metadata: const {'role': "assistant"},
          );
          // 添加或更新消息到列表
          _addOrUpdateMessage(modelMessage);
        }
        // 将回复消息插入数据库
        _insertMessageIntoDatabase(
          text: message,
          role: 'assistant',
        );
        // 结束 Completer
        completer.complete();
      },
      onError: (e) {
        message = "获取消息错误，请稍后再试";
        final modelMessage = types.TextMessage(
          author: _model,
          id: messageid,
          text: message,
          metadata: const {'role': "assistant"},
        );
        // 添加或更新消息到列表
        _addOrUpdateMessage(modelMessage);
        // 处理错误
        completer.completeError(e);
      },
    );
    // 返回 Completer 的 Future
    return completer.future;
  }

  // 添加或更新消息到列表
  void _addOrUpdateMessage(types.TextMessage message) {
    // 查找列表中是否存在相同的消息
    final index = _messages.indexWhere((m) => m.id == message.id);
    // 如果存在，则更新消息
    if (index != -1) {
      setState(() {
        _messages[index] = message;
      });
    } else {
      // 否则添加消息
      _addMessage(message);
    }
  }

  // 更新聊天标题
  Future<void> updateChatTitle(String chatId, String newTitle) async {
    try {
      // 将聊天 ID 转换为 int
      final int chatIdInt = int.parse(chatId);
      // 更新数据库中的聊天标题
      await (database.update(database.chatTableData)
            ..where((tbl) => tbl.id.equals(chatIdInt)))
          .write(ChatTableDataCompanion(
              title: Value(newTitle), isupdate: const Value(false)));
    } catch (e) {
      // 处理错误
      Log.e("Error updating chat title: $e");
    }
  }

  // 处理图片选择
  void _handleImageSelection() async {
    // 如果正在等待回复，则不处理
    if (_isWaitingForReply) return;
    // 选择图片
    final XFile? result = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
    );
    // 如果没有选择图片，则返回
    if (result == null) return;
    try {
      // 设置等待回复状态
      setState(() {
        _isWaitingForReply = true;
      });
      // 读取图片字节流
      final bytes = await result.readAsBytes();
      // 生成图片名称
      final imageName = '${const Uuid().v4()}${path.extension(result.path)}';
      final file = File(result.path);
      final storageFile =
          await supabase.storage.from('chat_images').upload(imageName, file);
      final imagePath =
          '${dotenv.get('SUPABASE_URL', fallback: null)}/storage/v1/object/public/$storageFile';
      // 创建图片消息对象
      final message = types.ImageMessage(
        author: _user,
        id: const Uuid().v4(),
        name: result.name,
        size: bytes.length,
        uri: imagePath,
      );
      // 添加消息到列表
      await _addMessage(message);
      // 将图片消息插入数据库
      await _insertMessageIntoDatabase(
        text: imagePath,
        role: 'user',
        contentType: 'file',
        fileSize: bytes.length,
      );
      // 获取模型回复
      await _fetchModelResponse();
    } catch (err) {
      // 处理错误
      Log.e(err);
    } finally {
      // 设置等待回复状态为 false
      if (mounted) {
        setState(() {
          _isWaitingForReply = false;
        });
      }
    }
  }

  // 获取发送按钮图标
  Widget _sendButtonIcon() {
    // 如果正在等待回复，则显示进度指示器
    if (_isWaitingForReply) {
      return const SizedBox(
        width: 20,
        height: 20,
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
        ),
      );
    } else {
      // 否则显示发送图标
      return const Icon(Icons.send, color: Colors.white);
    }
  }

  // 显示修改标题对话框
  Future<String?> _showEditTitleDialog(BuildContext context) async {
    // 初始化新标题
    String? newTitle;
    // 显示对话框
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('修改标题'),
          content: TextField(
            autofocus: true,
            maxLength: 10,
            decoration: const InputDecoration(hintText: '输入新的对话标题'),
            // 监听文本变化
            onChanged: (value) {
              newTitle = value;
            },
          ),
          actions: <Widget>[
            // 取消按钮
            TextButton(
              child: const Text('取消'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            // 确定按钮
            TextButton(
              child: const Text('确定'),
              onPressed: () {
                // 关闭对话框并返回新标题
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
        title: Text(appBarTitle),
        centerTitle: true,
        actions: <Widget>[
          // 修改标题按钮
          IconButton(
            icon: const Icon(Icons.draw),
            onPressed: () async {
              // 显示修改标题对话框
              final String? newTitle = await _showEditTitleDialog(context);
              // 如果有新标题，则更新标题
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
        // 聊天消息列表
        messages: _messages,
        // 发送消息回调函数
        onSendPressed: _sendMessage,
        // 添加附件回调函数
        // onAttachmentPressed: _handleImageSelection,
        // 用户信息
        user: _user,
        // 显示用户头像
        showUserAvatars: true,
        // 显示用户昵称
        showUserNames: true,
        // 中文本地化
        l10n: const ChatL10nZhCN(),
        // 聊天主题
        theme: DefaultChatTheme(
          primaryColor: Theme.of(context).primaryColor,
          sendButtonIcon: _sendButtonIcon(),
          attachmentButtonIcon: const Icon(
            Icons.add_photo_alternate_outlined,
            color: Colors.white,
          ),
          userAvatarNameColors: [Theme.of(context).primaryColor],
          receivedMessageBodyTextStyle: const TextStyle(fontSize: 14),
          sentMessageBodyTextStyle: const TextStyle(
            fontSize: 14,
            color: neutral7,
          ),
        ),
        // 输入框配置
        inputOptions: InputOptions(
          sendButtonVisibilityMode: SendButtonVisibilityMode.always,
          enabled: !_isWaitingForReply,
        ),
      ),
    );
  }
}
