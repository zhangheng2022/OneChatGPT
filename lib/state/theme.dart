import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode _currentTheme = ThemeMode.system;

  ThemeMode get currentTheme => _currentTheme;

  String get currentThemeKey {
    String key = "";
    switch (_currentTheme) {
      case ThemeMode.system:
        key = "system";
        break;
      case ThemeMode.light:
        key = "light";
        break;
      case ThemeMode.dark:
        key = "dark";
        break;
    }
    return key;
  }

  ThemeProvider() {
    debugPrint("AppTheme初始化");
    _init();
  }

  Future<void> _init() async {
    final SharedPreferencesWithCache prefsWithCache =
        await SharedPreferencesWithCache.create(
            cacheOptions: const SharedPreferencesWithCacheOptions(
                allowList: <String>{'currentTheme'}));

    String? theme = prefsWithCache.getString('currentTheme');

    _currentTheme = themeKeyToThemeMode(theme);
    notifyListeners();
  }

  void updateTheme(String theme) {
    _currentTheme = themeKeyToThemeMode(theme);
    final SharedPreferencesAsync asyncPrefs = SharedPreferencesAsync();

    asyncPrefs.setString('currentTheme', theme);
    notifyListeners();
  }

  ThemeMode themeKeyToThemeMode(String? theme) {
    ThemeMode mode;
    switch (theme) {
      case 'system':
        mode = ThemeMode.system;
        break;
      case 'light':
        mode = ThemeMode.light;
        break;
      case 'dark':
        mode = ThemeMode.dark;
        break;
      default:
        mode = ThemeMode.system;
        break;
    }
    return mode;
  }
}
