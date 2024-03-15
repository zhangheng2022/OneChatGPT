import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:one_chatgpt_flutter/ui/index/index.dart';
import 'package:one_chatgpt_flutter/ui/auth/login.dart';
import 'package:one_chatgpt_flutter/ui/chat/chat.dart';
import 'package:one_chatgpt_flutter/ui/auth/Register.dart';
import 'package:one_chatgpt_flutter/state/user.dart';
import 'package:one_chatgpt_flutter/state/global.dart';

Future<void> main() async {
  Global.init().then((e) => runApp(const InitApp()));
}

class InitApp extends StatelessWidget {
  const InitApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: MaterialApp(
        title: 'OneChatGPT',
        theme: ThemeData(
          useMaterial3: true,
        ),
        // darkTheme: ThemeData.dark(),
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        // onGenerateRoute: onGenerateRoute,
        routes: {
          '/': (context) => const IndexPage(),
          '/login': (context) => const LoginPage(),
          '/register': (context) => const RegisterPage(),
          '/chat': (context) => const ChatPage()
        },
      ),
    );
  }

//   Route<dynamic> onGenerateRoute(RouteSettings settings) {
//     String routeName;
//     routeName = routeBeforeHook(settings);
//   }

//   String routeBeforeHook(RouteSettings settings) {
//     /// Global.prefs 是全局的 SharedPreferences 实例
//     /// SharedPreferences 是常用的本地存储的插件
//     final token = Global.prefs.getString('token') ?? '';
//     if (token != '') {
//       if (settings.name == 'login') {
//         return 'index';
//       }
//       return settings.name;
//     }
//     return 'login';
//   }
// }
