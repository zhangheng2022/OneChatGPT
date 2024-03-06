import 'package:flutter/material.dart';

class LoginHeader extends StatelessWidget {
  const LoginHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Center(
        child: Image.asset(
          width: 200,
          'assets/logos/onechatgpt.png',
        ),
      ),
    ]);
  }
}
