import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:one_chatgpt_flutter/ui/login/components/mail_form.dart';
import 'package:one_chatgpt_flutter/ui/login/components/header.dart';
import 'package:one_chatgpt_flutter/ui/login/components/footer.dart';

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
              LoginHeader(),
              LoginForm(),
              LoginFooter(),
            ],
          ),
        ),
      ),
    );
  }
}
