import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:one_chatgpt_flutter/common/log.dart';
import 'package:one_chatgpt_flutter/state/auth.dart';
import 'package:one_chatgpt_flutter/ui/userinfo/widgets/avatar_item.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Userinfo extends StatefulWidget {
  const Userinfo({super.key});
  @override
  State<Userinfo> createState() => _Userinfo();
}

class _Userinfo extends State<Userinfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.grey[50],
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const AvatarItem(),
                ListTile(
                  onTap: () {
                    context.goNamed("update_name");
                  },
                  enableFeedback: true,
                  title: const Text(
                    "用户名",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Selector<AuthProvider, User?>(
                        selector: (context, state) => state.user,
                        builder: (context, value, child) {
                          return Text(
                            value?.userMetadata?['full_name'] ?? '点击完善信息',
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                            ),
                          );
                        },
                      ),
                      const Icon(
                        Icons.chevron_right,
                        color: Colors.grey,
                      )
                    ],
                  ),
                ),
                ListTile(
                  onTap: () {
                    context.goNamed("update_mail");
                  },
                  enableFeedback: true,
                  title: const Text(
                    "邮箱",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Selector<AuthProvider, User?>(
                        selector: (context, state) => state.user,
                        builder: (context, value, child) {
                          return Text(
                            value?.email ?? '',
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                            ),
                          );
                        },
                      ),
                      const Icon(
                        Icons.chevron_right,
                        color: Colors.grey,
                      )
                    ],
                  ),
                ),
                ListTile(
                  onTap: () {
                    context.goNamed("update_password");
                  },
                  enableFeedback: true,
                  title: const Text(
                    "密码修改",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  trailing: const Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "修改",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                      Icon(
                        Icons.chevron_right,
                        color: Colors.grey,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          TextButton.icon(
            onPressed: _logout,
            style: TextButton.styleFrom(
              foregroundColor: Theme.of(context).colorScheme.error,
            ),
            label: const Text("退出登录"),
            icon: const Icon(Icons.logout_rounded),
          )
        ],
      ),
    );
  }

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
              child: Text(
                '确定',
                style: TextStyle(color: Theme.of(context).colorScheme.error),
              ),
            ),
          ],
        );
      },
    );

    if (confirmed == true) {
      try {
        await supabase.auth.signOut();
      } catch (e) {
        Log.e(e);
      }
    }
  }
}
