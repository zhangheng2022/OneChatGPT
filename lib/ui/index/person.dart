import 'package:flutter/material.dart';
import 'package:drift/drift.dart' hide Column;
import 'package:uuid/uuid.dart';
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
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.grey[50],
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
                String avatarUrl = userinfo?['avatar_url'] ??
                    'https://api.multiavatar.com/${const Uuid().v4()}.png';
                String fullName = userinfo?['full_name'] ?? '点击完善信息';
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
                      fullName,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ],
                );
              }),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              margin: const EdgeInsets.all(20),
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    child: const Column(
                      children: [
                        Icon(
                          Icons.psychology,
                          size: 30,
                          color: Colors.grey,
                        ),
                        Text("模型设置"),
                      ],
                    ),
                    onTap: () {
                      context.goNamed('model_setting');
                    },
                  ),
                  Column(
                    children: [
                      Icon(
                        Icons.manage_accounts,
                        size: 30,
                        color: Colors.grey,
                      ),
                      // SizedBox(height: 4),
                      Text("个人信息"),
                    ],
                  ),
                  Column(
                    children: [
                      Icon(
                        Icons.help_center,
                        size: 30,
                        color: Colors.grey,
                      ),
                      // SizedBox(height: 4),
                      Text("常见问题"),
                    ],
                  ),
                ],
              ),
            ),
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
