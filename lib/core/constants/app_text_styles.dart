import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ResponsiveTextTheme {
  static TextTheme get scaled => TextTheme(
    displayLarge: _bebas(57),
    displayMedium: _bebas(45),
    displaySmall: _bebas(36),
    headlineLarge: _bebas(32),
    headlineMedium: _bebas(28),
    headlineSmall: _bebas(24),
    titleLarge: _bebas(20),
    bodyLarge: _outfit(16),
    bodyMedium: _outfit(14),
    bodySmall: _outfit(12),
    labelLarge: _outfit(18, FontWeight.w700),
    labelMedium: _outfit(14, FontWeight.w600),
    labelSmall: _outfit(11, FontWeight.w500),
  );

  static TextStyle _bebas(double size, [FontWeight weight = FontWeight.w400]) {
    return TextStyle(
      fontFamily: 'BebasNeue',
      fontSize: size.sp,
      fontWeight: weight,
      height: 1.2,
      letterSpacing: 0.5,
    );
  }

  static TextStyle _outfit(double size, [FontWeight weight = FontWeight.w400]) {
    return TextStyle(
      fontFamily: 'Outfit',
      fontSize: size.sp,
      fontWeight: weight,
      height: 1.4,
    );
  }
}
