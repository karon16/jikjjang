import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jikjjang_app/core/constants/colors.dart';
import 'package:jikjjang_app/core/constants/font_size.dart';

class JTextTheme {
  JTextTheme._();

  static TextTheme lightTextTheme = TextTheme(
    headlineLarge: GoogleFonts.nunito(
      fontSize: JFontSizes.headlineLarge,
      color: JAppColors.textPrimary,
    ),
    headlineMedium: GoogleFonts.nunito(
      fontSize: JFontSizes.headlineMedium,
      color: JAppColors.textPrimary,
    ),
    bodyMedium: GoogleFonts.nunito(
      fontSize: JFontSizes.bodyMedium,
      color: JAppColors.textSecondary,
    ),
    bodySmall: GoogleFonts.nunito(
      fontSize: JFontSizes.bodySmall,
      color: JAppColors.textSecondary,
    ),
  );

  static TextTheme darkTextTheme = TextTheme(
    headlineLarge: GoogleFonts.nunito(
      fontSize: JFontSizes.headlineLarge,
      color: JAppColors.textLight,
    ),
    headlineMedium: GoogleFonts.nunito(
      fontSize: JFontSizes.headlineMedium,
      color: JAppColors.textLight,
    ),
    bodyMedium: GoogleFonts.nunito(
      fontSize: JFontSizes.bodyMedium,
      color: JAppColors.textLight,
    ),
    bodySmall: GoogleFonts.nunito(
      fontSize: JFontSizes.bodySmall,
      color: JAppColors.textLight,
    ),
  );
}
