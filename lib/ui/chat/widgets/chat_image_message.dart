import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_chat_core/flutter_chat_core.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

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
  void initState() {
    super.initState();
    debugPrint(widget.message.toString());
  }

  @override
  Widget build(BuildContext context) {
    final message = widget.message;
    Uint8List imageBytes = base64Decode(message.source);
    final isUser = context.watch<User>().id == message.author.id;
    final isInitMessage = message.metadata?.containsKey('init') ?? false;

    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: isUser
            ? Theme.of(context).colorScheme.primaryContainer
            : Theme.of(context).colorScheme.surfaceContainer,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
          bottomLeft: Radius.circular(isUser ? 12 : 0),
          bottomRight: Radius.circular(isUser ? 0 : 12),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.memory(
            imageBytes,
            width: 200,
            fit: BoxFit.fitWidth,
          ),
          SizedBox(height: 10),
          SizedBox(
            width: 200,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                InkWell(
                  onTap: () {},
                  child: Icon(
                    Icons.download_outlined,
                    size: 20,
                  ),
                ),
                Text(
                  DateFormat('MM-dd HH:mm').format(message.createdAt),
                  style: TextStyle(
                    fontSize: 10,
                    color: Theme.of(context).colorScheme.inversePrimary,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
