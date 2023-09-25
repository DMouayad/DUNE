import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fluent_ui/fluent_ui.dart' as fluent_ui;

extension DeviceInfoExtension on BuildContext {
  DeviceType get deviceTypeByScreen {
    if (isDesktop) {
      return DeviceType.desktop;
    }

    if (isTablet) {
      return DeviceType.tablet;
    }

    return DeviceType.mobile;
  }

  bool get isNotMobileDevice {
    return !isMobile || isDesktopPlatform;
  }
}

extension AdaptiveContextExtension on BuildContext {
  double get trackThumbnailDimension => isDesktop ? 44 : 46;
}

extension ResponsiveContextExtension on BuildContext {
  double get horizontalMargins {
    final screenWidth = MediaQuery.of(this).size.width;
    if (screenWidth <= 600) {
      return 16.0;
    } else if (screenWidth > 600 && screenWidth < 900) {
      return 26.0;
    } else if (screenWidth > 900 && screenWidth < 1200) {
      return 34.0;
    } else if (screenWidth >= 1200) {
      return screenWidth * 0.04;
    }
    return 12.0;
  }
}

extension ContextScreenSizeExtension on BuildContext {
  MediaQueryData get mediaQuery => MediaQuery.of(this);

  Size get deviceScreenSize => mediaQuery.size;

  double get screenHeight => deviceScreenSize.height;

  double get screenWidth => deviceScreenSize.width;

  Orientation get orientation => mediaQuery.orientation;

  bool get isPortraitMode => orientation == Orientation.portrait;

  bool get isLandscapeMode => orientation == Orientation.landscape;

  bool get isMobile => (isLandscapeMode ? screenHeight : screenWidth) < 600;

  bool get isLandscapeMobile => (isLandscapeMode && isMobile);

  bool get isLandScapeTablet =>
      isLandscapeMode && (screenHeight >= 600 && screenHeight < 980);

  bool get isPortraitTablet =>
      isPortraitMode && (screenWidth >= 600 && screenWidth < 980);

  bool get isTablet => isLandScapeTablet || isPortraitTablet;

  bool get isDesktop => screenWidth >= 980;

  double get maxNavRailWidth {
    return max(250.0, min(400.0, screenWidth * .2));
  }

  double get bottomPlayerBarHeight => isDesktopPlatform ? 76 : 100;
}

extension ContextThemeExtension on BuildContext {
  MediaQueryData get mediaQueryData => MediaQuery.of(this);

  /// similar to [MediaQuery.of(context).theme]
  ThemeData get theme => Theme.of(this);

  /// Check if dark mode theme is enable
  bool get isDarkMode => (theme.brightness == Brightness.dark);

  fluent_ui.FluentThemeData get fluentTheme => fluent_ui.FluentTheme.of(this);

  fluent_ui.Typography get fluentTextTheme => fluentTheme.typography;

  ThemeMode get themeMode => isDarkMode ? ThemeMode.dark : ThemeMode.light;

  ColorScheme get colorScheme => theme.colorScheme;

  TextTheme get textTheme => Theme.of(this).textTheme;

  TextStyle? get sectionHeaderTextStyle {
    return textTheme.titleMedium?.copyWith(
      color: colorScheme.onBackground,
      fontWeight: FontWeight.w500,
    );
  }

  BorderRadius get platformBorderRadius =>
      BorderRadius.circular(isWindowsPlatform
          ? 10
          : isIOSPlatform
              ? 8
              : 20);
}

extension ContextPlatformExtension on BuildContext {
  bool get isIOSPlatform => platform == TargetPlatform.iOS;

  bool get isMacOsPlatform => platform == TargetPlatform.macOS;

  bool get isDesktopPlatform {
    return platform == TargetPlatform.windows ||
        platform == TargetPlatform.macOS ||
        platform == TargetPlatform.linux;
  }

  bool get isWindowsPlatform =>
      platform == TargetPlatform.windows && Platform.isWindows;

  bool get isAndroidPlatform => platform == TargetPlatform.android;

  bool get isMobilePlatform =>
      platform == TargetPlatform.iOS || platform == TargetPlatform.android;

  TargetPlatform get platform => Theme.of(this).platform;
}

extension ContextLocaleExtension on BuildContext {
  bool get isArabicLocale => Localizations.localeOf(this).languageCode == 'ar';

  bool get isEnglishLocale => Localizations.localeOf(this).languageCode == 'en';

  bool get isRTL => isArabicLocale;

  bool get isLTR => isEnglishLocale;

  TextDirection get textDirection =>
      isLTR ? TextDirection.ltr : TextDirection.rtl;

  Locale get locale => Localizations.localeOf(this);
}

enum DeviceType { mobile, tablet, desktop }
