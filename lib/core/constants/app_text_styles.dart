import 'package:flutter/material.dart';

class AppTextStyles {
  static const TextTheme textTheme = TextTheme(
    // headings with Merriweather
    headlineMedium: TextStyle(
      fontFamily: 'Merriweather',
      fontSize: 24,
      fontWeight: FontWeight.w600,
      height: 1.3,
    ),
    titleLarge: TextStyle(
      fontFamily: 'Merriweather',
      fontSize: 20,
      fontWeight: FontWeight.w500,
    ),

    // body with Poppins (14)
    bodyMedium: TextStyle(
      fontFamily: 'Poppins',
      fontSize: 14,
      fontWeight: FontWeight.w400,
    ),
    bodySmall: TextStyle(
      fontFamily: 'Poppins',
      fontSize: 12,
    ),

    // buttons / labels (18 for contrast)
    labelLarge: TextStyle(
      fontFamily: 'Poppins',
      fontSize: 18,
      fontWeight: FontWeight.w600,
    ),
  );
}
