import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:provider/provider.dart';
import 'package:flutter_chat_core/flutter_chat_core.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart' show Share;

final supabaseUrl = dotenv.get('SUPABASE_URL', fallback: null);

class ChatTextMessage extends StatelessWidget {
  final TextMessage message;

  const ChatTextMessage({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    final textMessageTheme =
        context.select((ChatTheme theme) => theme.textMessageTheme);
    final isSentByMe = context.watch<User>().id == message.author.id;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainer,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
          bottomLeft: Radius.circular(0),
          bottomRight: Radius.circular(12),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MarkdownBody(
            data: message.text,
            styleSheet: MarkdownStyleSheet(
              textScaler: TextScaler.linear(1.2),
            ),
          ),
          SizedBox(height: 10),
          Row(
            children: [
              InkWell(
                child: Icon(
                  Icons.copy_all,
                  size: 20,
                ),
              ),
              SizedBox(width: 20),
              InkWell(
                child: Icon(
                  Icons.volume_up,
                  size: 20,
                ),
              ),
            ],
          )
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
