import 'package:dune/domain/theme/app_theme.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' as material;

class FluentAppThemes {
  static TooltipThemeData getTooltipTheme(bool isDarkMode) {
    return TooltipThemeData(
        waitDuration: const Duration(milliseconds: 700),
        showDuration: const Duration(milliseconds: 300),
        decoration: () {
          const radius = BorderRadius.zero;
          final shadow = [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              offset: const Offset(1, 1),
              blurRadius: 10.0,
            ),
          ];
          final border = Border.all(color: Colors.grey[100], width: 0.5);
          if (isDarkMode) {
            return BoxDecoration(
              color: material.Colors.white10,
              borderRadius: radius,
              border: border,
              boxShadow: shadow,
            );
          } else {
            return BoxDecoration(
              color: Colors.white,
              borderRadius: radius,
              border: border,
              boxShadow: shadow,
            );
          }
        }());
  }

  static FluentThemeData getThemeDataFrom(AppTheme appTheme) {
    final colorScheme = appTheme.colorScheme;
    FluentThemeData themeData = colorScheme.brightness == Brightness.dark
        ? FluentThemeData.dark()
        : FluentThemeData.light();

    return themeData.copyWith(
      visualDensity: VisualDensity.standard,
      menuColor: colorScheme.surface,
      scaffoldBackgroundColor: Colors.transparent,
      accentColor: _getAccentColor(colorScheme),
      tooltipTheme: FluentAppThemes.getTooltipTheme(appTheme.isDarkMode),
      dialogTheme: ContentDialogThemeData(
        decoration: BoxDecoration(
          color: colorScheme.background,
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      navigationPaneTheme: NavigationPaneThemeData(
        backgroundColor: colorScheme.surface,
      ),
    );
  }

  static FluentThemeData darkTheme(AppTheme appTheme) =>
      getThemeDataFrom(appTheme);

  static FluentThemeData lightTheme(AppTheme appTheme) =>
      getThemeDataFrom(appTheme);

  static AccentColor _getAccentColor(material.ColorScheme colorScheme) {
    return AccentColor.swatch({
      "normal": colorScheme.primary,
    });
  }
}
