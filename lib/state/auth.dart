import 'package:flutter/material.dart';
import 'package:one_chatgpt_flutter/common/log.dart';
import 'package:one_chatgpt_flutter/router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = Supabase.instance.client;
final router = AppRoutes.router;

class AuthProvider extends ChangeNotifier {
  Session? _session = supabase.auth.currentSession;

  User? _user = supabase.auth.currentUser;

  User? get user => _user;

  bool get sessionExpired => _session?.isExpired ?? true;

  String? get refreshToken => _session?.refreshToken;

  AuthProvider() {
    Log.t("AuthProvider初始化");
    supabase.auth.onAuthStateChange.listen((data) {
      final AuthChangeEvent event = data.event;
      final Session? session = data.session;

      Log.t('侦听身份验证事件：event: $event, session: $session');

      if (session != null) _session = session;
      _user = supabase.auth.currentUser;

      if (event == AuthChangeEvent.signedIn) {
        router.goNamed('home');
      }

      if (event == AuthChangeEvent.signedOut) {
        router.goNamed('login');
      }

      if (event == AuthChangeEvent.tokenRefreshed) {
        router.goNamed('home');
      }

      notifyListeners();
    });
  }
}
