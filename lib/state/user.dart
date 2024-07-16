import 'package:flutter/material.dart';
import 'package:one_chatgpt_flutter/common/log.dart';
import 'package:one_chatgpt_flutter/router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = Supabase.instance.client;
final router = AppRoutes.router;

class UserProvider extends ChangeNotifier {
  Session? _session = supabase.auth.currentSession;

  User? _user;

  User get user => _user!;

  bool get sessionExpired => _session?.isExpired ?? true;

  String? get refreshToken => _session?.refreshToken;

  UserProvider() {
    _user = supabase.auth.currentUser;
    supabase.auth.onAuthStateChange.listen((data) {
      final AuthChangeEvent event = data.event;
      final Session? session = data.session;

      Log.t('侦听身份验证事件：event: $event, session: $session');
      if (session != null) _session = session;
      _user = supabase.auth.currentUser;

      switch (event) {
        case AuthChangeEvent.initialSession:
        case AuthChangeEvent.signedIn:
          router.goNamed('home');
        case AuthChangeEvent.signedOut:
          router.pushReplacementNamed('login');
        case AuthChangeEvent.passwordRecovery:
        case AuthChangeEvent.tokenRefreshed:
          router.pushReplacementNamed('home');
        case AuthChangeEvent.userUpdated:
        case AuthChangeEvent.userDeleted:
        case AuthChangeEvent.mfaChallengeVerified:
      }

      notifyListeners();
    });
  }

  goHome() {}
}
