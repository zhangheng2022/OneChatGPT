import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Person extends StatefulWidget {
  const Person({super.key});
  @override
  State<Person> createState() => _PersonState();
}

class _PersonState extends State<Person> {
  void _loginOut() {
    context.pushReplacement('/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("我的"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FilledButton(
              onPressed: _loginOut,
              child: const Text('退出登录'),
            ),
          ],
        ),
      ),
    );
  }
}
