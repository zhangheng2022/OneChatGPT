import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Home extends StatefulWidget {
  const Home({super.key});
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with AutomaticKeepAliveClientMixin {
  var listData = <Widget>[];

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < 2000; ++i) {
      String index = i.toString();
      listData.add(Card.outlined(
        margin: const EdgeInsets.only(bottom: 12),
        child: ListTile(
            leading: const Icon(Icons.smart_toy),
            title: Text('关于母猪和牛的故事$index'),
            subtitle: const Text("关于母猪和牛的故事"),
            trailing: const Icon(Icons.more_vert),
            onTap: () {
              context.goNamed('chat');
            }),
      ));
    }
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
        appBar: AppBar(
          title: const Text("对话"),
          centerTitle: true,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => {},
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
          itemCount: 2,
          padding: const EdgeInsets.all(12),
          itemBuilder: (context, index) {
            return Card.outlined(
              margin: const EdgeInsets.only(bottom: 12),
              child: ListTile(
                  leading: const Icon(Icons.smart_toy),
                  title: Text('关于母猪和牛的故事$index'),
                  subtitle: const Text("关于母猪和牛的故事"),
                  trailing: const Icon(Icons.more_vert),
                  onTap: () {
                    Navigator.pushNamed(context, '/chat');
                  }),
            );
          },

          // children: [

          //   Card.outlined(
          //     margin: const EdgeInsets.only(bottom: 12),
          //     child: ListTile(
          //         leading: const Icon(Icons.smart_toy),
          //         title: const Text('关于母猪和牛的故事'),
          //         subtitle: const Text("关于母猪和牛的故事"),
          //         trailing: const Icon(Icons.more_vert),
          //         onTap: () {
          //           Navigator.pushNamed(context, '/chat');
          //         }),
          //   ),
          //   Card.outlined(
          //     margin: const EdgeInsets.only(bottom: 12),
          //     child: ListTile(
          //         leading: const Icon(Icons.smart_toy),
          //         title: const Text('关于母猪和牛的故事'),
          //         subtitle: const Text("关于母猪和牛的故事"),
          //         trailing: const Icon(Icons.more_vert),
          //         onTap: () {}),
          //   ),
          // ],
        ));
  }
}
