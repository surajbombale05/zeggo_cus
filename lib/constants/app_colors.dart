import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  static const Color primaryDark = Color(0xFF0B0F1A);
  static const Color secondaryDark = Color(0xFF1A1F3C);
  static Color kGreyColor = Color(0xFFE5E5E5);
  static const Color accentPurple = Color(0xFF7C4DFF);
  static const Color accentCyan = Color(0xFF00E5FF);
  static const Color primaryColor = Color(0xFFFF6700);
  static const Color white = Colors.white;
  static Color white70 = Colors.white.withValues(alpha: 0.7);
  static Color white75 = Colors.white.withValues(alpha: 0.75);

  static const LinearGradient splashGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [primaryDark, secondaryDark],
  );

  static const LinearGradient logoGradient = LinearGradient(colors: [accentPurple, accentCyan]);
}
