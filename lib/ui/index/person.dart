import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:go_router/go_router.dart';
import 'package:one_chatgpt_flutter/common/log.dart';
import 'package:one_chatgpt_flutter/state/auth.dart';
import 'package:one_chatgpt_flutter/widgets/network_image_with_loading.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Person extends StatefulWidget {
  const Person({super.key});

  @override
  State<Person> createState() => _PersonState();
}

class _PersonState extends State<Person> {
  final supabase = Supabase.instance.client;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final defaultAvatar =
        '${dotenv.env['SUPABASE_URL']!}/storage/v1/object/public/common/default_avatar.png';
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: <Widget>[
            InkWell(
              onTap: () {
                context.goNamed("userinfo");
              },
              child: Consumer<AuthProvider>(
                builder: (context, authProvider, child) {
                  final userinfo = authProvider.user?.userMetadata;
                  final avatarUrl = userinfo?['avatar_url'] ?? defaultAvatar;
                  final fullName = userinfo?['full_name'] ?? '点击完善信息';
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      ClipOval(
                        child: NetworkImageWithLoading(
                          imageUrl:
                              '$avatarUrl?v=${authProvider.user?.updatedAt}',
                          width: 60,
                          height: 60,
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
                },
              ),
            ),
            const SizedBox(height: 20),
            _buildFunctionGrid(),
          ],
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
      child: GridView.count(
        childAspectRatio: 1.2,
        crossAxisCount: 4,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          _buildGridTile(Icons.psychology, '模型设置', 'model_setting'),
          _buildGridTile(Icons.manage_accounts, '账号设置', 'userinfo'),
          _buildGridTile(Icons.settings, '其它设置', 'personal_info'),
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
