import 'package:dune/domain/theme/app_theme.dart';
import 'package:dune/support/utils/result/result.dart';

abstract class BaseThemeDataSource<T extends AppTheme> {
  final MaterialColor fallbackPrimaryColor;

  const BaseThemeDataSource(this.fallbackPrimaryColor);

  FutureResult<T> getAppTheme();

  FutureVoidResult saveAppTheme(AppTheme instance);
}
