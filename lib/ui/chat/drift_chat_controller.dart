import 'dart:async';
import 'dart:convert';
import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_core/flutter_chat_core.dart';
import 'package:one_chatgpt_flutter/database/database.dart';
import 'package:uuid/uuid.dart';

class DriftChatController implements ChatController {
  final AppDatabase database;
  final String chatId;
  final _operationsController = StreamController<ChatOperation>.broadcast();
  List<Message> messagesList = [];

  final _userAuthor = User(id: 'me');
  final _modelAuthor = User(id: 'model');

  DriftChatController({required this.database, required this.chatId}) {
    Future.microtask(() => _loadMessages());
  }

  Future<void> _loadMessages() async {
    final messages = await database.managers.chatRecordDetail
        .filter((row) => row.chatId.equals(int.parse(chatId)))
        .get();
    if (messages.isNotEmpty) {
      messagesList = messages
          .map((row) => Message.fromJson(jsonDecode(row.message)))
          .toList();
      _operationsController.add(ChatOperation.set());
    }
    if (messages.isEmpty) {
      Message welcomeMessage = Message.text(
        id: const Uuid().v4(),
        author: _modelAuthor,
        createdAt: DateTime.now(),
        text: "你好，有什么可以帮你的吗？",
        metadata: {'role': 'assistant'},
      );
      await insert(welcomeMessage);
    }
  }

  @override
  Future<void> insert(Message message, {int? index}) async {
    await database.managers.chatRecordDetail.create(
      (row) => row(
        chatId: int.parse(chatId),
        message: jsonEncode(message.toJson()),
      ),
    );
    messagesList.add(message);
    _operationsController.add(
      ChatOperation.insert(message, index ?? messagesList.length - 1),
    );
  }

  @override
  Future<void> remove(Message message) async {
    final index = messagesList.indexWhere((msg) => msg.id == message.id);
    if (index != -1) {
      await database.managers.chatRecordDetail
          .filter((row) => row.id.equals(int.parse(message.id)))
          .delete();
      messagesList.removeAt(index);
      _operationsController.add(ChatOperation.remove(message, index));
    }
  }

  @override
  Future<void> update(Message oldMessage, Message newMessage) async {
    if (oldMessage == newMessage) return;

    final index = messagesList.indexWhere((msg) => msg.id == oldMessage.id);
    if (index != -1) {
      final recordRow = await database.managers.chatRecordDetail
          .filter((row) => row.id.equals(int.parse(oldMessage.id)))
          .getSingle();
      await database.managers.chatRecordDetail.replace(
        recordRow.copyWith(message: jsonEncode(newMessage.toJson())),
      );
      messagesList[index] = newMessage;
      _operationsController.add(ChatOperation.update(oldMessage, newMessage));
    }
  }

  @override
  Future<void> set(List<Message> messages) async {
    await database.managers.chatRecordDetail
        .filter((row) => row.chatId.equals(int.parse(chatId)))
        .delete();
    await database.managers.chatRecordDetail.bulkCreate(
      (row) => messages.map(
        (message) => row(
          chatId: int.parse(chatId),
          message: jsonEncode(message.toJson()),
        ),
      ),
    );
    messagesList = messages;
    _operationsController.add(ChatOperation.set());
  }

  @override
  List<Message> get messages => messagesList;

  @override
  Stream<ChatOperation> get operationsStream => _operationsController.stream;

  @override
  void dispose() {
    _operationsController.close();
  }
}
