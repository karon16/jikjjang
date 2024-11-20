import 'package:flutter/material.dart';
import 'package:jikjjang_app/utils/constants/colors.dart';

class JTextFieldTheme {
  JTextFieldTheme._();

  static final lightTextFieldTheme = InputDecorationTheme(
    filled: true,
    fillColor:
        JAppColors.backgroundLight, // Light background color for text fields
    iconColor: JAppColors.primary, // Icon color in text field
    labelStyle: const TextStyle(
      color: JAppColors.textPrimary, // Label text color for light theme
    ),
    hintStyle: const TextStyle(
      color: JAppColors.textSecondary, // Hint text color for light theme
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0), // Rounded border
      borderSide: const BorderSide(
          color: JAppColors.textSecondary), // Light theme border color
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
      borderSide: const BorderSide(
          color: JAppColors.primary,
          width: 2.0), // Focused border color for light theme
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
      borderSide: const BorderSide(
          color:
              JAppColors.textSecondary), // Enabled border color for light theme
    ),
  );

  static final darkTextFieldTheme = InputDecorationTheme(
    filled: true,
    fillColor:
        JAppColors.backgroundDark, // Dark background color for text fields
    iconColor: Colors.white, // Icon color in text field for dark theme
    labelStyle: const TextStyle(
      color: Colors.white, // Label text color for dark theme
    ),
    hintStyle: TextStyle(
      color: Colors.grey.shade400, // Hint text color for dark theme
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
      borderSide:
          BorderSide(color: Colors.grey.shade700), // Dark theme border color
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
      borderSide: const BorderSide(
          color: Colors.white,
          width: 2.0), // Focused border color for dark theme
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
      borderSide: BorderSide(
          color: Colors.grey.shade700), // Enabled border color for dark theme
    ),
  );
}
