import 'dart:async';

import 'package:dune/domain/app_preferences/base_app_preferences.dart';
import 'package:dune/domain/theme/app_theme.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_acrylic/flutter_acrylic.dart' as acrylic;
import 'package:window_manager/window_manager.dart';

class AppWindowHelper {
  static Future<void> initConfigurations(
    BaseAppPreferences appPreferences,
  ) async {
    await acrylic.Window.initialize();

    await windowManager.ensureInitialized();
    final initialSize = appPreferences.rememberLastWindowSize &&
            appPreferences.lastWindowSize != null
        ? appPreferences.lastWindowSize
        : const Size(1100, 750);

    WindowOptions windowOptions = WindowOptions(
      size: initialSize,
      minimumSize: const Size(500, 600),
      center: true,
      skipTaskbar: false,
      windowButtonVisibility: false,
      titleBarStyle: TitleBarStyle.hidden,
    );
    unawaited(windowManager.waitUntilReadyToShow(windowOptions, () async {
      await windowManager.setAsFrameless();
      await windowManager.show();
      await windowManager.focus();
    }));
  }

  /// Changes the window background effect to the provided one.
  static Future<void> setWindowEffect(AppTheme appTheme) async {
    await acrylic.Window.setEffect(
      effect: appTheme.windowEffect,
      dark: appTheme.isDarkMode,
      color: () {
        if (appTheme.windowEffect == acrylic.WindowEffect.solid) {
          return appTheme.colorScheme.background;
        }
        if (appTheme.windowEffect == acrylic.WindowEffect.acrylic) {
          final darkModeColor =
              appTheme.colorScheme.surfaceVariant.withOpacity(.09);
          return appTheme.isDarkMode
              ? darkModeColor
              : appTheme.colorScheme.surfaceVariant.withOpacity(.75);
        }
        return Colors.transparent;
      }(),
    );
  }
}
