import 'dart:convert';
import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:one_chatgpt_flutter/models/userinfo.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserinfoChangeNotifier extends ChangeNotifier {
  Userinfo get userinfo => Userinfo();
  @override
  Future<void> notifyListeners() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("userinfo", jsonEncode(userinfo.toJson()));
    super.notifyListeners(); //通知依赖的Widget更新
  }
}

class UserinfoModel extends UserinfoChangeNotifier {
  // APP是否登录(如果有用户信息，则证明登录过)
  bool get isLogin => userinfo.uid != null;

  //用户信息发生变化，更新用户信息并通知依赖它的子孙Widgets更新
  initUserinfo() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        log('User is currently signed out!');
      } else {
        log('User is signed in!');
        userinfo.uid = user.uid;
      }
      notifyListeners();
    });
  }
}
