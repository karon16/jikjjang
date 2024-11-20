import 'package:flutter/material.dart';
import 'package:jikjjang_app/utils/constants/colors.dart';

class JElevatedButtonTheme {
  JElevatedButtonTheme._();

  static final lightElevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 2.0,
      backgroundColor: JAppColors.primary, // Light theme button color
      foregroundColor: Colors.white, // Text color on light theme button
      padding: const EdgeInsets.symmetric(
          vertical: 16.0, horizontal: 24.0), // Padding to match button size
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0), // Rounded corners
      ),
      textStyle: const TextStyle(
        fontSize: 18.0,
        // fontWeight: FontWeight.bold,
      ),
    ),
  );

  static final darkElevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 2.0,
      backgroundColor: JAppColors.primary, // Dark theme button color
      foregroundColor: Colors.white, // Text color on dark theme button
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      textStyle: const TextStyle(
        fontSize: 18.0,
        // fontWeight: FontWeight.bold,
      ),
    ),
  );
}
