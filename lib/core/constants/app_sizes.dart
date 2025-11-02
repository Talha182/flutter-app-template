import '../config/size_config.dart';

class AppSizes {
  // Base constants
  static const double paddingXS = 4;
  static const double paddingS = 8;
  static const double paddingM = 16;
  static const double paddingL = 24;
  static const double paddingXL = 32;

  static const double radiusS = 6;
  static const double radiusM = 12;
  static const double radiusL = 20;
  static const double radiusXL = 32;

  static const double fontS = 12;
  static const double fontM = 14;
  static const double fontL = 18;
  static const double fontXL = 24;

  static const double buttonHeight = 56;
  static const double inputHeight = 52;
  static const double appBarHeight = 64;

  /// Example: Return spacing adjusted per device type
  static double responsiveSpacing() {
    switch (SizeConfig.type) {
      case DeviceType.mobile:
        return 16 * SizeConfig.scale;
      case DeviceType.tablet:
        return 24 * SizeConfig.scale;
      case DeviceType.desktop:
        return 32 * SizeConfig.scale;
    }
  }

  /// Example: Return number of grid columns
  static int gridColumns() {
    switch (SizeConfig.type) {
      case DeviceType.mobile:
        return 2;
      case DeviceType.tablet:
        return 4;
      case DeviceType.desktop:
        return 6;
    }
  }
}
