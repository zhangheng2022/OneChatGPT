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
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _database = Provider.of<AppDatabase>(context); // Initialize _database here
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _addCardListData() async {
    try {
      await _database.into(_database.chatTableData).insertReturning(
            ChatTableDataCompanion.insert(),
          );
      _refreshChatList();
    } catch (e) {
      // Handle errors or show an error message
    }
  }

  Future<void> _deleteCardListData(int id) async {
    try {
      await (_database.delete(_database.chatTableData)
            ..where(
              (row) => row.id.isValue(id),
            ))
          .go();
      _refreshChatList();
    } catch (e) {
      // Handle errors or show an error message
    }
  }

  Future<void> _refreshChatList() async {
    // 这里调用 setState 来强制重新构建 FutureBuilder，从而重新获取数据
    setState(() {});
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
      body: RefreshIndicator(
        onRefresh: _refreshChatList,
        child: FutureBuilder<List<ChatTableDataData>>(
          future:
              _database.select(_database.chatTableData).get(), // 假设的Future方法
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (snapshot.hasData) {
              final List<ChatTableDataData> cardListData = snapshot.data!;
              if (cardListData.isEmpty) {
                // 列表为空时的处理
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/icons/not_message.png", // The path to your local image
                        height: 200, // Optional, adjust the height as needed
                        fit: BoxFit
                            .cover, // Maintain the aspect ratio of the image
                      ),
                      const Text(
                        '点击右下角+新增对话',
                        style: TextStyle(color: Colors.grey),
                      )
                    ],
                  ),
                );
              }
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
          context.goNamed(
            'chat',
            pathParameters: {'chatid': chatData.id.toString()},
          );
        },
      ),
    );
  }
}
