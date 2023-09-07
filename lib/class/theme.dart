import 'package:flutter/material.dart';

class AppTheme {
  lightTheme() {
    final theme = ThemeData(
        brightness: Brightness.light,
        primarySwatch: const MaterialColor(0xFF226FE3, <int, Color>{
          50: Color(0xFFE0F0FF),
          100: Color(0xFFB3D2FF),
          200: Color(0xFF80ABFF),
          300: Color(0xFF4D84FF),
          400: Color(0xFF226FE3),
          500: Color(0xFF1C64D4), // Your primary color
          600: Color(0xFF195ABE),
          700: Color(0xFF1550A9),
          800: Color(0xFF124695),
          900: Color(0xFF0E3C80),
        }),
        fontFamily: 'QuickSand');

    return theme.copyWith(
      colorScheme: theme.colorScheme.copyWith(
          primary: const Color(0xFF267CFF),
          secondary: const Color(0xFF4D94FF),
          tertiary: const Color(0xFF00BCD4)),
      textTheme: theme.textTheme.copyWith(
          titleLarge: const TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
          labelLarge: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold)),
      appBarTheme: const AppBarTheme(
        titleTextStyle: TextStyle(
          fontFamily: 'OpenSans',
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  darkTheme() {
    final theme = ThemeData(
        brightness: Brightness.dark,
        primarySwatch: const MaterialColor(0xFF252533, <int, Color>{
          50: Color(0xFF252533),
          100: Color(0xFF252533),
          200: Color(0xFF252533),
          300: Color(0xFF252533),
          400: Color(0xFF252533),
          500: Color(0xFF252533),
          600: Color(0xFF252533),
          700: Color(0xFF252533),
          800: Color(0xFF252533),
          900: Color(0xFF252533),
        }),
        fontFamily: 'QuickSand');

    return theme.copyWith(
      floatingActionButtonTheme: theme.floatingActionButtonTheme.copyWith(
        backgroundColor: const Color(0xFF626270),
        foregroundColor: Colors.white,
      ),
      colorScheme: theme.colorScheme.copyWith(
          primary: const Color(0xFF252533),
          secondary: const Color(0xFF2A2E3B),
          tertiary: const Color(0xFFFFFFFF)),
      expansionTileTheme: theme.expansionTileTheme
          .copyWith(textColor: Colors.white, iconColor: Colors.white),
      inputDecorationTheme: theme.inputDecorationTheme.copyWith(
        labelStyle: const TextStyle(
          color: Colors.white,
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
      ),
      textTheme: theme.textTheme.copyWith(
          titleSmall: const TextStyle(color: Colors.white),
          titleMedium: const TextStyle(color: Colors.white),
          titleLarge: const TextStyle(
            fontFamily: 'OpenSans',
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          labelLarge: const TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold)),
      appBarTheme: const AppBarTheme(
        titleTextStyle: TextStyle(
          fontFamily: 'OpenSans',
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
