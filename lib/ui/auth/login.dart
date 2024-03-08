import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:one_chatgpt_flutter/ui/auth/components/login_email.dart';
import 'package:one_chatgpt_flutter/ui/auth/components/logo.dart';
import 'package:one_chatgpt_flutter/ui/auth/components/footer.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _Login();
}

class _Login extends State<Login> {
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
