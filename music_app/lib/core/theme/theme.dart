import 'package:flutter/material.dart';
import 'package:music_app/core/theme/app_pallet.dart';

class AppTheme {
  static OutlineInputBorder _border({required Color borderColor}) =>
      OutlineInputBorder(
        borderSide: BorderSide(color: borderColor, width: 3),
        borderRadius: BorderRadius.circular(10),
      );
  static final ThemeData finalDarkTheme = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: Pallete.backgroundColor,
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.all(27),
      enabledBorder: _border(borderColor: Pallete.borderColor),
      focusedBorder: _border(borderColor: Pallete.gradient2),
    ),
  );
}
