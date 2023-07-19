import 'dart:async';

import 'package:dune/domain/theme/theme_repository.dart';
import 'package:dune/domain/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_acrylic/flutter_acrylic.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppThemeController extends StateNotifier<AppTheme> {
  AppThemeController(this.themeRepository)
      : super(themeRepository.currentTheme);
  final ThemeRepository themeRepository;

  Future<FutureOr<void>> setThemeMode(ThemeMode themeMode) async {
    await _getNewState(state.copyWith(themeMode: themeMode));
  }

  Future<FutureOr<void>> setAccentColor(MaterialColor primaryColor) async {
    await _getNewState(state.copyWith(primaryColor: primaryColor));
  }

  Future<FutureOr<void>> setWindowEffect(WindowEffect windowEffect) async {
    await _getNewState(state.copyWith(windowEffect: windowEffect));
  }

  Future<void> _getNewState(AppTheme newAppTheme) async {
    state = await () async {
      await themeRepository.updateAppTheme(newAppTheme);
      return newAppTheme;
    }();
  }
}
