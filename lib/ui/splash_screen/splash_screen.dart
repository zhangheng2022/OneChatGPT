import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:one_chatgpt_flutter/state/user.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 60, // 设置 Container 宽度与 Image.asset 的宽度一致
              height: 60, // 设置 Container 高度与 Image.asset 的高度一致
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                shape: BoxShape.circle, // 设置 Container 形状为圆形
                border: Border.all(
                  color: Colors.grey, // 设置边框颜色
                  width: 1, // 设置边框宽度
                ),
              ),
              child: Image.asset(
                'assets/logos/logo.png',
                fit: BoxFit.cover, // 设置图片填充方式为 BoxFit.cover
              ),
            ),
          ],
        ),
      ),
    );
  }
}
