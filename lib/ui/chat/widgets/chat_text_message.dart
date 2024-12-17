import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:provider/provider.dart';
import 'package:flutter_chat_core/flutter_chat_core.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart' show Share;

class ChatTextMessage extends StatelessWidget {
  final TextMessage message;
  final EdgeInsetsGeometry? padding;
  final BorderRadiusGeometry? borderRadius;
  final VoidCallback? onLongPress;

  const ChatTextMessage({
    super.key,
    required this.message,
    this.padding = const EdgeInsets.symmetric(
      horizontal: 16,
      vertical: 10,
    ),
    this.borderRadius = const BorderRadius.all(Radius.circular(12)),
    this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    final textMessageTheme =
        context.select((ChatTheme theme) => theme.textMessageTheme);
    final isSentByMe = context.watch<User>().id == message.author.id;

    return GestureDetector(
      onLongPress: onLongPress ??
          () {
            _showMessageOptions(context);
          },
      child: Column(
        crossAxisAlignment:
            isSentByMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Container(
            padding: padding,
            decoration: BoxDecoration(
              color: isSentByMe
                  ? textMessageTheme.sentBackgroundColor
                  : textMessageTheme.receivedBackgroundColor,
              borderRadius: borderRadius,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 3,
                  offset: Offset(0, 1),
                ),
              ],
            ),
            child: MarkdownBody(
              data: message.text,
              styleSheet: MarkdownStyleSheet(
                p: isSentByMe
                    ? textMessageTheme.sentTextStyle
                    : textMessageTheme.receivedTextStyle,
                code: TextStyle(
                  backgroundColor: Colors.grey[200],
                  fontFamily: 'monospace',
                  fontSize: 14,
                ),
                blockquote: TextStyle(
                  color: Colors.grey[700],
                  fontStyle: FontStyle.italic,
                ),
              ),
              onTapLink: (text, href, title) {
                if (href != null) {
                  launchUrl(Uri.parse(href));
                }
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 4),
            child: Text(
              _formatMessageTime(message.createdAt),
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _formatMessageTime(DateTime dateTime) {
    return DateFormat('HH:mm').format(dateTime);
  }

  void _showMessageOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: Icon(Icons.copy),
            title: Text('复制'),
            onTap: () {
              Clipboard.setData(ClipboardData(text: message.text));
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.reply),
            title: Text('回复'),
            onTap: () {
              // TODO: 实现回复功能
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.share),
            title: Text('分享'),
            onTap: () async {
              await Share.share(message.text);
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
