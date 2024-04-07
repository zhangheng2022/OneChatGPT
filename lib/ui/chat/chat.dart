import 'dart:convert';
import 'dart:math';
import 'package:drift/drift.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
import 'package:one_chatgpt_flutter/database/database.dart';
import 'package:one_chatgpt_flutter/models/response/chat_message.dart';

final supabase = Supabase.instance.client;
final User? user = supabase.auth.currentUser;
final database = AppDatabase();
const uuid = Uuid();

String randomString() {
  final random = Random.secure();
  final values = List<int>.generate(16, (i) => random.nextInt(255));
  return base64UrlEncode(values);
}

class ChatPage extends StatefulWidget {
  const ChatPage({super.key, required this.chatid});

  final String chatid;

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final List<types.Message> _messages = [];

  types.User _user = const types.User(
    id: "",
  );
  final _model = types.User(
    id: uuid.v4(),
  );

  @override
  void initState() {
    super.initState();
    _user = types.User(
      id: widget.chatid,
    );
    initMessage();
  }

  Future<void> initMessage() async {
    List<ChatContentTable> messages =
        await database.select(database.chatContentTables).get();
    print(messages);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("新的对话"),
          centerTitle: true,
        ),
        body: Chat(
          messages: _messages,
          onSendPressed: _handleSendPressed,
          onAttachmentPressed: _handleImageSelection,
          l10n: const ChatL10nZhCN(),
          user: _user,
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
    try {
      String title = "新的对话";
      final textMessage = types.TextMessage(
        author: _user,
        id: randomString(),
        text: message.text,
      );
      _addMessage(textMessage);
      await database.into(database.chatContentTables).insert(
            ChatContentTablesCompanion.insert(
              title: title,
              content: message.text,
              parentid: int.parse(_user.id),
              contentType: 'user',
            ),
          );

      final res = await supabase.functions.invoke(
        'google/gemini-pro',
        body: {'message': message.text},
      );
      ChatMessage data = res.data;
      if (data.text.isNotEmpty) {
        title = await _updateTitle();
      }

      final chatMessage = types.TextMessage(
        author: _model,
        id: randomString(),
        text: data.text,
      );
      _addMessage(chatMessage);

      await database.into(database.chatContentTables).insert(
            ChatContentTablesCompanion.insert(
              title: title,
              content: message.text,
              parentid: int.parse(_model.id),
              contentType: 'model',
            ),
          );
    } catch (err) {
      print(err);
    }
  }

  Future<String> _updateTitle() async {
    final res = await supabase.functions
        .invoke('google/chat-title', method: HttpMethod.get);
    ChatMessage data = res.data;
    (database.update(database.chatTables)
          ..where((t) => t.id.isValue(int.parse(_user.id))))
        .write(ChatTablesCompanion(
      title: Value(data.text),
    ));
    return data.text;
  }
}
