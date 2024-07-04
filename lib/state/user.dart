import 'package:flutter/material.dart';
import 'package:one_chatgpt_flutter/common/log.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UserProvider extends ChangeNotifier {
  final supabase = Supabase.instance.client;
  User? _user;

  User get user => _user!;

  UserProvider() {
    _user = supabase.auth.currentUser;
    supabase.auth.onAuthStateChange.listen((data) {
      _user = supabase.auth.currentUser;
      notifyListeners();
      Log.d('===>更新用户信息$_user');
    });
  }
}
