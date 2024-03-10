import 'package:one_chatgpt_flutter/state/userinfo.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:one_chatgpt_flutter/config/firebase.dart';
import 'dart:developer';

class Global {
  //初始化全局信息，会在APP启动时执行
  static Future init() async {
    WidgetsFlutterBinding.ensureInitialized();
    try {
      final initFirebase = await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
      UserinfoModel().initUserinfo();
      log('initFirebase：$initFirebase');
    } catch (err) {
      log('initFirebase err：$err');
    }
  }
}
