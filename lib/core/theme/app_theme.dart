import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class AppTheme {
  static const Color _primaryColor = Color(0xFFFFD600);
  static const Color _onPrimaryColor = Color(0xFF000000);
  static const Color _backgroundColor = Color(0xFF1a1a1a);
  static const Color _onBackgroundColor = Color(0xFFFFFFFF);
  static const Color _onSurface = Color(0xFFFFFFFF);
  static const Color _secondary = Color(0xFFFFFFFF);
  static const Color _tertiary = Color(0xFF000000);
  static const Color _error = Color(0xFFFF8F00);

  static ThemeData get lightTheme {
    return ThemeData(
      brightness: Brightness.light,
      primaryColor: _primaryColor,
      colorScheme: ColorScheme.light(
        primary: _primaryColor,
        onPrimary: _onPrimaryColor,
        onSurface: _onSurface,
        surface: _backgroundColor,
        secondary: _secondary,
        tertiary: _tertiary,
        error: _error,
      ),
      scaffoldBackgroundColor: _backgroundColor,
      textTheme: const TextTheme(
        bodyMedium: TextStyle(color: _onBackgroundColor),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: _primaryColor,
          foregroundColor: _onPrimaryColor,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: _primaryColor,
          textStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp),
        ),
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: _primaryColor,
      scaffoldBackgroundColor: _backgroundColor,
      textTheme: const TextTheme(
        bodyMedium: TextStyle(color: _onBackgroundColor),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: _primaryColor,
          foregroundColor: _onPrimaryColor,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: _primaryColor,
          textStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp),
        ),
      ),
    );
  }
}
