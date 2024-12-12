// lib/config/theme.dart

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Colors
  static const _primaryDark = Color(0xFF000000);
  static const _primaryLight = Color(0xFFFFFFFF);
  static const _accentColor = Color(0xFF33B074);

  // Light Theme
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: const ColorScheme.light(
      primary: _primaryDark,
      secondary: _accentColor,
      background: _primaryLight,
      surface: _primaryLight,
    ),
    scaffoldBackgroundColor: _primaryLight,
    appBarTheme: const AppBarTheme(
      elevation: 0,
      backgroundColor: _primaryLight,
      foregroundColor: _primaryDark,
      centerTitle: true,
    ),
    cardTheme: CardTheme(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: Colors.black12, width: 0.5),
      ),
    ),
    textTheme: GoogleFonts.dmSansTextTheme(
      ThemeData.light().textTheme.copyWith(
            displayLarge: const TextStyle(color: _primaryDark),
            bodyLarge: const TextStyle(color: _primaryDark),
          ),
    ),
    iconTheme: const IconThemeData(color: _primaryDark),
  );

  // Dark Theme
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: const ColorScheme.dark(
      primary: _primaryLight,
      secondary: _accentColor,
      background: _primaryDark,
      surface: _primaryDark,
    ),
    scaffoldBackgroundColor: _primaryDark,
    appBarTheme: const AppBarTheme(
      elevation: 0,
      backgroundColor: _primaryDark,
      foregroundColor: _primaryLight,
      centerTitle: true,
    ),
    cardTheme: CardTheme(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: Colors.white12, width: 0.5),
      ),
    ),
    textTheme: GoogleFonts.dmSansTextTheme(
      ThemeData.dark().textTheme.copyWith(
            displayLarge: const TextStyle(color: _primaryLight),
            bodyLarge: const TextStyle(color: _primaryLight),
          ),
    ),
    iconTheme: const IconThemeData(color: _primaryLight),
  );
}
