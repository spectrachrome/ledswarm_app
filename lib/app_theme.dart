import 'package:flutter/material.dart';

// Simple theme configurations
class AppThemes {
  // Light Theme
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xFF5C624E),
      brightness: Brightness.light,
    ),
  );

  // Dark Theme
  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xFF5C624E),
      brightness: Brightness.dark,
    ),
  );

  // OLED Dark Theme (pure black backgrounds)
  static final ThemeData oledDarkTheme = ThemeData(
    brightness: Brightness.dark,
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xFF5C624E),
      brightness: Brightness.dark,
      surface: Colors.black,
      background: Colors.black,
    ),
    scaffoldBackgroundColor: Colors.black,
    cardColor: const Color(0xFF0A0A0A),
  );
}
