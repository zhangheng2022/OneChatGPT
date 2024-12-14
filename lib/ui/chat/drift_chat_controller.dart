import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_chat_core/flutter_chat_core.dart';
import 'package:one_chatgpt_flutter/database/database.dart';
import 'package:one_chatgpt_flutter/utils/log.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class DriftChatController implements ChatController {
  final String chatid;
  final AppDatabase database;

  DriftChatController({required this.database, required this.chatid}) {
    // 使用 Future.microtask 或在创建后立即调用
    Future.microtask(() => initMessagesList());
  }

  // AppDatabase database = Provider.of<AppDatabase>(context);
  // database = Provider.of<AppDatabase>(context);
  // initMessagesList();

  final _operationsController = StreamController<ChatOperation>.broadcast();

  final User _modelAuthor = User(
    id: const Uuid().v4(),
    firstName: "firstName",
    lastName: "lastName",
  );

  late User _userAuthor;

  List<Message> messagesList = [];

  Future<void> initMessagesList() async {
    _userAuthor = User(
      id: chatid,
      firstName: "firstName",
      lastName: "lastName",
    );

    final messages = await (database.select(database.chatContentTableData)
          ..where((tbl) => tbl.parentid.equals(int.parse(chatid))))
        .get();
    if (messages.isEmpty) {
      Message welcomeMessage = Message.text(
        id: const Uuid().v4(),
        author: _modelAuthor,
        createdAt: DateTime.now(),
        text: "你好，有什么可以帮你的吗？",
      );
      await insert(welcomeMessage);
    } else {
      // 将数据库中的消息转换为 Message 对象
      messagesList = messages
          .map(
            (msg) => Message.text(
              id: msg.id.toString(),
              author: _modelAuthor,
              createdAt: msg.datetime,
              text: msg.content ?? '',
            ),
          )
          .toList();
    }
  }

  @override
  List<Message> get messages => messagesList;

  @override
  Stream<ChatOperation> get operationsStream => _operationsController.stream;

  @override
  Future<void> insert(Message message, {int? index}) async {
    // 插入到数据库
    // await database.into(database.chatContentTableData).insert(
    //       ChatContentTableDataCompanion.insert(
    //         id: Value.absent(),
    //         parentid: int.parse(chatid),
    //         content: message.text,
    //         role: 'user', // 根据实际情况设置
    //         createTime: DateTime.now(),
    //       ),
    //     );
    // 更新内存中的消息列表
    messagesList.add(message);

    // 通知操作流
    _operationsController.add(
      ChatOperation.insert(message, index ?? messagesList.length - 1),
    );
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
  Future<void> dispose() async {
    // TODO: Implement dispose
    _operationsController.close();
  }
}
