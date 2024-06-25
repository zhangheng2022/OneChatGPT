import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:app_links/app_links.dart';
import 'package:one_chatgpt_flutter/common/log.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Global {
  //获取全局信息
  //初始化全局信息，会在APP启动时执行
  static init() async {
    //设置全局异常处理
    WidgetsFlutterBinding.ensureInitialized();
    await dotenv.load();
    //监听链接
    final appLinks = AppLinks();
    appLinks.uriLinkStream.listen((uri) {
      Log.i("uri: $uri");
    });
    //设置默认语言
    Intl.defaultLocale = 'zh_CN';
    //设置默认日期格式
    await initializeDateFormatting();
    //初始化supabase];
    await Supabase.initialize(
      url: dotenv.get('SUPABASE_URL', fallback: null),
      anonKey: dotenv.get('SUPABASE_ANONKEY', fallback: null),
    );
  }
}
