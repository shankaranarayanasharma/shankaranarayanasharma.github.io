import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppStyles {
  static ThemeData get darkTheme {
    return ThemeData.dark().copyWith(
      primaryColor: AppColors.primary,
      scaffoldBackgroundColor: AppColors.bg,
      canvasColor: AppColors.bg,
      textTheme: GoogleFonts.poppinsTextTheme().apply(bodyColor: Colors.white).copyWith(
            bodyLarge: const TextStyle(color: AppColors.bodyText),
            bodyMedium: const TextStyle(color: AppColors.bodyText),
          ),
    );
  }

  static const TextStyle sectionTitle = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  static const TextStyle categoryTag = TextStyle(
    fontSize: 9,
    fontWeight: FontWeight.bold,
    color: Colors.white,
    letterSpacing: 0.5,
  );
}
