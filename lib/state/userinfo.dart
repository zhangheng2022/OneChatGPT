import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:one_chatgpt_flutter/models/userinfo.dart';

class UserinfoModel extends ChangeNotifier {
  Userinfo? userinfo;

  // APP是否登录(如果有用户信息，则证明登录过)
  bool get isLogin => userinfo?.uid != null;

  init() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) async {
      log('user：$user');
      if (user != null) {
        log('用户已登录');
        // userinfo = user;
        notifyListeners();
      } else {
        log('用户未登录');
      }
    });
  }
}
