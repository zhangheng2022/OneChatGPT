import 'package:flutter/material.dart';
import 'package:one_chatgpt_flutter/ui/components/navbar.dart';

class Person extends StatefulWidget {
  const Person({super.key});
  @override
  State<Person> createState() => _PersonState();
}

class _PersonState extends State<Person> {
  int _counter = 0;
  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text("个人中心"),
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
                onPressed: _incrementCounter,
                child: const Text('登录'),
              ),
            ],
          ),
        ),
        bottomNavigationBar: const Navbar());
  }
}
