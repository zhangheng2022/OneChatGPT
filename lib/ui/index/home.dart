import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:one_chatgpt_flutter/database/database.dart';

class Home extends StatefulWidget {
  const Home({super.key});
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with AutomaticKeepAliveClientMixin {
  final database = AppDatabase();
  late Stream<List<ChatTableDataData>> _chatTableDataStream; // 声明一个流实例变量

  @override
  bool get wantKeepAlive => true;
  @override
  void initState() {
    super.initState();
    _chatTableDataStream = watchAllChatTables(); // 在 initState 中初始化流
  }

  Future<void> _addCardListData() async {
    try {
      await database
          .into(database.chatTableData)
          .insertReturning(ChatTableDataCompanion.insert());
    } catch (e) {
      // Handle errors or show an error message
    }
  }

  Future<void> _deleteCardListData(int id) async {
    try {
      await (database.delete(database.chatTableData)
            ..where((row) => row.id.isValue(id)))
          .go();
    } catch (e) {
      // Handle errors or show an error message
    }
  }

  Stream<List<ChatTableDataData>> watchAllChatTables() {
    // Assuming that the 'watch' method returns a Stream<List<ChatTableDataData>>
    // This is a common pattern with database watching in Flutter using packages like Drift.
    print("========================watchAllChatTables");
    return database.select(database.chatTableData).watch();
  }

  Future<void> test() async {
    // 假设我们更新第一个聊天数据的标题
    final firstChat = await database.select(database.chatTableData).getSingle();
    final updatedTitle = "updatedTitle"; // 创建一个基于当前时间的新标题，以确保它是唯一的

    await (database.update(database.chatTableData)
          ..where((tbl) => tbl.id.equals(firstChat.id)))
        .write(ChatTableDataCompanion(
      title: Value(updatedTitle),
    ));

    // 打印日志以确认方法被调用
    print("Test method executed: title updated to $updatedTitle");
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("对话"),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () async {
              test();
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addCardListData,
        tooltip: '新增对话',
        child: const Icon(Icons.add),
      ),
      body: StreamBuilder<List>(
        stream: _chatTableDataStream, // This is your hypothetical stream method
        builder: (context, snapshot) {
          print("========================snapshot");
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final List cardListData = snapshot.data!;
            print("========================cardListData${cardListData.length}");
            return ListView.builder(
              itemCount: cardListData.length,
              padding: const EdgeInsets.all(20),
              itemBuilder: (context, index) =>
                  _buildChatCard(context, cardListData[index]),
            );
          } else {
            return const Center(child: Text('No data available'));
          }
        },
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
