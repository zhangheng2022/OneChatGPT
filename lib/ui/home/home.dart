import 'package:flutter/material.dart';
import 'package:one_chatgpt_flutter/ui/person/person.dart';
import 'package:one_chatgpt_flutter/ui/components/navbar.dart';

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text("首页"),
          actions: <Widget>[
            IconButton(
                onPressed: () => {},
                tooltip: "调整",
                icon: const Icon(Icons.density_medium))
          ],
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
                onPressed: () => {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Person()),
                  )
                },
                child: const Text('登录'),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _incrementCounter,
          tooltip: '新增会话',
          mini: true,
          child: const Icon(Icons.add),
        ),
        bottomNavigationBar: const Navbar());
  }
}
