import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:one_chatgpt_flutter/common/log.dart';
import 'package:one_chatgpt_flutter/state/user.dart';
import 'package:provider/provider.dart';
import 'package:one_chatgpt_flutter/ui/auth/login.dart';
import 'package:one_chatgpt_flutter/ui/auth/register.dart';
import 'package:one_chatgpt_flutter/ui/chat/chat.dart';
import 'package:one_chatgpt_flutter/ui/index/scaffold_nav_bar.dart';
import 'package:one_chatgpt_flutter/ui/index/home.dart';
import 'package:one_chatgpt_flutter/ui/index/person.dart';
import 'package:one_chatgpt_flutter/ui/model_setting/model_setting.dart';
import 'package:one_chatgpt_flutter/ui/splash_screen/splash_screen.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();

class AppRoutes {
  static GoRouter router = GoRouter(
    redirect: (BuildContext context, GoRouterState state) {
      final userProvider = Provider.of<UserProvider>(context, listen: false);

      final noSessionPaths = ['/splash_screen', '/login', '/login/register'];

      if (noSessionPaths.contains(state.fullPath)) {
        return null;
      }
      if (userProvider.refreshToken == null) {
        return "/login";
      } else if (userProvider.sessionExpired) {
        return "/splash_screen";
      }
      return null;
    },
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/home',
    routes: <RouteBase>[
      StatefulShellRoute.indexedStack(
        branches: <StatefulShellBranch>[
          StatefulShellBranch(routes: <RouteBase>[
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
                    return ChatPage(
                      chatid: chatid,
                    );
                  },
                ),
              ],
            ),
          ]),
          StatefulShellBranch(
            routes: <RouteBase>[
              GoRoute(
                name: 'person',
                path: '/person',
                builder: (BuildContext context, GoRouterState state) =>
                    const Person(),
                routes: <RouteBase>[
                  GoRoute(
                    name: 'model_setting',
                    path: 'model_setting',
                    parentNavigatorKey: _rootNavigatorKey,
                    builder: (context, state) => const ModelSetting(),
                  ),
                ],
              ),
            ],
          ),
        ],
        builder: (BuildContext context, GoRouterState state,
            StatefulNavigationShell navigationShell) {
          return ScaffoldNavBar(navigationShell: navigationShell);
        },
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
      GoRoute(
        name: 'splash_screen',
        path: '/splash_screen',
        builder: (context, state) => const SplashScreen(),
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
