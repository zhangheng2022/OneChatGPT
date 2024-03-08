import 'package:flutter/material.dart';
import 'package:one_chatgpt_flutter/ui/auth/components/login_email.dart';
import 'package:one_chatgpt_flutter/ui/auth/components/logo.dart';
import 'package:one_chatgpt_flutter/ui/auth/components/footer.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              SizedBox(height: kToolbarHeight),
              Logo(),
              LoginEmail(),
              LoginFooter(),
            ],
          ),
        ),
      ),
    );
  }
}
