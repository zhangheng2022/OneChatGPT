import 'package:flutter/material.dart';
import 'package:one_chatgpt_flutter/database/database.dart';
import 'package:one_chatgpt_flutter/ui/chat/drift_chat_controller.dart';
import 'package:one_chatgpt_flutter/ui/chat/widgets/chat_text_message.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:cross_cache/cross_cache.dart';
import 'package:flutter_chat_core/flutter_chat_core.dart';
import 'package:one_chatgpt_flutter/utils/log.dart';
import 'package:provider/provider.dart';

class ChatHome extends StatefulWidget {
  final String chatid;
  const ChatHome({super.key, required this.chatid});

  @override
  State<ChatHome> createState() => _ChatHomeState();
}

class _ChatHomeState extends State<ChatHome> {
  // final _uuid = const Uuid().v4();
  final _crossCache = CrossCache();
  final _scrollController = ScrollController();

  late final ChatController _chatController;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _chatController = DriftChatController(
      database: Provider.of<AppDatabase>(context),
      chatid: widget.chatid,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chat"),
      ),
      body: Chat(
        onMessageSend: (text) {
          Log.i(text);
        },
        chatController: _chatController,
        user: User(id: widget.chatid),
        crossCache: _crossCache,
        scrollController: _scrollController,
      ),
    );
  }
}
