import 'package:flutter/material.dart';
import 'package:jikjjang_app/utils/constants/colors.dart';

class JBottomNavigationBottomBar {
  static final lightTheme = NavigationBarThemeData(
    backgroundColor: JAppColors.backgroundNavigationBarLight,
    indicatorColor: Colors.transparent,
    iconTheme: WidgetStateProperty.resolveWith<IconThemeData>((states) {
      if (states.contains(WidgetState.selected)) {
        return const IconThemeData(
            color: JAppColors.primary); // Color for selected icon
      }
      return const IconThemeData(
          color: JAppColors.lightIconSecondary); // Color for unselected icon
    }),
    labelTextStyle: WidgetStateProperty.resolveWith<TextStyle>((states) {
      if (states.contains(WidgetState.selected)) {
        return const TextStyle(
          color: JAppColors.primary, // Color for selected label
          fontWeight: FontWeight.w900,
        );
      }
      return const TextStyle(
        color: JAppColors.textPrimary, // Color for unselected label
        fontWeight: FontWeight.w500,
      );
    }),
  );

  static final darkTheme = NavigationBarThemeData(
    backgroundColor: JAppColors.backgroundNavigationBarDark,
    indicatorColor: Colors.transparent,
    iconTheme: WidgetStateProperty.resolveWith<IconThemeData>((states) {
      if (states.contains(WidgetState.selected)) {
        return const IconThemeData(
            color: JAppColors.primary); // Color for selected icon
      }
      return const IconThemeData(
          color: JAppColors.darkIconSecondary); // Color for unselected icon
    }),
    labelTextStyle: WidgetStateProperty.resolveWith<TextStyle>((states) {
      if (states.contains(WidgetState.selected)) {
        return const TextStyle(
          color: JAppColors.primary, // Color for selected label
          fontWeight: FontWeight.w500,
        );
      }
      return const TextStyle(
        color: JAppColors.textLight, // Color for unselected label
        fontWeight: FontWeight.w500,
      );
    }),
  );
}
