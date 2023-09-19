import 'package:dune/domain/theme/app_theme.dart';
import 'package:dune/support/helpers/platform_helpers.dart';
import 'package:flutter/material.dart';

final class MaterialThemes {
  static final _baseTheme = ThemeData(
    buttonTheme: ButtonThemeData(
      shape: isDesktopPlatform
          ? RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))
          : null,
    ),
  );

  static ThemeData themeDataFromAppTheme(AppTheme appTheme) {
    return appTheme.isDarkMode
        ? _getDarkTheme(appTheme)
        : _getLightTheme(appTheme);
  }

  static ThemeData _getDarkTheme(AppTheme appTheme) {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: appTheme.primaryColor,
      brightness: Brightness.dark,
    );
    return ThemeData.dark().copyWith(
      colorScheme: colorScheme,
      textTheme: Typography().white.apply(
            fontFamily: 'work_sans',
            bodyColor: colorScheme.onBackground,
            displayColor: colorScheme.secondary,
          ),
      buttonTheme: _baseTheme.buttonTheme,
    );
  }

  static ThemeData _getLightTheme(AppTheme appTheme) {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: appTheme.primaryColor,
      brightness: Brightness.light,
    );
    return ThemeData.light().copyWith(
      buttonTheme: _baseTheme.buttonTheme,
      colorScheme: colorScheme,
      textTheme: Typography().black.apply(
            fontFamily: 'work_sans',
            bodyColor: colorScheme.onBackground,
            displayColor: colorScheme.secondary,
          ),
    );
  }
}
