import 'package:flutter/material.dart';
import 'package:one_chatgpt_flutter/database/database.dart';
import 'package:one_chatgpt_flutter/ui/chat/drift_chat_controller.dart';
import 'package:one_chatgpt_flutter/ui/chat/widgets/chat_custom_input.dart';
import 'package:one_chatgpt_flutter/ui/chat/widgets/chat_text_message.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_chat_core/flutter_chat_core.dart';
import 'package:one_chatgpt_flutter/utils/log.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class ChatHome extends StatefulWidget {
  final String chatId;
  const ChatHome({super.key, required this.chatId});

  @override
  State<ChatHome> createState() => _ChatHomeState();
}

class _ChatHomeState extends State<ChatHome> {
  final _scrollController = ScrollController();

  late final ChatController _chatController;

  void _handleMessageSend(String text) async {
    await _chatController.insert(
      TextMessage(
        id: const Uuid().v4(),
        author: User(id: widget.chatId),
        createdAt: DateTime.now(),
        text: text,
        metadata: {'role': 'user'},
      ),
    );
  }

  void _handleAttachmentTap() async {
    // final picker = ImagePicker();

    // final image = await picker.pickImage(source: ImageSource.gallery);

    // if (image == null) return;

    // await _crossCache.downloadAndSave(image.path);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _chatController = DriftChatController(
      database: Provider.of<AppDatabase>(context),
      chatId: widget.chatId,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              'assets/logos/logo.png',
              width: 30,
              height: 30,
            ),
            SizedBox(width: 10),
            Text("聊一聊"),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
      body: Chat(
        builders: Builders(
          textMessageBuilder: (context, message) =>
              ChatTextMessage(message: message),
          inputBuilder: (context) => ChatCustomInput(),
        ),
        onMessageSend: _handleMessageSend,
        onAttachmentTap: _handleAttachmentTap,
        chatController: _chatController,
        user: User(id: widget.chatId),
        scrollController: _scrollController,
        themeMode: ThemeMode.light,
      ),
    );
  }
}
