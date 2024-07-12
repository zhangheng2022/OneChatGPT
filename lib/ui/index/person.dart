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

  Future<void> _logout() async {
    // Show a confirmation dialog
    bool? confirmed = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('确认退出？'),
          content: const Text('确定要退出当前账号吗？'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('取消'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('确定'),
            ),
          ],
        );
      },
    );

    if (confirmed == true) {
      await supabase.auth.signOut();
      if (!mounted) return;
      context.pushReplacement('/login');
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
      // padding: const EdgeInsets.symmetric(vertical: 20),
      child: GridView.count(
        childAspectRatio: 1.2,
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
      onTap: () {
        context.goNamed(routeName);
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center, // 居中对齐
        children: [
          Icon(
            icon,
            size: 30, // 限制大小
          ),
          const SizedBox(height: 6),
          Text(title),
        ],
      ),
    );
  }
}
