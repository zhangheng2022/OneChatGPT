import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:app_links/app_links.dart';
import 'package:one_chatgpt_flutter/utils/log.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

class Screen {
  static Future<void> initialize() async {
    try {
      final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
      FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

      await dotenv.load();

      await Future.wait([
        _initializeAppLinks(),
        _initializeLocalization(),
        _initializeSupabase(),
      ]);

      FlutterNativeSplash.remove();
    } catch (e) {
      Log.e('Initialization failed: $e');
      FlutterNativeSplash.remove();
      rethrow;
    }
  }

  static Future<void> _initializeAppLinks() async {
    final appLinks = AppLinks();
    appLinks.uriLinkStream.listen((uri) => Log.i('Deep link received: $uri'));
  }

  static Future<void> _initializeLocalization() async {
    Intl.defaultLocale = 'zh_CN';
    await initializeDateFormatting();
  }

  static Future<void> _initializeSupabase() async {
    try {
      await Supabase.initialize(
        url: dotenv.env['SUPABASE_URL'] ?? '',
        anonKey: dotenv.env['SUPABASE_ANONKEY'] ?? '',
      );

      final supabase = Supabase.instance.client;
      final session = supabase.auth.currentSession;
      if (session?.refreshToken != null && session!.isExpired) {
        await supabase.auth.refreshSession();
      }
    } catch (e) {
      Log.e('Supabase initialization failed: $e');
      rethrow;
    }
  }
}
