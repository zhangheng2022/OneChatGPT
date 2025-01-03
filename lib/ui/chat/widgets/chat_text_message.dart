import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:provider/provider.dart';
import 'package:flutter_chat_core/flutter_chat_core.dart';
import 'package:intl/intl.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

final supabaseUrl = dotenv.get('SUPABASE_URL', fallback: null);

class ChatTextMessage extends StatelessWidget {
  final TextMessage message;
  final int index;

  const ChatTextMessage({
    super.key,
    required this.index,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    final isUser = context.watch<User>().id == message.author.id;
    final messageStatus = message.metadata?['status'];

    return Container(
      width: isUser ? null : double.infinity,
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
          if (messageStatus == 'init') ...[
            Column(
              spacing: 6,
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Shimmer(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primaryFixed,
                      borderRadius: BorderRadius.circular(2),
                    ),
                    height: 20,
                    width: double.infinity,
                  ),
                ),
                Shimmer(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primaryFixed,
                      borderRadius: BorderRadius.circular(2),
                    ),
                    height: 20,
                    width: 200,
                  ),
                ),
              ],
            ),
          ] else ...[
            MarkdownBody(
              data: message.text,
              selectable: true,
              styleSheet: MarkdownStyleSheet(
                textScaler: TextScaler.linear(1.2),
              ),
            ),
          ],
          if (!isUser && messageStatus == null) ...[
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    InkWell(
                      onTap: () {
                        Clipboard.setData(ClipboardData(text: message.text));
                        SmartDialog.showToast(
                          '复制成功',
                          alignment: Alignment.center,
                        );
                      },
                      child: Icon(
                        Icons.copy_all,
                        size: 20,
                      ),
                    ),
                    SizedBox(width: 20),
                    InkWell(
                      child: Icon(
                        Icons.volume_up_outlined,
                        size: 20,
                      ),
                    ),
                  ],
                ),
                Text(
                  DateFormat('MM-dd HH:mm').format(message.createdAt),
                  style: TextStyle(
                    fontSize: 10,
                    color: Theme.of(context).colorScheme.inversePrimary,
                  ),
                )
              ],
            )
          ],
        ],
      ),
    );
  }
}
