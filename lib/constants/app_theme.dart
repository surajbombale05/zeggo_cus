import 'package:flutter/material.dart';
import 'package:zeggo_cus/constants/app_colors.dart';

class AppTheme {
  ThemeData theme = ThemeData(
    appBarTheme: AppBarTheme(
      surfaceTintColor: AppColors.white,
      backgroundColor: AppColors.white,
    ),
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
    useMaterial3: true,
    primaryColor: Color(0xFFFF6700),
  );
}
