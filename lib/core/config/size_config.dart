import 'package:flutter/material.dart';

/// Global responsive config with cached scale factor and breakpoint logic.
class SizeConfig {
  static late double screenWidth;
  static late double screenHeight;
  static late double _scaleFactor;
  static late DeviceType deviceType;

  static const double _baseMobileWidth = 390.0;
  static const double _baseTabletWidth = 768.0;
  static const double _baseDesktopWidth = 1280.0;

  static void init(BuildContext context) {
    final size = MediaQuery.of(context).size;
    screenWidth = size.width;
    screenHeight = size.height;

    deviceType = _getDeviceType(screenWidth);
    _scaleFactor = _calculateScale(screenWidth);
  }

  /// Returns the cached scale factor.
  static double get scale => _scaleFactor;

  /// Returns current device type.
  static DeviceType get type => deviceType;

  /// Helper: get device type from width.
  static DeviceType _getDeviceType(double width) {
    if (width >= 1025) return DeviceType.desktop;
    if (width >= 601) return DeviceType.tablet;
    return DeviceType.mobile;
  }

  /// Calculates adaptive scale depending on breakpoint.
  static double _calculateScale(double width) {
    switch (_getDeviceType(width)) {
      case DeviceType.mobile:
        return width / _baseMobileWidth;
      case DeviceType.tablet:
        return width / _baseTabletWidth * 1.1; // a bit larger scaling
      case DeviceType.desktop:
        return width / _baseDesktopWidth * 1.2; // larger scaling
    }
  }
}

enum DeviceType { mobile, tablet, desktop }
