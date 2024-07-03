import 'package:flutter/material.dart';
import 'package:drift/drift.dart' hide Column;

import 'package:go_router/go_router.dart';
import 'package:one_chatgpt_flutter/state/user.dart';
import 'package:provider/provider.dart';
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
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            color: Theme.of(context).primaryColor,
            onPressed: () => {},
          ),
        ],
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  ClipOval(
                    child: Image.network(
                      Provider.of<UserProvider>(context)
                          .user
                          .userMetadata?['avatar_url'], // 您的图片URL
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover, // 保持图片的宽高比
                    ),
                  ),
                  SizedBox(width: 20),
                  Text("zhangsan"),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
