import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
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
