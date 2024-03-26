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
  @override
  void initState() {
    super.initState();
    _initCardListData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("对话"),
          centerTitle: true,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _addCardListData(),
          tooltip: '新增对话',
          child: const Icon(Icons.add),
        ),
        drawer: Drawer(
          child: ListView(
            children: [
              const DrawerHeader(
                child: Text('Drawer Header'),
              ),
              ListTile(
                title: const Text('Item 1'),
                onTap: () {},
              ),
              ListTile(
                title: const Text('Item 2'),
                subtitle: const Text("data"),
                onTap: () {},
              ),
            ],
          ),
        ),
        body: ListView.builder(
          itemCount: _cardListData.length,
          padding: const EdgeInsets.all(12),
          itemBuilder: (context, index) {
            return Card(
              margin: const EdgeInsets.only(bottom: 12),
              child: ListTile(
                  leading: const Icon(Icons.smart_toy),
                  title: Text(_cardListData[index].title),
                  subtitle: Text(_cardListData[index].datetime.toString()),
                  trailing: IconButton(
                    onPressed: () =>
                        _deleteCardListData(_cardListData[index].id),
                    icon: const Icon(Icons.delete),
                  ),
                  onTap: () {
                    context.goNamed('chat', pathParameters: {
                      'chatid': _cardListData[index].id.toString()
                    });
                  }),
            );
          },
        ));
  }

  final database = AppDatabase();

  List<ChatTable> _cardListData = [];

  Future<void> _addCardListData() async {
    final insertResult =
        await database.into(database.chatTables).insertReturning(
              ChatTablesCompanion.insert(
                title: '新的对话',
                datetime: DateTime.now(),
              ),
            );

    setState(() {
      _cardListData.add(insertResult);
    });
  }

  Future<void> _deleteCardListData(int id) async {
    (database.delete(database.chatTables)..where((row) => row.id.isValue(id)))
        .go();
    _initCardListData();
  }

  Future<void> _initCardListData() async {
    List<ChatTable> allChatTables =
        await database.select(database.chatTables).get();

    if (allChatTables.isNotEmpty) {
      setState(() {
        _cardListData = allChatTables;
      });
    } else {
      final insertResult =
          await database.into(database.chatTables).insertReturning(
                ChatTablesCompanion.insert(
                  title: '新的对话',
                  datetime: DateTime.now(),
                ),
              );
      setState(() {
        _cardListData = [insertResult];
      });
    }
  }
}
