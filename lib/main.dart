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
        routes: {
          '/': (context) => const IndexPage(),
          '/login': (context) => const LoginPage(),
          '/register': (context) => const RegisterPage(),
          '/chat': (context) => const ChatPage()
        },
      ),
    );
  }
}
