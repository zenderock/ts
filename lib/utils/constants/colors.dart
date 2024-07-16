import 'package:flutter/material.dart';

class TVColors {
  TVColors._();

  // App basic colors

  static const Color primary = Color.fromARGB(1, 155, 4, 5);
  static const Color secondary = Color(0xFFFFE24B);
  static const Color tertiary = Color(0xFFb0c7ff);

  // text colors

  static const Color textPrimary = Color(0xFF000000);
  static const Color textSecondary = Color(0xFF666666);
  static const Color textTertiary = Color(0xFF999999);

  // background colors

  static const Color backgroundPrimary = Color(0xFFFFFFFF);
  static const Color backgroundSecondary = Color(0xFFF5F5F5);
  static const Color backgroundTertiary = Color(0xFFEEEEEE);

  // Buttons colors

  static const Color buttonPrimary = Color(0xFF007AFF);
  static const Color buttonSecondary = Color(0xFF6C757D);
  static const Color buttonTertiary = Color(0xFFC4C4C4);

  // Borders colors

  static const Color borderPrimary = Color(0xFFD9D9D9);
  static const Color borderSecondary = Color(0xFFE6E6E6);

  // Errors and validations colors

  static const Color error = Color(0xFFF44336);
  static const Color success = Color(0xFF4CAF50);
  static const Color warning = Color(0xFFFF9800);
  static const Color info = Color(0xFF2196F3);

  // Neutral shades colors

  static const Color grey = Color(0xFFE0E0E0);
  static const darkGrey = Color(0xFF666666);

  // Gradient colors

  static const Gradient gradientPrimary = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFF007AFF),
      Color.fromARGB(255, 46, 142, 245),
      Color.fromARGB(255, 0, 110, 228),
    ],
  );
}
