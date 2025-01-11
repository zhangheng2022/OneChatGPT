import 'package:flutter/material.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:app_links/app_links.dart';
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
        _initializeSentry(),
      ]);

      FlutterNativeSplash.remove();
    } catch (e) {
      rethrow;
    }
  }

  static Future<void> _initializeAppLinks() async {
    final appLinks = AppLinks();
    appLinks.uriLinkStream.listen((uri) => debugPrint('深度链接触发: $uri'));
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
      debugPrint('初始化 Supabase 失败: $e');
      rethrow;
    }
  }

  static Future<void> _initializeSentry() async {
    final sentryDsn = dotenv.env['SENTRY_DSN'];
    if (sentryDsn == null) {
      debugPrint('sentryDsn未配置: $sentryDsn');
      return;
    }
    await SentryFlutter.init(
      (SentryFlutterOptions options) {
        options.dsn = sentryDsn;
        options.experimental.replay.sessionSampleRate = 1.0;
        options.experimental.replay.onErrorSampleRate = 1.0;
      },
    );
  }
}
