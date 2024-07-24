import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
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
      body: Container(
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
            const ListTile(
              enableFeedback: true,
              title: const Text(
                "密码修改",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              contentPadding: EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 10,
              ),
              trailing: Row(
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
            )
          ],
        ),
      ),
    );
  }
}
