import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_chat_core/flutter_chat_core.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class ChatImageMessage extends StatefulWidget {
  final ImageMessage message;
  final int index;
  const ChatImageMessage({
    super.key,
    required this.index,
    required this.message,
  });

  @override
  ChatImageMessageState createState() => ChatImageMessageState();
}

class ChatImageMessageState extends State<ChatImageMessage> {
  static const Map<String, String> _messageStatusEnum = {
    'init': "图片正在生成，请稍候",
    'stop': "图片已停止生成",
    'error': "图片生成失败",
  };

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
    final messageStatus = message.metadata?['status'];

    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: isUser
            ? Theme.of(context).colorScheme.primaryContainer
            : Theme.of(context).colorScheme.surfaceContainer,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
          bottomLeft: Radius.circular(isUser ? 10 : 0),
          bottomRight: Radius.circular(isUser ? 0 : 10),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (messageStatus != null) ...[
            Shimmer(
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryFixed,
                  borderRadius: BorderRadius.circular(10),
                ),
                height: 200,
                width: 200,
                child: Center(
                  child: Text(
                    _messageStatusEnum[messageStatus] ?? "",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.inversePrimary,
                    ),
                  ),
                ),
              ),
            ),
          ],
          if (messageStatus == null) ...[
            Image.memory(
              imageBytes,
              filterQuality: FilterQuality.high,
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
        ],
      ),
    );
  }
}
