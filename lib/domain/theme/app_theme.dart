import 'package:dune/support/themes/theme_constants.dart';
import 'package:dune/support/themes/material_themes.dart';
import 'package:equatable/equatable.dart';
import 'package:fluent_ui/fluent_ui.dart' as fluent_ui;
import 'package:flutter/material.dart';
import 'package:flutter_acrylic/flutter_acrylic.dart';
export 'package:flutter/material.dart' show MaterialColor;

class AppTheme extends Equatable {
  /// Represents the window effect style, such as acrylic or solid.
  final WindowEffect windowEffect;

  /// Represents the entire app theme mode, either light, dark, or system default.
  final ThemeMode themeMode;

  /// Represents the primary color of the theme
  final MaterialColor primaryColor;

  late final ColorScheme _colorScheme;
  late final ThemeData _materialThemeData;

  bool get isDarkMode => themeMode == fluent_ui.ThemeMode.dark;

  Color get surfaceColor =>
      primaryColor.shade300.withOpacity(isDarkMode ? .2 : .1);

  bool get acrylicWindowEffectEnabled => windowEffect == WindowEffect.acrylic;

  ThemeData get materialThemeData {
    return _materialThemeData;
  }

  ColorScheme get colorScheme => _colorScheme;

  Color get cardColor {
    return acrylicWindowEffectEnabled
        ? _colorScheme.background.withOpacity(.4)
        : _colorScheme.surfaceVariant.withOpacity(.2);
  }

  factory AppTheme.fromDefaultValues() {
    return AppTheme(
      themeMode: ThemeMode.system,
      primaryColor: kDefaultPrimaryColor,
      windowEffect: WindowEffect.solid,
    );
  }

  AppTheme({
    required this.themeMode,
    required this.primaryColor,
    this.windowEffect = WindowEffect.solid,
  }) {
    _materialThemeData = MaterialThemes.themeDataFromAppTheme(this);
    _colorScheme = _materialThemeData.colorScheme;
  }

  AppTheme copyWith({
    ThemeMode? themeMode,
    MaterialColor? primaryColor,
    WindowEffect? windowEffect,
  }) {
    return AppTheme(
      themeMode: themeMode ?? this.themeMode,
      primaryColor: primaryColor ?? this.primaryColor,
      windowEffect: windowEffect ?? this.windowEffect,
    );
  }

  @override
  List<Object?> get props => [themeMode, primaryColor, windowEffect];
}
