import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  const Logo({super.key});

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
