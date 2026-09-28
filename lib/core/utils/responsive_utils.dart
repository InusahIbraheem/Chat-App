import 'package:flutter/material.dart';

import '../constants/app_constants.dart';

enum ScreenType { mobile, tablet, desktop }

class ResponsiveUtils {
  ResponsiveUtils._();

  static ScreenType screenType(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    if (width >= AppConstants.desktopBreakpoint) {
      return ScreenType.desktop;
    }
    if (width >= AppConstants.tabletBreakpoint) {
      return ScreenType.tablet;
    }
    return ScreenType.mobile;
  }

  static bool isMobile(BuildContext context) =>
      screenType(context) == ScreenType.mobile;

  static bool isTablet(BuildContext context) =>
      screenType(context) == ScreenType.tablet;

  static bool isDesktop(BuildContext context) =>
      screenType(context) == ScreenType.desktop;

  static double contentMaxWidth(BuildContext context) {
    switch (screenType(context)) {
      case ScreenType.desktop:
        return 960;
      case ScreenType.tablet:
        return 720;
      case ScreenType.mobile:
        return double.infinity;
    }
  }

  static EdgeInsets pagePadding(BuildContext context) {
    switch (screenType(context)) {
      case ScreenType.desktop:
        return const EdgeInsets.symmetric(
          horizontal: AppConstants.spacingXl,
          vertical: AppConstants.spacingLg,
        );
      case ScreenType.tablet:
        return const EdgeInsets.symmetric(
          horizontal: AppConstants.spacingLg,
          vertical: AppConstants.spacingMd,
        );
      case ScreenType.mobile:
        return const EdgeInsets.symmetric(
          horizontal: AppConstants.spacingMd,
          vertical: AppConstants.spacingSm,
        );
    }
  }

  static int gridColumns(BuildContext context) {
    switch (screenType(context)) {
      case ScreenType.desktop:
        return 4;
      case ScreenType.tablet:
        return 3;
      case ScreenType.mobile:
        return 2;
    }
  }
}
