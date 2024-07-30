import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GlobalTheme {
  static final Color _lightFocusColor = Colors.black.withOpacity(0.12);
  static final Color _darkFocusColor = Colors.white.withOpacity(0.12);
  static ThemeData lightThemeData = themeData(
    lightColorScheme,
    _lightFocusColor,
  );
  static ThemeData darkThemeData = themeData(
    darkColorScheme,
    _darkFocusColor,
  );
  static ThemeData themeData(ColorScheme colorScheme, Color focusColor) {
    return ThemeData(
      colorScheme: colorScheme,
      canvasColor: colorScheme.surface,
      scaffoldBackgroundColor: colorScheme.surface,
      highlightColor: Colors.transparent,
      focusColor: focusColor,
    );
  }

  static const ColorScheme lightColorScheme = ColorScheme(
    brightness: Brightness.light,
    primary: Color(0xFF0052d9),
    onPrimary: Colors.white,
    secondary: Color(0xFF5885ff), // Energetic Green for vibrancy
    onSecondary: Colors.white,
    tertiary: Color(0xFFebedff),
    onTertiary: Colors.white,
    error: Color(0xFFd54941), // Vivid Red for attention
    onError: Colors.white,
    surface: Colors.white,
    onSurface: Colors.black,
  );
  static const ColorScheme darkColorScheme = ColorScheme(
    brightness: Brightness.light,
    primary: Color(0xFF0052d9),
    onPrimary: Colors.white,
    secondary: Color(0xFF5885ff), // Energetic Green for vibrancy
    onSecondary: Colors.white,
    tertiary: Color(0xFFebedff),
    onTertiary: Colors.white,
    error: Color(0xFFd54941), // Vivid Red for attention
    onError: Colors.white,
    surface: Colors.white,
    onSurface: Colors.black,
  );
}
