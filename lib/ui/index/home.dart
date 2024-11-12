import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:one_chatgpt_flutter/database/database.dart';
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
    final data = await _database.select(_database.chatTableData).get();
    setState(() {
      _chatList.clear();
      _chatList.addAll(data);
    });
  }

  Future<void> _addCardListData() async {
    try {
      final newChat = await _database
          .into(_database.chatTableData)
          .insertReturning(ChatTableDataCompanion.insert());
      setState(() {
        _chatList.add(newChat);
        _listKey.currentState?.insertItem(_chatList.length - 1);
      });
    } catch (e) {
      debugPrint('Error adding card list data: $e');
    }
  }

  Future<void> _deleteCardListData(int id) async {
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
            (context, animation) =>
                _buildChatCard(context, removedItem, animation),
            duration: const Duration(milliseconds: 300),
          );
        });
      }
    } catch (e) {
      debugPrint('Error deleting card list data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text("对话"),
        backgroundColor: Colors.grey[50],
        leading: const Icon(Icons.model_training),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addCardListData,
        tooltip: '新增对话',
        child: const Icon(Icons.add_comment),
      ),
      body: _chatList.isEmpty
          ? _buildEmptyState()
          : AnimatedList(
              key: _listKey,
              initialItemCount: _chatList.length,
              padding: const EdgeInsets.all(20),
              itemBuilder: (context, index, animation) =>
                  _buildChatCard(context, _chatList[index], animation),
            ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "assets/icons/not_message.png",
            height: 200,
            fit: BoxFit.cover,
          ),
          const Text(
            '点击右下角+新增对话',
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _buildChatCard(BuildContext context, ChatTableDataData chatData,
      Animation<double> animation) {
    return SizeTransition(
      sizeFactor: animation,
      child: Card(
        elevation: 0,
        color: Theme.of(context).colorScheme.tertiary,
        margin: const EdgeInsets.only(bottom: 20),
        child: ListTile(
          leading: const Icon(Icons.smart_toy),
          title: Text(
            chatData.title,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            DateFormat.MMMEd().add_Hm().format(chatData.datetime),
            style: const TextStyle(color: Colors.grey),
          ),
          trailing: IconButton(
            onPressed: () => _deleteCardListData(chatData.id),
            icon: const Icon(Icons.delete_outline),
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
