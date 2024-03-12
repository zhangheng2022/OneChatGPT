import 'dart:developer';
import 'package:one_chatgpt_flutter/state/user.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:one_chatgpt_flutter/config/firebase.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Global {
  //初始化全局信息，会在APP启动时执行
  static Future init() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    // FirebaseAuth.instance.authStateChanges().listen((User? user) async {
    //   log('user：$user');
    //   if (user != null) {
    //     log('用户已登录');
    //     UserProvider.updateUser(user);
    //   } else {
    //     log('用户未登录');
    //   }
    // });
  }
}
