import 'package:flutter/material.dart';
import 'package:flutter_chat_core/flutter_chat_core.dart';

class ChatImageMessage extends StatefulWidget {
  final ImageMessage message;
  const ChatImageMessage({
    super.key,
    required this.message,
  });

  @override
  ChatImageMessageState createState() => ChatImageMessageState();
}

class ChatImageMessageState extends State<ChatImageMessage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
