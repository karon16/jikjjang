import 'package:flutter/material.dart';
import 'package:jikjjang_app/core/constants/colors.dart';
import 'package:jikjjang_app/core/theme/custom_themes/appbar_theme.dart';
import 'package:jikjjang_app/core/theme/custom_themes/elevated_button_theme.dart';
import 'package:jikjjang_app/core/theme/custom_themes/floating_action_button_theme.dart';
import 'package:jikjjang_app/core/theme/custom_themes/text_theme.dart';
import 'package:jikjjang_app/core/theme/custom_themes/textfield_theme.dart';

class JAppTheme {
  JAppTheme._();

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    primaryColor: JAppColors.primary,
    scaffoldBackgroundColor: JAppColors.backgroundLight,
    textTheme: JTextTheme.lightTextTheme,
    elevatedButtonTheme: JElevatedButtonTheme.lightElevatedButtonTheme,
    appBarTheme: JAppBarTheme.lightAppBarTheme,
    inputDecorationTheme: JTextFieldTheme.lightTextFieldTheme,
    floatingActionButtonTheme:
        JFloatingActionButtonTheme.lightFloatingActionButtonTheme,
  );

  static ThemeData darkTheme = ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      primaryColor: JAppColors.primary,
      scaffoldBackgroundColor: JAppColors.backgroundDark,
      textTheme: JTextTheme.darkTextTheme,
      elevatedButtonTheme: JElevatedButtonTheme.darkElevatedButtonTheme,
      appBarTheme: JAppBarTheme.darkAppBarTheme,
      inputDecorationTheme: JTextFieldTheme.darkTextFieldTheme,
      floatingActionButtonTheme:
          JFloatingActionButtonTheme.darkFloatingActionButtonTheme);
}
