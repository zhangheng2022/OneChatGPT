import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class Home extends StatefulWidget {
  const Home({super.key});
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _cardListData = <Map<dynamic, dynamic>>[];

  void _addCardListData() {
    // String dateNow = DateFormat.yMMMd().format(DateTime.now());
    setState(() {
      _cardListData.add({"title": "新的对话", "dateTime": "dateNow"});
    });
  }

  @override
  void initState() {
    super.initState();
    if (_cardListData.isEmpty) {
      _addCardListData();
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
                  title: Text(_cardListData[index]['title']),
                  subtitle: const Text("关于母猪和牛的故事"),
                  trailing: const Icon(Icons.delete),
                  onTap: () {
                    context.pushNamed('chat');
                  }),
            );
          },
        ));
  }
}
