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

  void _logout() {
    supabase.auth.signOut().then((_) => context.pushReplacement('/login'));
  }

  Future<void> _insertChatData() async {
    try {
      await database.into(database.chatTableData).insertReturning(
          ChatTableDataCompanion
              .insert()); // Consider adding a meaningful value here
    } catch (e) {
      // Handle errors or show an error message
      print('Error inserting chat data: $e');
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
            onPressed: _logout,
          ),
        ],
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Consumer<UserProvider>(
                builder: (context, userProvider, child) {
                  final userinfo = userProvider.user.userMetadata;
                  final avatarUrl = userinfo?['avatar_url'];
                  final fullName = userinfo?['full_name'] ?? '点击完善信息';
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      _buildProfileImage(avatarUrl),
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
                },
              ),
            ),
            _buildFunctionGrid(),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileImage(String avatarUrl) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.grey,
          width: 1,
        ),
      ),
      child: ClipOval(
        child: Image.network(
          avatarUrl,
          width: 60,
          height: 60,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) => Image.asset(
            'assets/icons/not_avatar.png', //默认显示图片
            width: 60,
            height: 60,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget _buildFunctionGrid() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: GridView.count(
        crossAxisCount: 4,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          _buildGridTile(Icons.psychology, '模型设置', 'model_setting'),
          _buildGridTile(Icons.manage_accounts, '个人信息', 'personal_info'),
          _buildGridTile(Icons.help_center, '常见问题', 'faq'),
        ],
      ),
    );
  }

  Widget _buildGridTile(IconData icon, String title, String routeName) {
    return InkWell(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 30,
          ),
          Text(title),
        ],
      ),
      onTap: () {
        context.goNamed(routeName);
      },
    );
  }
}
