import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_theme.g.dart';

class AppTheme {
  ThemeData get lightTheme {
    return ThemeData(
      textTheme: GoogleFonts.notoSansTextTheme(ThemeData.light().textTheme),
      visualDensity: VisualDensity.adaptivePlatformDensity,
      brightness: Brightness.light,
      primaryColor: Colors.black,
      colorScheme: const ColorScheme.light(
        primary: Colors.black,
        secondary: Colors.grey,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: Colors.black,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(foregroundColor: Colors.grey[600]),
      ),
      inputDecorationTheme: const InputDecorationTheme(
        prefixIconColor: Colors.grey,
      ),
      // colorScheme: ColorScheme.fromSeed(
      //   seedColor: const Color.fromARGB(255, 225, 212, 67),
      // ),
    );
  }

  ThemeData get darkTheme {
    return ThemeData(
      textTheme: GoogleFonts.notoSansTextTheme(ThemeData.dark().textTheme),
      visualDensity: VisualDensity.adaptivePlatformDensity,
      brightness: Brightness.dark,
      primaryColor: Colors.white,
      colorScheme: const ColorScheme.dark(
        primary: Colors.white,
        secondary: Colors.grey,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.black,
          backgroundColor: Colors.white,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(foregroundColor: Colors.grey[400]),
      ),
      inputDecorationTheme: const InputDecorationTheme(
        prefixIconColor: Colors.grey,
      ),
      // colorScheme: ColorScheme.fromSeed(
      //   seedColor: Colors.yellow,
      //   brightness: Brightness.dark,
      // ),
    );
  }
}

@riverpod
class AppThemeMode extends _$AppThemeMode {
  @override
  ThemeMode build() => ThemeMode.light;

  void toggleTheme() {
    state = state == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
  }
}
