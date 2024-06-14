import 'dart:async';

import 'package:flutter/material.dart';
import 'package:one_chatgpt_flutter/ui/auth/widgets/email_login.dart';
import 'package:one_chatgpt_flutter/ui/auth/widgets/logo.dart';
import 'package:one_chatgpt_flutter/ui/auth/widgets/footer.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const SizedBox(height: kToolbarHeight),
              const Logo(),
              const LoginEmail(),
              LoginFooter(),
            ],
          ),
        ),
      ),
    );
  }
}
