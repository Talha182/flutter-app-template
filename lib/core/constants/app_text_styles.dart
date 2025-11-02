import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTextStyles {
  static const TextTheme textTheme = TextTheme(
    // ---------------- Headings (Bebas Neue) ----------------
    displayLarge: TextStyle(
      fontFamily: 'BebasNeue',
      fontSize: 57,
      fontWeight: FontWeight.w400,
      height: 1.1,
      color: AppColors.textPrimary,
      letterSpacing: 0.5,
    ),
    displayMedium: TextStyle(
      fontFamily: 'BebasNeue',
      fontSize: 45,
      fontWeight: FontWeight.w400,
      height: 1.15,
      color: AppColors.textPrimary,
      letterSpacing: 0.5,
    ),
    displaySmall: TextStyle(
      fontFamily: 'BebasNeue',
      fontSize: 36,
      fontWeight: FontWeight.w400,
      height: 1.2,
      color: AppColors.textPrimary,
      letterSpacing: 0.5,
    ),
    headlineLarge: TextStyle(
      fontFamily: 'BebasNeue',
      fontSize: 32,
      fontWeight: FontWeight.w400,
      height: 1.2,
      color: AppColors.textPrimary,
    ),
    headlineMedium: TextStyle(
      fontFamily: 'BebasNeue',
      fontSize: 28,
      fontWeight: FontWeight.w400,
      height: 1.25,
      color: AppColors.textPrimary,
    ),
    headlineSmall: TextStyle(
      fontFamily: 'BebasNeue',
      fontSize: 24,
      fontWeight: FontWeight.w400,
      height: 1.25,
      color: AppColors.textPrimary,
    ),
    titleLarge: TextStyle(
      fontFamily: 'BebasNeue',
      fontSize: 20,
      fontWeight: FontWeight.w400,
      height: 1.25,
      color: AppColors.textPrimary,
    ),

    // ---------------- Body Text (Outfit) ----------------
    bodyLarge: TextStyle(
      fontFamily: 'Outfit',
      fontSize: 16,
      fontWeight: FontWeight.w400,
      height: 1.5,
      color: AppColors.textPrimary,
    ),
    bodyMedium: TextStyle(
      fontFamily: 'Outfit',
      fontSize: 14,
      fontWeight: FontWeight.w400,
      height: 1.5,
      color: AppColors.textSecondary,
    ),
    bodySmall: TextStyle(
      fontFamily: 'Outfit',
      fontSize: 12,
      fontWeight: FontWeight.w400,
      height: 1.4,
      color: AppColors.textSecondary,
    ),

    // ---------------- Labels / Buttons (Outfit) ----------------
    labelLarge: TextStyle(
      fontFamily: 'Outfit',
      fontSize: 18,
      fontWeight: FontWeight.w700, // Bold
      height: 1.4,
      color: AppColors.textPrimary,
    ),
    labelMedium: TextStyle(
      fontFamily: 'Outfit',
      fontSize: 14,
      fontWeight: FontWeight.w600, // SemiBold
      height: 1.4,
      color: AppColors.textPrimary,
    ),
    labelSmall: TextStyle(
      fontFamily: 'Outfit',
      fontSize: 11,
      fontWeight: FontWeight.w500, // Slightly thicker
      height: 1.4,
      color: AppColors.textPrimary,
    ),
  );
}
