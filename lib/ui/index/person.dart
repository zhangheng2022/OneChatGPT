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
            icon: const Icon(Icons.logout),
            onPressed: () => {},
          ),
        ],
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Consumer<UserProvider>(
                  builder: (context, userProvider, child) {
                Map<String, dynamic>? userinfo = userProvider.user.userMetadata;
                String avatarUrl = userinfo?['avatar_url'] ?? '';
                String preferredUsername =
                    userinfo?['preferred_username'] ?? '';
                return Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.grey, // Specify the color of the border
                          width: 1, // Specify the width of the border
                        ),
                      ),
                      child: ClipOval(
                        child: Image.network(
                          avatarUrl,
                          width: 60,
                          height: 60,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Text(
                      preferredUsername,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ],
                );
              }),
            )
          ],
        ),
      ),
    );
  }
}
// Row(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: <Widget>[
//                   Container(
//                     decoration: BoxDecoration(
//                       shape: BoxShape.circle,
//                       border: Border.all(
//                         color: Colors.grey, // Specify the color of the border
//                         width: 2, // Specify the width of the border
//                       ),
//                     ),
//                     child: ClipOval(
//                       child: Image.network(
//                         avatarUrl,
//                         width: 80,
//                         height: 80,
//                         fit: BoxFit.cover,
//                       ),
//                     ),
//                   ),
//                   SizedBox(width: 20),
//                   Text("zhangsan"),
//                 ],
//               ),