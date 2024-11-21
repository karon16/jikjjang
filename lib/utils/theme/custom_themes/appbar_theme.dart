import 'package:flutter/material.dart';
import 'package:jikjjang_app/utils/constants/colors.dart';

class JAppBarTheme {
  JAppBarTheme._();

  static const lightAppBarTheme = AppBarTheme(
    backgroundColor:
        JAppColors.backgroundLight, // Light theme app bar background color
    foregroundColor:
        JAppColors.primary, // Light theme app bar text and icon color
    elevation: 4.0, // Light shadow effect
    titleTextStyle: TextStyle(
      fontSize: 18.0,
      fontWeight: FontWeight.w600,
      color: JAppColors.textPrimary, // App bar title text color in light theme
    ),
    iconTheme: IconThemeData(
      color: JAppColors.textPrimary, // Icon color in light theme
    ),
  );

  static const darkAppBarTheme = AppBarTheme(
    backgroundColor:
        JAppColors.backgroundDark, // Dark theme app bar background color
    foregroundColor:
        JAppColors.primary, // Dark theme app bar text and icon color
    elevation: 4.0, // Dark shadow effect
    titleTextStyle: TextStyle(
      fontSize: 18.0,
      fontWeight: FontWeight.w600,
      color: JAppColors.textLight, // App bar title text color in dark theme
    ),
    iconTheme: IconThemeData(
      color: JAppColors.textLight, // Icon color in dark theme
    ),
  );
}
