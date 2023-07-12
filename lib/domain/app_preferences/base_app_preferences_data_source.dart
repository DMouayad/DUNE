import 'package:dune/support/utils/result/result.dart';

import 'base_app_preferences.dart';

abstract class BaseAppPreferencesDataSource<T extends BaseAppPreferences> {
  FutureOrResult<T> loadPreferences();

  FutureOrResult<T> save(T preferences);
}
