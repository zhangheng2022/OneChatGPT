import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:go_router/go_router.dart';
import 'package:one_chatgpt_flutter/utils/log.dart';
import 'package:one_chatgpt_flutter/state/auth.dart';
import 'package:one_chatgpt_flutter/widgets/user_avatar.dart';
import 'package:provider/provider.dart';

final defaultAvatar =
    '${dotenv.env['SUPABASE_URL']!}/storage/v1/object/public/common/default_avatar.png';

class Userinfo extends StatefulWidget {
  const Userinfo({super.key});
  @override
  State<Userinfo> createState() => _Userinfo();
}

class _Userinfo extends State<Userinfo> {
  final userAvatarKey = GlobalKey<UserAvatarState>();

  @override
  Widget build(BuildContext context) {
    String avatarUrl =
        context.watch<AuthProvider>().user?.userMetadata?['avatar_url'] ??
            defaultAvatar;
    String updatedAt = context.watch<AuthProvider>().user?.updatedAt ?? '';

    String userName =
        context.watch<AuthProvider>().user?.userMetadata?['full_name'] ??
            '点击完善信息';
    String userMail =
        context.watch<AuthProvider>().user?.userMetadata?['email'] ?? '';
    return Scaffold(
      appBar: AppBar(
        title: Text("账户管理"),
      ),
      body: Column(
        children: [
          Card.outlined(
            margin: EdgeInsets.all(10),
            child: Column(
              children: [
                ListTile(
                  onTap: () {
                    userAvatarKey.currentState?.handleImageSelection();
                  },
                  contentPadding: EdgeInsets.all(10),
                  title: Text(
                    "头像",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      UserAvatar(
                        key: userAvatarKey,
                        radius: 30,
                        url: '$avatarUrl?v=$updatedAt',
                      ),
                      Icon(Icons.navigate_next)
                    ],
                  ),
                ),
                Divider(height: 0),
                ListTile(
                  onTap: () {
                    context.goNamed("update_name");
                  },
                  contentPadding: EdgeInsets.all(10),
                  title: Text(
                    "用户名",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        userName,
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      Icon(Icons.navigate_next)
                    ],
                  ),
                ),
                Divider(height: 0),
                ListTile(
                  onTap: () {
                    context.goNamed("update_mail");
                  },
                  contentPadding: EdgeInsets.all(10),
                  title: Text(
                    "邮箱",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        userMail,
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      Icon(Icons.navigate_next)
                    ],
                  ),
                ),
                Divider(height: 0),
                ListTile(
                  onTap: () {
                    context.goNamed("update_password");
                  },
                  contentPadding: EdgeInsets.all(10),
                  title: Text(
                    "密码修改",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '修改',
                        style: TextStyle(
                          fontSize: 16,
                          color: Theme.of(context).colorScheme.error,
                        ),
                      ),
                      Icon(
                        Icons.navigate_next,
                        color: Theme.of(context).colorScheme.error,
                      )
                    ],
                  ),
                )
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
    bool? confirmed = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('确认退出？'),
          content: const Text('确定要退出当前账号吗？'),
          actions: <Widget>[
            OutlinedButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('取消'),
            ),
            FilledButton(
              style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(
                  Theme.of(context).colorScheme.error,
                ),
              ),
              onPressed: () => Navigator.of(context).pop(true),
              child: Text('确定'),
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
