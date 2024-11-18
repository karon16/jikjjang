import 'package:flutter/material.dart';
import 'package:jikjjang_app/utils/constants/colors.dart';

class JAppBarTheme {
  JAppBarTheme._();

  static const lightAppBarTheme = AppBarTheme(
    backgroundColor: JAppColors.primary, // Light theme app bar background color
    foregroundColor: Colors.white, // Light theme app bar text and icon color
    elevation: 4.0, // Light shadow effect
    titleTextStyle: TextStyle(
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
      color: Colors.white, // App bar title text color in light theme
    ),
    iconTheme: IconThemeData(
      color: Colors.white, // Icon color in light theme
    ),
  );

  static const darkAppBarTheme = AppBarTheme(
    backgroundColor:
        JAppColors.primary, // Dark theme app bar background color
    foregroundColor: Colors.white, // Dark theme app bar text and icon color
    elevation: 4.0, // Dark shadow effect
    titleTextStyle: TextStyle(
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
      color: Colors.white, // App bar title text color in dark theme
    ),
    iconTheme: IconThemeData(
      color: Colors.white, // Icon color in dark theme
    ),
  );
}
