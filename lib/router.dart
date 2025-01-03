import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:one_chatgpt_flutter/ui/faq/faq.dart';
import 'package:one_chatgpt_flutter/utils/log.dart';
import 'package:one_chatgpt_flutter/ui/auth/login.dart';
import 'package:one_chatgpt_flutter/ui/auth/register.dart';
import 'package:one_chatgpt_flutter/ui/chat/chat_home.dart';
import 'package:one_chatgpt_flutter/ui/index/scaffold_nav_bar.dart';
import 'package:one_chatgpt_flutter/ui/index/home.dart';
import 'package:one_chatgpt_flutter/ui/index/person.dart';
import 'package:one_chatgpt_flutter/ui/system_setting/system_setting.dart';
import 'package:one_chatgpt_flutter/ui/userinfo/update_mail.dart';
import 'package:one_chatgpt_flutter/ui/userinfo/update_name.dart';
import 'package:one_chatgpt_flutter/ui/userinfo/update_password.dart';
import 'package:one_chatgpt_flutter/ui/userinfo/userinfo.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();

final supabase = Supabase.instance.client;

class AppRoutes {
  static GoRouter router = GoRouter(
    redirect: (BuildContext context, GoRouterState state) {
      final supabase = Supabase.instance.client;
      final session = supabase.auth.currentSession;
      final isSessionExpired = session?.isExpired ?? true;
      final noSessionPaths = ['/login', '/login/register'];

      if (noSessionPaths.contains(state.fullPath)) {
        return null;
      }
      if (isSessionExpired) {
        return "/login";
      }
      return null;
    },
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/home',
    observers: [FlutterSmartDialog.observer],
    debugLogDiagnostics: true,
    routes: <RouteBase>[
      StatefulShellRoute.indexedStack(
        branches: <StatefulShellBranch>[
          StatefulShellBranch(
            routes: <RouteBase>[
              GoRoute(
                name: 'home',
                path: '/home',
                builder: (BuildContext context, GoRouterState state) =>
                    const Home(),
                routes: <RouteBase>[
                  GoRoute(
                    name: 'chat',
                    path: 'chat',
                    parentNavigatorKey: _rootNavigatorKey,
                    builder: (BuildContext context, GoRouterState state) {
                      final chatId = state.uri.queryParameters['chatId'];
                      if (chatId == null) {
                        return ErrorWidget('缺少chatId，请检查路由参数');
                      }
                      return ChatHome(chatId: chatId);
                    },
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            routes: <RouteBase>[
              GoRoute(
                name: 'person',
                path: '/person',
                builder: (BuildContext context, GoRouterState state) =>
                    const Person(),
                routes: <RouteBase>[
                  // GoRoute(
                  //   name: 'model_setting',
                  //   path: 'model_setting',
                  //   parentNavigatorKey: _rootNavigatorKey,
                  //   builder: (context, state) => const ModelSetting(),
                  // ),
                  GoRoute(
                    name: 'userinfo',
                    path: 'userinfo',
                    parentNavigatorKey: _rootNavigatorKey,
                    builder: (context, state) => const Userinfo(),
                    routes: <RouteBase>[
                      GoRoute(
                        name: 'update_name',
                        path: 'update_name',
                        parentNavigatorKey: _rootNavigatorKey,
                        builder: (context, state) => const UpdateName(),
                      ),
                      GoRoute(
                        name: 'update_mail',
                        path: 'update_mail',
                        parentNavigatorKey: _rootNavigatorKey,
                        builder: (context, state) => const UpdateMail(),
                      ),
                      GoRoute(
                        name: 'update_password',
                        path: 'update_password',
                        parentNavigatorKey: _rootNavigatorKey,
                        builder: (context, state) => const UpdatePassword(),
                      ),
                    ],
                  ),
                  GoRoute(
                    name: 'system_setting',
                    path: 'system_setting',
                    parentNavigatorKey: _rootNavigatorKey,
                    builder: (context, state) => const SystemSetting(),
                  ),
                  GoRoute(
                    name: 'faq',
                    path: 'faq',
                    parentNavigatorKey: _rootNavigatorKey,
                    builder: (context, state) => const Faq(),
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
            // onExit: (BuildContext context, GoRouterState state) =>
            //     _showDialog(context, state),
          ),
        ],
      ),
    ],
  );
}

Future<bool> _showDialog(BuildContext context, GoRouterState state) async {
  Log.d(state);
  final response = await showDialog<bool>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('提示'),
        content: const Text("确定退出？"),
        actions: <Widget>[
          TextButton(
            child: const Text('取消'),
            onPressed: () {
              Navigator.of(context).pop(false);
            },
          ),
          TextButton(
            child: const Text('退出'),
            onPressed: () {
              Navigator.of(context).pop(true);
            },
          ),
        ],
      );
    },
  );
  return response ?? false;
}
