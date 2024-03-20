import 'dart:convert';
import 'dart:math';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:image_picker/image_picker.dart';

final supabase = Supabase.instance.client;
final User? user = supabase.auth.currentUser;

String randomString() {
  final random = Random.secure();
  final values = List<int>.generate(16, (i) => random.nextInt(255));
  return base64UrlEncode(values);
}

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final List<types.Message> _messages = [];

  final _user = types.User(
    id: user!.id,
  );
  final _chatuser = types.User(
    id: "123123123123123",
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("新的对话"),
          centerTitle: true,
        ),
        body: SafeArea(
          bottom: false,
          child: Chat(
            messages: _messages,
            onSendPressed: _handleSendPressed,
            onAttachmentPressed: _handleImageSelection,
            l10n: const ChatL10nZhCN(),
            user: _user,
          ),
        ));
  }

  Future<void> _handleImageSelection() async {
    final result = await ImagePicker().pickImage(
      imageQuality: 70,
      maxWidth: 1440,
      source: ImageSource.gallery,
    );

    if (result != null) {
      final bytes = await result.readAsBytes();
      final image = await decodeImageFromList(bytes);

      final message = types.ImageMessage(
        author: _user,
        createdAt: DateTime.now().millisecondsSinceEpoch,
        height: image.height.toDouble(),
        id: randomString(),
        name: result.name,
        size: bytes.length,
        uri: result.path,
        width: image.width.toDouble(),
      );

      _addMessage(message);
    }
  }

  Future<void> _addMessage(types.Message message) async {
    setState(() {
      _messages.insert(0, message);
    });
  }

  Future<void> _handleSendPressed(types.PartialText message) async {
    final textMessage = types.TextMessage(
      author: _user,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: randomString(),
      text: message.text,
    );
    _addMessage(textMessage);
    try {
      final res = await supabase.functions.invoke(
        'google/gemini-pro',
        body: {'message': message.text},
      );
      final data = res.data;
      final chatMessage = types.TextMessage(
        author: _chatuser,
        createdAt: DateTime.now().millisecondsSinceEpoch,
        id: randomString(),
        text: data['text'],
      );
      _addMessage(chatMessage);
    } catch (e) {
      print(e);
    }
  }
}
