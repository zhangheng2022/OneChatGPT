import 'dart:async';

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
  bool _canPopState = false;
  @override
  Widget build(BuildContext context) {
    return PopScope(
        canPop: _canPopState,
        onPopInvoked: (didPop) {
          if (didPop == false) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                showCloseIcon: false,
                duration: Duration(milliseconds: 2000),
                behavior: SnackBarBehavior.floating,
                content: Text(
                  '再按一次退出',
                  textAlign: TextAlign.center,
                ),
              ),
            );
            setState(() {
              _canPopState = true;
            });
            const timeout = Duration(seconds: 2);
            Timer(timeout, () {
              setState(() {
                _canPopState = false;
              });
            });
          }
        },
        child: const Scaffold(
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
        ));
  }
}
