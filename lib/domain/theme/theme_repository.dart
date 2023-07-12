import 'dart:async';

import 'base_theme_data_source.dart';
import 'package:dune/domain/theme/app_theme.dart';

class ThemeRepository {
  final BaseThemeDataSource _dataSource;

  ThemeRepository(this._dataSource);

  late AppTheme _currentTheme;

  AppTheme get currentTheme => _currentTheme;

  FutureOr<void> loadAppTheme() async {
    (await _dataSource.getAppTheme()).fold(
      ifSuccess: (value) {
        _currentTheme = value;
      },
    );
  }

  FutureOr<void> updateAppTheme(AppTheme newAppTheme) async {
    (await _dataSource.saveAppTheme(newAppTheme)).fold(ifSuccess: (_) {
      _currentTheme = newAppTheme;
    });
  }
}
