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
        ? ThemeData.dark().copyWith(
            colorScheme: ColorScheme.fromSeed(
              seedColor: appTheme.primaryColor,
              brightness: Brightness.dark,
            ),
            buttonTheme: _baseTheme.buttonTheme,
          )
        : ThemeData.light().copyWith(
            buttonTheme: _baseTheme.buttonTheme,
            colorScheme: ColorScheme.fromSeed(
              seedColor: appTheme.primaryColor,
              brightness: Brightness.light,
            ),
          );
  }
}
