import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:one_chatgpt_flutter/database/database.dart';
import 'package:one_chatgpt_flutter/state/model_config.dart';
import 'package:provider/provider.dart';
import 'package:one_chatgpt_flutter/router.dart';
import 'package:one_chatgpt_flutter/state/user.dart';
import 'package:one_chatgpt_flutter/state/global.dart';
import 'package:one_chatgpt_flutter/common/theme.dart';

Future<void> main() async {
  await Global.init();
  runApp(const InitApp());
  if (Platform.isAndroid) {
    SystemUiOverlayStyle systemUiOverlayStyle = const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors.blueGrey,
    );
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
}

class InitApp extends StatelessWidget {
  const InitApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AppDatabase>(
          create: (_) => AppDatabase(),
          dispose: (context, db) => db.close(),
        ),
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => ModelConfigProvider()),
      ],
      child: MaterialApp.router(
        title: 'OneChatGPT',
        themeMode: ThemeMode.light,
        theme: GlobalTheme.lightThemeData,
        darkTheme: GlobalTheme.darkThemeData,
        debugShowCheckedModeBanner: false,
        routerConfig: AppRoutes.router,
      ),
    );
  }
}




// 主色：#1240ab;
