import 'package:flutter/material.dart';
import 'package:one_chatgpt_flutter/ui/home/home.dart';
import 'package:one_chatgpt_flutter/ui/person/person.dart';

void main() {
  runApp(const MyApp());
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
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const Home(),
        '/person': (context) => const Person(),
      },
    );
  }
}
