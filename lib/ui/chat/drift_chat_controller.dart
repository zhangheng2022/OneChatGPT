import 'dart:async';
import 'dart:convert';
import 'package:drift/drift.dart';
import 'package:flutter_chat_core/flutter_chat_core.dart';
import 'package:one_chatgpt_flutter/database/chat_record.dart';
import 'package:one_chatgpt_flutter/database/database.dart';
import 'package:one_chatgpt_flutter/utils/log.dart';
import 'package:uuid/uuid.dart';

class DriftChatController implements ChatController {
  static const Map<PresetEnum, String> _welcomeMessages = {
    PresetEnum.chat: "你好，有什么可以帮你的吗？",
    PresetEnum.createImage: "你好，有什么需要生成的吗？",
  };

  final AppDatabase database;
  final String chatId;
  final _operationsController = StreamController<ChatOperation>.broadcast();
  List<Message> messagesList = [];

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
      final chatRecord = await database.managers.chatRecord
          .filter((row) => row.id.equals(int.parse(chatId)))
          .getSingle();
      Message welcomeMessage = Message.text(
          id: const Uuid().v4(),
          author: User(id: 'assistant'),
          createdAt: DateTime.now(),
          text: _welcomeMessages[chatRecord.preset]);
      await insert(welcomeMessage);
    }
  }

  @override
  Future<void> insert(Message message, {int? index}) async {
    await database.managers.chatRecordDetail.create(
      (row) => row(
        chatId: int.parse(chatId),
        messageId: message.id,
        message: jsonEncode(message.toJson()),
      ),
    );
    if (message is TextMessage && message.text.isNotEmpty) {
      await database.managers.chatRecord
          .filter((row) => row.id.equals(int.parse(chatId)))
          .update((row) => row(title: Value(message.text)));
    }
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
          .filter((row) => row.messageId.equals(oldMessage.id))
          .getSingle();
      await database.managers.chatRecordDetail.replace(
        recordRow.copyWith(message: jsonEncode(newMessage.toJson())),
      );
      messagesList[index] = newMessage;
      _operationsController.add(ChatOperation.update(oldMessage, newMessage));
    } else {
      Log.e('更新失败,缺少需要更新的消息');
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
          messageId: message.id,
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
