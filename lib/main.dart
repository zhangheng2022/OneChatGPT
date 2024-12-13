import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:one_chatgpt_flutter/common/theme_config.dart';
import 'package:one_chatgpt_flutter/database/database.dart';
import 'package:one_chatgpt_flutter/state/theme.dart';
import 'package:one_chatgpt_flutter/state/model_setting.dart';
import 'package:provider/provider.dart';
import 'package:one_chatgpt_flutter/router.dart';
import 'package:one_chatgpt_flutter/state/auth.dart';
import 'package:one_chatgpt_flutter/screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

Future<void> main() async {
  await Screen.initialize();
  runApp(const RunApp());
}

class RunApp extends StatelessWidget {
  const RunApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AppDatabase>(
          create: (_) => AppDatabase(),
          dispose: (context, db) => db.close(),
        ),
        ChangeNotifierProvider(
          create: (_) => ModelSettingProvider(),
          lazy: false,
        ),
        ChangeNotifierProvider(
          create: (_) => AuthProvider(),
          lazy: false,
        ),
        ChangeNotifierProvider(
          create: (_) => ThemeProvider(),
        ),
      ],
      child: Consumer<ThemeProvider>(
        // 使用 Consumer 来确保 AppTheme 已初始化
        builder: (context, themeProvider, child) {
          return MaterialApp.router(
            title: 'OneChatGPT',
            theme: ThemeConfig.light,
            darkTheme: ThemeConfig.dark,
            themeMode: themeProvider.currentTheme, // 动态获取主题
            debugShowCheckedModeBanner: true,
            routerConfig: AppRoutes.router,
            builder: (context, child) {
              child = FlutterSmartDialog.init()(context, child);
              return child;
            },
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: [
              Locale.fromSubtags(languageCode: 'zh'),
            ],
            localeResolutionCallback: (
              locale,
              supportedLocales,
            ) {
              return locale;
            },
          );
        },
      ),
    );
  }
}
