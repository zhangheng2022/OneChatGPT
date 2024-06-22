import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:one_chatgpt_flutter/database/database.dart';

class Home extends StatefulWidget {
  const Home({super.key});
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final database = AppDatabase();
  List _cardListData = [];

  @override
  void initState() {
    super.initState();
    _initCardListData();
  }

  Future<void> _initCardListData() async {
    try {
      final allChatTables = await database.select(database.chatTableData).get();
      setState(() {
        _cardListData = allChatTables;
      });
    } catch (e) {
      // Handle errors or show an error message
    }
  }

  Future<void> _addCardListData() async {
    try {
      final insertResult = await database
          .into(database.chatTableData)
          .insertReturning(ChatTableDataCompanion.insert());
      setState(() {
        _cardListData.add(insertResult);
      });
    } catch (e) {
      // Handle errors or show an error message
    }
  }

  Future<void> _deleteCardListData(int id) async {
    try {
      await (database.delete(database.chatTableData)
            ..where((row) => row.id.isValue(id)))
          .go();
      setState(() {
        _cardListData.removeWhere((chat) => chat.id == id);
      });
    } catch (e) {
      // Handle errors or show an error message
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("对话"),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addCardListData,
        tooltip: '新增对话',
        child: const Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: _cardListData.length,
        padding: const EdgeInsets.all(20),
        itemBuilder: (context, index) =>
            _buildChatCard(context, _cardListData[index]),
      ),
    );
  }

  Widget _buildChatCard(BuildContext context, chatData) {
    return Card(
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
          context.goNamed('chat',
              pathParameters: {'chatid': chatData.id.toString()});
        },
      ),
    );
  }
}
