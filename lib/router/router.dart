import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:one_chatgpt_flutter/ui/index/index.dart';
import 'package:one_chatgpt_flutter/ui/auth/login.dart';
import 'package:one_chatgpt_flutter/ui/chat/chat.dart';
import 'package:one_chatgpt_flutter/ui/auth/Register.dart';
import 'package:one_chatgpt_flutter/router/scaffold_with_navbar.dart';

class AppRoutes extends StatelessWidget {
  final _rootNavigatorKey = GlobalKey<NavigatorState>();
  final _sectionNavigatorKey = GlobalKey<NavigatorState>();

  static GoRouter router = GoRouter(
    redirect: (BuildContext context, GoRouterState state) {
      final supabase = Supabase.instance.client;
      final Session? session = supabase.auth.currentSession;

      final noSessionPath = <String>['/login', '/login/register'];
      if (!noSessionPath.contains(state.fullPath) &&
          session?.accessToken == null) {
        return "/login";
      } else {
        return null;
      }
    },
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/',
    routes: <RouteBase>[
      GoRoute(
        name: 'index',
        path: '/',
        builder: (context, state) => const IndexPage(),
        routes: <RouteBase>[
          GoRoute(
            name: 'chat',
            path: 'chat',
            builder: (context, state) => const ChatPage(),
          ),
        ],
      ),
      GoRoute(
        name: 'login',
        path: '/login',
        builder: (context, state) => const LoginPage(),
        routes: <RouteBase>[
          GoRoute(
            name: 'register',
            path: 'register',
            builder: (context, state) => const RegisterPage(),
          ),
        ],
      ),
    ],
  );
}
