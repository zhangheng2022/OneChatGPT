import 'package:flutter/material.dart';
import 'package:one_chatgpt_flutter/ui/home/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo11',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const MyHomePage(title: '我是标题'),
    );
  }
}
