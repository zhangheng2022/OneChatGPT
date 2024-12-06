import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:one_chatgpt_flutter/database/database.dart';
import 'package:one_chatgpt_flutter/state/model_config.dart';
import 'package:provider/provider.dart';
import 'package:one_chatgpt_flutter/router.dart';
import 'package:one_chatgpt_flutter/state/auth.dart';
import 'package:one_chatgpt_flutter/screen.dart';
import 'package:one_chatgpt_flutter/common/theme.dart';
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
          create: (_) => ModelConfigProvider(),
          lazy: false,
        ),
        ChangeNotifierProvider(
          create: (_) => AuthProvider(),
          lazy: false,
        ),
      ],
      child: MaterialApp.router(
        title: 'OneChatGPT',
        // The Mandy red, light theme.
        theme: FlexThemeData.light(scheme: FlexScheme.blue),
        // The Mandy red, dark theme.
        darkTheme: FlexThemeData.dark(scheme: FlexScheme.blue),
        // Use dark or light theme based on system setting.
        themeMode: ThemeMode.light,
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
        supportedLocales: const [
          Locale.fromSubtags(languageCode: 'zh'),
        ],
        localeResolutionCallback: (
          locale,
          supportedLocales,
        ) {
          return locale;
        },
      ),
    );
  }
}
