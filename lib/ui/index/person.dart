import 'package:flutter/material.dart';
import 'package:drift/drift.dart' hide Column;

import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:one_chatgpt_flutter/database/database.dart';

class Person extends StatefulWidget {
  const Person({super.key});
  @override
  State<Person> createState() => _PersonState();
}

class _PersonState extends State<Person> {
  final supabase = Supabase.instance.client;
  final database = AppDatabase();
  void _loginOut() {
    supabase.auth
        .signOut()
        .then((value) => {context.pushReplacement('/login')});
  }

  Future<void> test() async {
    try {
      await database
          .into(database.chatTableData)
          .insertReturning(ChatTableDataCompanion.insert());
    } catch (e) {
      // Handle errors or show an error message
    }
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
