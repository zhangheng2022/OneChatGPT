import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:one_chatgpt_flutter/models/user.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supabase_pack;

class UserProvider extends ChangeNotifier {
  final supabase = supabase_pack.Supabase.instance.client;
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
    supabase.auth.onAuthStateChange.listen((data) {
      final supabase_pack.AuthChangeEvent event = data.event;
      final supabase_pack.Session? session = data.session;
      log('event=================$event');
      log('event=================$session');
    });
    // firebase.FirebaseAuth.instance.authStateChanges().listen((user) {
    //   log('firebase.user===>$user');
    //   User data = User(email: user?.email, uid: user?.uid);
    //   _user = data;
    //   updateUser(_user);
    // });
  }
}
