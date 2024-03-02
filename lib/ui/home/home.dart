import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _counter = 0;
  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  int currentPageIndex = 0;
  void updatePageIndex(int index) {
    setState(() {
      currentPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBar(),
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
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'You have pushed the button this many times:',
              ),
              Text(
                '$_counter',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              FilledButton(
                onPressed: () => {Navigator.pushNamed(context, '/person')},
                child: const Text('登录'),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _incrementCounter,
          tooltip: '新增对话',
          mini: true,
          child: const Icon(Icons.add_card),
        ),
        bottomNavigationBar: navigationBar(currentPageIndex));
  }
}

AppBar appBar() {
  return AppBar(actions: <Widget>[
    IconButton(
        onPressed: () => {},
        tooltip: "设置",
        icon: const Icon(Icons.density_medium))
  ]);
}

NavigationBar navigationBar(index) {
  return NavigationBar(
    onDestinationSelected: (int index) {},
    labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
    selectedIndex: index,
    destinations: const <Widget>[
      NavigationDestination(
        selectedIcon: Icon(Icons.ballot),
        icon: Icon(Icons.ballot_outlined),
        label: '对话',
      ),
      NavigationDestination(
        selectedIcon: Icon(Icons.person),
        icon: Icon(Icons.person_outlined),
        label: '我的',
      ),
    ],
  );
}
