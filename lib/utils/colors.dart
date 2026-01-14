import 'package:flutter/material.dart';

class AppColors {
  static const Color primaryBlue = Color(0xFF00B2FF);
  static const Color selectionCyan = Color(0xFF64E9FF);
  static const Color backgroundWhite = Color(0xFFFFFFFF);
  static const Color borderGrey = Color(0xFFE0E0E0);
  static const Color textBlack = Color(0xFF212121);
  static const Color textGrey = Color(0xFF757575);
}

class AppStyles {
  // Standard Button Height
  static const double buttonHeight = 56.0;
  
  // Standard Border Radius
  static const double borderRadius = 16.0;

  // Standard Fonts
  static const TextStyle heading = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: AppColors.textBlack,
  );

  static const TextStyle bodyText = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: AppColors.textBlack,
  );
}