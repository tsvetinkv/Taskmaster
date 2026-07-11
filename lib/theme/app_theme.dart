import 'package:flutter/material.dart';

class AppTheme {
  // Light Theme Palette
  static const Color _lightPrimary = Colors.indigo;
  static const Color _lightSecondary = Colors.orange;
  static const Color _lightBackground = Color(0xFFF5F5F5);
  static const Color _lightSurface = Colors.white;
  static const Color _lightText = Color(0xFF1A1A1C);

  // Dark Theme Palette
  static const Color _darkPrimary = Color(0xFF7986CB);
  static const Color _darkSecondary = Color(0xFFFFB74D);
  static const Color _darkBackground = Color(0xFF121212);
  static const Color _darkSurface = Color(0xFF1E1E1E);
  static const Color _darkText = Color(0xFFE0E0E0);

  static final lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    primaryColor: _lightPrimary,
    scaffoldBackgroundColor: _lightBackground,
    colorScheme: const ColorScheme.light(
      primary: _lightPrimary,
      secondary: _lightSecondary,
      surface: _lightSurface,
      onSurface: _lightText,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: _lightPrimary,
      foregroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: _lightSecondary,
      foregroundColor: Colors.white,
    ),
    cardTheme: CardThemeData(
      color: _lightSurface,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
    textTheme: const TextTheme(
      titleLarge: TextStyle(
        color: _lightText,
        fontWeight: FontWeight.bold,
        fontSize: 22,
      ),
      bodyMedium: TextStyle(color: _lightText, fontSize: 16),
    ),
  );

  static final darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    primaryColor: _darkPrimary,
    scaffoldBackgroundColor: _darkBackground,
    colorScheme: const ColorScheme.dark(
      primary: _darkPrimary,
      secondary: _darkSecondary,
      surface: _darkSurface,
      onSurface: _darkText,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: _darkSurface,
      foregroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: _darkSecondary,
      foregroundColor: Colors.black,
    ),
    cardTheme: CardThemeData(
      color: _darkSurface,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
    textTheme: const TextTheme(
      titleLarge: TextStyle(
        color: _darkText,
        fontWeight: FontWeight.bold,
        fontSize: 22,
      ),
      bodyMedium: TextStyle(color: _darkText, fontSize: 16),
    ),
  );
}

extension ColorSchemeExtension on ColorScheme {
  Color get success => brightness == Brightness.light
      ? Colors.lightGreen.shade800
      : const Color(0xFF689F38);
}
