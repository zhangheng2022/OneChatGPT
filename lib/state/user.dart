import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:one_chatgpt_flutter/models/user.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supabasePack;

class UserProvider extends ChangeNotifier {
  final supabase = supabasePack.Supabase.instance.client;
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
      final supabasePack.AuthChangeEvent event = data.event;
      final supabasePack.Session? session = data.session;
    });
    // final authSubscription = supabasePack.ausupabase.auth.onAuthStateChange.listen((data) {
    //   final AuthChangeEvent event = data.event;
    //   final Session? session = data.session;
    // });
    // firebase.FirebaseAuth.instance.authStateChanges().listen((user) {
    //   log('firebase.user===>$user');
    //   User data = User(email: user?.email, uid: user?.uid);
    //   _user = data;
    //   updateUser(_user);
    // });
  }
}
