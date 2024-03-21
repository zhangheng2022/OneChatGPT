import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:intl/intl.dart';

class Global {
  //初始化全局信息，会在APP启动时执行
  static Future init() async {
    WidgetsFlutterBinding.ensureInitialized();
    Intl.defaultLocale = 'zh_CN';
    await Supabase.initialize(
      url: 'https://jkdxuuhjdoxqsjyhlubj.supabase.co',
      anonKey:
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImprZHh1dWhqZG94cXNqeWhsdWJqIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTAzMzE4MTksImV4cCI6MjAyNTkwNzgxOX0.bOYWtTR1EAfR2oj51cf2m1J-A6vOX3Uc4q8UFf_8dHw',
    );
  }
}
