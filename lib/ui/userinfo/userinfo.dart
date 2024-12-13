import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:go_router/go_router.dart';
import 'package:one_chatgpt_flutter/utils/log.dart';
import 'package:one_chatgpt_flutter/state/auth.dart';
import 'package:one_chatgpt_flutter/widgets/user_avatar.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final defaultAvatar =
    '${dotenv.env['SUPABASE_URL']!}/storage/v1/object/public/common/default_avatar.png';

class Userinfo extends StatefulWidget {
  const Userinfo({super.key});
  @override
  State<Userinfo> createState() => _Userinfo();
}

class _Userinfo extends State<Userinfo> {
  @override
  Widget build(BuildContext context) {
    String avatarUrl =
        context.watch<AuthProvider>().user?.userMetadata?['avatar_url'] ??
            defaultAvatar;

    String updatedAt = context.watch<AuthProvider>().user?.updatedAt ?? '';
    return Scaffold(
      appBar: AppBar(
        title: Text("账户管理"),
      ),
      body: Column(
        children: [
          ListTile(
            title: Text("头像"),
            trailing: UserAvatar(
              radius: 30,
              url: '$avatarUrl?v=$updatedAt',
              isUpload: true,
            ),
          ),
          Divider(),
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
