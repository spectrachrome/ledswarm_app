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
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedItemColor: Colors.white, // Selected icon/text color
      unselectedItemColor: Colors.white, // Unselected icon/text color
      selectedIconTheme: IconThemeData(
        // Selected icon specific styling
        color: Colors.white,
        size: 30,
      ),
      unselectedIconTheme: IconThemeData(
        // Unselected icon specific styling
        color: Colors.grey,
        size: 24,
      ),
      selectedLabelStyle: TextStyle(
        // Selected text styling
        color: Colors.blue,
        fontWeight: FontWeight.bold,
      ),
      unselectedLabelStyle: TextStyle(
        // Unselected text styling
        color: Colors.grey,
      ),
    ),
  );
}
