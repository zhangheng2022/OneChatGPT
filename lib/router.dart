import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:one_chatgpt_flutter/ui/index/index.dart';
import 'package:one_chatgpt_flutter/ui/auth/login.dart';
import 'package:one_chatgpt_flutter/ui/chat/chat.dart';
import 'package:one_chatgpt_flutter/ui/auth/Register.dart';

class AppRoutes {
  static GoRouter router = GoRouter(
    redirect: (BuildContext context, GoRouterState state) {
      final supabase = Supabase.instance.client;
      final Session? session = supabase.auth.currentSession;

      final noSessionPath = <String>['/login', '/register'];

      if (!noSessionPath.contains(state.fullPath) &&
          session?.accessToken == null) {
        return '/login';
      } else {
        return null; // return "null" to display the intended route without redirecting
      }
    },
    initialLocation: '/',
    routes: [
      GoRoute(
        name: 'index',
        path: '/',
        builder: (context, state) => const IndexPage(),
      ),
      GoRoute(
        name: 'login',
        path: '/login',
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        name: 'register',
        path: '/register',
        builder: (context, state) => const RegisterPage(),
      ),
      GoRoute(
        name: 'chat',
        path: '/chat',
        builder: (context, state) => const ChatPage(),
      ),
    ],
  );
}
