import 'package:flutter/material.dart';
import 'package:jikjjang_app/core/constants/colors.dart';

class JFloatingActionButtonTheme {
  JFloatingActionButtonTheme._();

  static final lightFloatingActionButtonTheme = FloatingActionButtonThemeData(
    backgroundColor: JAppColors.primary, // Purple for light theme
    foregroundColor: Colors.white, // White icon color
    elevation: 4.0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8.0), // Rounded corners
    ),
  );

  static final darkFloatingActionButtonTheme = FloatingActionButtonThemeData(
    backgroundColor: JAppColors.primary, // Purple for dark theme
    foregroundColor: JAppColors.backgroundDark, // White icon color
    elevation: 4.0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8.0), // Rounded corners
    ),
  );
}
