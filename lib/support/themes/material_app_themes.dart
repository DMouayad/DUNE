import 'package:dune/domain/theme/app_theme.dart';
import 'package:dune/support/helpers/platform_helpers.dart';
import 'package:flutter/material.dart';

final class MaterialAppThemes {
  static final _baseTheme = ThemeData(
    buttonTheme: ButtonThemeData(
      shape: isDesktopPlatform
          ? RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))
          : null,
    ),
  );

  static ThemeData themeDataFromAppTheme(AppTheme appTheme) {
    return appTheme.isDarkMode ? darkTheme(appTheme) : lightTheme(appTheme);
  }

  static ThemeData darkTheme(AppTheme appTheme) {
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

  static ThemeData lightTheme(AppTheme appTheme) {
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
