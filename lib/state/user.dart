import 'package:flutter/material.dart';
// import 'package:one_chatgpt_flutter/models/user.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UserProvider extends ChangeNotifier {
  final supabase = Supabase.instance.client;

  late User _user;

  User get user => _user;

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
      final User? user = supabase.auth.currentUser;
      if (user != null) {
        updateUser(user);
      }
    });
  }
}
