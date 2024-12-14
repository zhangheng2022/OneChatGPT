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
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  final List<ChatTableDataData> _chatList = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _database = Provider.of<AppDatabase>(context);
    _loadChatList();
  }

  Future<void> _loadChatList() async {
    try {
      final data = await _database.select(_database.chatTableData).get();
      Log.i('data: $data');
      setState(() {
        _chatList
          ..clear()
          ..addAll(data);
      });
    } catch (e) {
      debugPrint('Error loading chat list: $e');
    }
  }

  Future<void> _addChat() async {
    try {
      final newChat = await _database
          .into(_database.chatTableData)
          .insertReturning(ChatTableDataCompanion.insert());

      setState(() {
        _chatList.add(newChat);
        _listKey.currentState?.insertItem(_chatList.length - 1);
      });

      context.goNamed(
        'chat',
        pathParameters: {'chatid': newChat.id.toString()},
      );
    } catch (e) {
      debugPrint('Error adding chat: $e');
    }
  }

  Future<void> _deleteChat(int id) async {
    try {
      final index = _chatList.indexWhere((chat) => chat.id == id);
      if (index != -1) {
        await (_database.delete(_database.chatTableData)
              ..where((row) => row.id.equals(id)))
            .go();

        setState(() {
          final removedItem = _chatList.removeAt(index);
          _listKey.currentState?.removeItem(
            index,
            (context, animation) => ChatList(
              listKey: _listKey,
              chatList: _chatList,
              onDelete: _deleteChat,
            )._buildChatCard(
              context: context,
              chatData: removedItem,
              animation: animation,
            ),
            duration: const Duration(milliseconds: 300),
          );
        });
      }
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
      body: _chatList.isEmpty
          ? const EmptyState()
          : ChatList(
              listKey: _listKey,
              chatList: _chatList,
              onDelete: _deleteChat,
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
  final List<ChatTableDataData> chatList;
  final Function(int) onDelete;

  const ChatList({
    super.key,
    required this.listKey,
    required this.chatList,
    required this.onDelete,
  });

  String _getGroupTitle(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    final dateToCompare = DateTime(date.year, date.month, date.day);

    if (dateToCompare == today) {
      return '今天';
    } else if (dateToCompare == yesterday) {
      return '昨天';
    } else if (now.difference(date).inDays <= 7) {
      return '一周内';
    } else if (now.difference(date).inDays <= 30) {
      return '一个月内';
    } else {
      return '更早';
    }
  }

  Map<String, List<ChatTableDataData>> _groupChats() {
    final groups = <String, List<ChatTableDataData>>{};

    for (var chat in chatList) {
      final groupTitle = _getGroupTitle(chat.datetime);
      groups.putIfAbsent(groupTitle, () => []).add(chat);
    }

    // Sort chats within each group by datetime in descending order
    groups.forEach((key, value) {
      value.sort((a, b) => b.datetime.compareTo(a.datetime));
    });

    return groups;
  }

  @override
  Widget build(BuildContext context) {
    final groupedChats = _groupChats();
    final groups = groupedChats.keys.toList();

    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: groups.length,
      itemBuilder: (context, groupIndex) {
        final groupTitle = groups[groupIndex];
        final chatsInGroup = groupedChats[groupTitle]!;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16, bottom: 8),
              child: Text(
                groupTitle,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
            ),
            ...chatsInGroup.map((chat) => _buildChatCard(
                  context: context,
                  chatData: chat,
                  animation: const AlwaysStoppedAnimation(1),
                )),
            const SizedBox(height: 16),
          ],
        );
      },
    );
  }

  Widget _buildChatCard({
    required BuildContext context,
    required ChatTableDataData chatData,
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
            DateFormat.Hm().format(chatData.datetime),
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
              pathParameters: {'chatid': chatData.id.toString()},
            );
          },
        ),
      ),
    );
  }
}
