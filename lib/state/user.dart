import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:one_chatgpt_flutter/models/user.dart';

class UserProvider extends ChangeNotifier {
  User _user = User(email: '', uid: '');

  User get user => _user;
  bool get isLogin => _user.uid != '';

  set user(User newUser) {
    _user = newUser;
    notifyListeners();
  }

  // 更新用户
  void updateUser(User newUser) {
    _user = newUser;
    notifyListeners();
  }

  UserProvider() {
    // firebase.FirebaseAuth.instance.authStateChanges().listen((user) {
    //   log('firebase.user===>$user');
    //   User data = User(email: user?.email, uid: user?.uid);
    //   _user = data;
    //   updateUser(_user);
    // });
  }
}
