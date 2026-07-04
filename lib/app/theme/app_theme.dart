import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: Colors.black,
      primaryColor: Colors.deepPurple,
      useMaterial3: true,
      colorScheme: const ColorScheme.dark(
        primary: Colors.deepPurple,
        surface: Color(0xFF121212),
      ),
    );
  }
}
