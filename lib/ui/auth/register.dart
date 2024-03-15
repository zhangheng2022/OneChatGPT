import 'package:flutter/material.dart';
import 'package:one_chatgpt_flutter/ui/auth/widgets/logo.dart';
import 'package:one_chatgpt_flutter/ui/auth/widgets/email_register.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("注册"),
        centerTitle: true,
      ),
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Logo(),
              RegisterEmail(),
            ],
          ),
        ),
      ),
    );
  }
}
