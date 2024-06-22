import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:one_chatgpt_flutter/ui/auth/login.dart';
import 'package:one_chatgpt_flutter/ui/auth/register.dart';
import 'package:one_chatgpt_flutter/ui/chat/chat.dart';
import 'package:one_chatgpt_flutter/ui/index/scaffold_nav_bar.dart';
import 'package:one_chatgpt_flutter/ui/index/home.dart';
import 'package:one_chatgpt_flutter/ui/index/person.dart';
import 'package:one_chatgpt_flutter/common/log.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> _shellNavigatorKey =
    GlobalKey<NavigatorState>();

class AppRoutes {
  static GoRouter router = GoRouter(
    redirect: (BuildContext context, GoRouterState state) {
      final supabase = Supabase.instance.client;
      final session = supabase.auth.currentSession;
      // Check if the session is valid.
      final isSessionExpired = session?.isExpired;
      final noSessionPath = <String>['/login', '/login/register'];
      if (!noSessionPath.contains(state.fullPath) && isSessionExpired!) {
        return "/login";
      } else {
        return null;
      }
    },
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/home',
    routes: <RouteBase>[
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (BuildContext context, GoRouterState state, Widget child) {
          return ScaffoldNavBar(child: child);
        },
        routes: <RouteBase>[
          GoRoute(
              name: 'home',
              path: '/home',
              builder: (BuildContext context, GoRouterState state) =>
                  const Home(),
              routes: <RouteBase>[
                GoRoute(
                  name: 'chat',
                  path: 'chat/:chatid',
                  parentNavigatorKey: _rootNavigatorKey,
                  builder: (BuildContext context, GoRouterState state) {
                    final String chatid = state.pathParameters['chatid']!;
                    return ChatPage(chatid: chatid);
                  },
                ),
              ]),
          GoRoute(
            name: 'person',
            path: '/person',
            builder: (BuildContext context, GoRouterState state) =>
                const Person(),
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
        // onExit: (BuildContext context, GoRouterState state) =>
        //     _showDialog(context, state),
      ),
    ],
  );
}

// Future<bool> _showDialog(BuildContext context, GoRouterState state) async {
//   Log.d(state);
//   final response = await showDialog<bool>(
//     context: context,
//     builder: (BuildContext context) {
//       return AlertDialog(
//         title: const Text('提示'),
//         content: const Text("确定退出？"),
//         actions: <Widget>[
//           TextButton(
//             child: const Text('取消'),
//             onPressed: () {
//               Navigator.of(context).pop(false);
//             },
//           ),
//           TextButton(
//             child: const Text('退出'),
//             onPressed: () {
//               Navigator.of(context).pop(true);
//             },
//           ),
//         ],
//       );
//     },
//   );
//   return response ?? false;
// }
