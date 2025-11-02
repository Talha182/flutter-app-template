import 'package:flutter/material.dart';
import '../config/size_config.dart';

class ResponsiveTextTheme {
  static TextTheme get scaled {
    final scale = _adjustedScale();

    return TextTheme(
      displayLarge: _bebas(57, scale),
      displayMedium: _bebas(45, scale),
      displaySmall: _bebas(36, scale),
      headlineLarge: _bebas(32, scale),
      headlineMedium: _bebas(28, scale),
      headlineSmall: _bebas(24, scale),
      titleLarge: _bebas(20, scale),
      bodyLarge: _outfit(16, scale),
      bodyMedium: _outfit(14, scale),
      bodySmall: _outfit(12, scale),
      labelLarge: _outfit(18, scale, FontWeight.w700),
      labelMedium: _outfit(14, scale, FontWeight.w600),
      labelSmall: _outfit(11, scale, FontWeight.w500),
    );
  }

  static double _adjustedScale() {
    final scale = SizeConfig.scale;
    switch (SizeConfig.type) {
      case DeviceType.mobile:
        return scale;
      case DeviceType.tablet:
        return scale * 1.1;
      case DeviceType.desktop:
        return scale * 1.2;
    }
  }

  static TextStyle _bebas(double size, double scale, [FontWeight weight = FontWeight.w400]) {
    return TextStyle(
      fontFamily: 'BebasNeue',
      fontSize: size * scale,
      fontWeight: weight,
      height: 1.2,
      letterSpacing: 0.5,
    );
  }

  static TextStyle _outfit(double size, double scale, [FontWeight weight = FontWeight.w400]) {
    return TextStyle(
      fontFamily: 'Outfit',
      fontSize: size * scale,
      fontWeight: weight,
      height: 1.4,
    );
  }
}
