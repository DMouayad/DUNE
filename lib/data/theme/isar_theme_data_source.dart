import 'package:dune/data/theme/isar_app_theme.dart';
import 'package:dune/domain/theme/app_theme.dart';
import 'package:dune/domain/theme/base_theme_data_source.dart';
import 'package:dune/support/utils/result/result.dart';
import 'package:isar/isar.dart';

class IsarThemeDataSource extends BaseThemeDataSource {
  const IsarThemeDataSource(this._isar, super.fallbackAccentColor);

  final Isar _isar;

  @override
  FutureResult<AppTheme> getAppTheme() async {
    return await Result.fromAsync(() async {
      return await _isar.isarAppThemes.where().findFirst() ??
          IsarAppTheme.fromDefaultValues();
    });
  }

  @override
  FutureVoidResult saveAppTheme(AppTheme instance) async {
    return await Result.fromAnother(() async {
      await _isar.writeTxn(() async {
        await _isar.isarAppThemes.clear();
        await _isar.isarAppThemes.put(IsarAppTheme(
          themeMode: instance.themeMode,
          windowEffect: instance.windowEffect,
          primaryColor: instance.primaryColor,
        ));
      });
      return SuccessResult.voidResult();
    });
  }
}
