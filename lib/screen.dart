import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:app_links/app_links.dart';
import 'package:one_chatgpt_flutter/common/log.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

class Screen {
  static Future<void> initialize() async {
    // Initialize Flutter framework and preserve native splash screen
    WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
    FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
    // Set up platform-specific UI customization (Android)
    if (Platform.isAndroid) {
      SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
      );
    }

    // Initialize app links listener
    final appLinks = AppLinks();
    appLinks.uriLinkStream.listen((uri) {
      Log.i("uri: $uri");
    });

    await dotenv.load();

    // Set default locale and load environment variables
    Intl.defaultLocale = 'zh_CN';
    // Initialize date formatting
    await initializeDateFormatting();

    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    // Remove the native splash screen
    FlutterNativeSplash.remove();
  }
}
