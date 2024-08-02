import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:one_chatgpt_flutter/utils/view_platform.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:app_links/app_links.dart';
import 'package:one_chatgpt_flutter/common/log.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:window_manager/window_manager.dart';
import 'package:win32_registry/win32_registry.dart';

class Screen {
  static Future<void> initialize() async {
    // Initialize Flutter framework and preserve native splash screen
    WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
    FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
    ResponsiveSizingConfig.instance.setCustomBreakpoints(
      const ScreenBreakpoints(desktop: 700, tablet: 500, watch: 200),
    );
    // Set up platform-specific UI customization (Android)
    if (Platform.isAndroid) {
      SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
      );
    }
    if (ViewPlatform.isDesktop) {
      await windowManager.ensureInitialized();
      WindowOptions windowOptions = const WindowOptions(
        size: Size(800, 600),
        minimumSize: Size(800, 600),
        center: true,
        backgroundColor: Colors.transparent,
        skipTaskbar: false,
        titleBarStyle: TitleBarStyle.normal,
      );
      windowManager.waitUntilReadyToShow(windowOptions, () async {
        await windowManager.show();
        await windowManager.focus();
      });
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

    // Initialize Supabase client
    await Supabase.initialize(
      url: dotenv.env['SUPABASE_URL']!,
      anonKey: dotenv.env['SUPABASE_ANONKEY']!,
    );

    // Refresh session if needed
    final supabase = Supabase.instance.client;
    final session = supabase.auth.currentSession;
    if (session != null && session.refreshToken != null && session.isExpired) {
      await supabase.auth.refreshSession();
    }

    // Remove the native splash screen
    FlutterNativeSplash.remove();
  }
}
