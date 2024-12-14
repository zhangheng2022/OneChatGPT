import 'package:flutter/material.dart';
import 'package:flutter_chat_core/flutter_chat_core.dart';
import 'package:one_chatgpt_flutter/database/database.dart';
import 'package:provider/provider.dart';

class DriftChatController implements ChatController {
  late AppDatabase database;

  DriftChatController(BuildContext context) {
    database = Provider.of<AppDatabase>(context);
  }

  @override
  Future<void> insert(Message message, {int? index}) async {
    // TODO: Implement insert
  }

  @override
  Future<void> dispose() async {
    // TODO: Implement dispose
  }

  @override
  Future<void> remove(Message message) async {
    // TODO: Implement remove
  }

  @override
  Future<void> set(List<Message> messages) async {
    // TODO: Implement set
  }

  @override
  Future<void> update(Message oldMessage, Message newMessage) async {
    // TODO: Implement update
  }

  @override
  List<Message> get messages {
    return [];
  }

  @override
  Stream<ChatOperation> get operationsStream => Stream.empty();
}
