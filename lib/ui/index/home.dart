import 'dart:async';
import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:one_chatgpt_flutter/database/database.dart';
import 'package:one_chatgpt_flutter/utils/log.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late AppDatabase _database;

  Stream<List<ChatRecordData>> _chatList = Stream<List<ChatRecordData>>.empty();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _database = Provider.of<AppDatabase>(context);
    _chatList = _database.managers.chatRecord.watch();
  }

  Future<void> _addChat() async {
    try {
      await _database.managers.chatRecord
          .create((row) => row(title: drift.Value('新的话题')));
    } catch (e) {
      debugPrint('Error adding chat: $e');
    }
  }

  Future<void> _deleteChat(int id) async {
    try {
      await _database.managers.chatRecord
          .filter((f) => f.id.equals(id))
          .delete();
    } catch (e) {
      debugPrint('Error deleting chat: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("对话"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addChat,
        tooltip: '新增对话',
        child: const Icon(Icons.add_comment),
      ),
      body: StreamBuilder<List<ChatRecordData>>(
        stream: _chatList,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const EmptyState();
          } else {
            return ChatList(
              listKey: GlobalKey<AnimatedListState>(),
              chatList: snapshot.data!,
              onDelete: _deleteChat,
            );
          }
        },
      ),
    );
  }
}

class EmptyState extends StatelessWidget {
  const EmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "assets/icons/not_message.png",
            height: 200,
            fit: BoxFit.cover,
          ),
          Text(
            '点击右下角+新增对话',
            style: TextStyle(
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
        ],
      ),
    );
  }
}

class ChatList extends StatelessWidget {
  final GlobalKey<AnimatedListState> listKey;
  final List<ChatRecordData> chatList;
  final Function(int) onDelete;

  const ChatList({
    super.key,
    required this.listKey,
    required this.chatList,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedList(
      key: listKey,
      padding: const EdgeInsets.all(20),
      initialItemCount: chatList.length,
      itemBuilder: (context, index, animation) {
        return _buildChatCard(
          context: context,
          chatData: chatList[index],
          animation: animation,
        );
      },
    );
  }

  Widget _buildChatCard({
    required BuildContext context,
    required ChatRecordData chatData,
    required Animation<double> animation,
  }) {
    return SizeTransition(
      sizeFactor: animation,
      child: Card(
        elevation: 0,
        margin: const EdgeInsets.only(bottom: 20),
        child: ListTile(
          leading: Icon(
            Icons.smart_toy,
            color: Theme.of(context).colorScheme.primary,
          ),
          title: Text(
            chatData.title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
          subtitle: Text(
            DateFormat.Hm().format(chatData.createdAt),
            style: TextStyle(
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
          trailing: IconButton(
            onPressed: () => onDelete(chatData.id),
            icon: Icon(
              Icons.delete_outline,
              color: Theme.of(context).colorScheme.error,
            ),
          ),
          onTap: () {
            context.goNamed(
              'chat',
              pathParameters: {'chatId': chatData.id.toString()},
            );
          },
        ),
      ),
    );
  }
}
