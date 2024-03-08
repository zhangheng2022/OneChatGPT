import 'dart:math';

import 'package:flutter/material.dart';
import 'package:one_chatgpt_flutter/ui/index/index.dart';
import 'package:one_chatgpt_flutter/ui/auth/login.dart';
import 'package:one_chatgpt_flutter/ui/chat/chat.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:one_chatgpt_flutter/config/firebase.dart';

Future<void> main() async {
  runApp(const MyApp());
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'OneChatGPT',
      theme: ThemeData(
        useMaterial3: true,
      ),
      darkTheme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const Index(),
        '/login': (context) => const Login(),
        '/chat': (context) => const ChatPage()
      },
    );
  }
}
