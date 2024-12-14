import 'package:flutter/material.dart';
import 'package:one_chatgpt_flutter/ui/chat/drift_chat_controller.dart';
import 'package:one_chatgpt_flutter/ui/chat/widgets/chat_text_message.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:cross_cache/cross_cache.dart';
import 'package:flutter_chat_core/flutter_chat_core.dart';

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

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chat"),
      ),
      body: Chat(
        builders: Builders(
          textMessageBuilder: (context, message) =>
              ChatTextMessage(message: message),
        ),
        chatController: DriftChatController(context),
        user: User(id: widget.chatid),
        crossCache: _crossCache,
        scrollController: _scrollController,
      ),
    );
  }
}
