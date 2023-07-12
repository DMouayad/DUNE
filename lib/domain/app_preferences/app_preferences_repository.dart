import 'package:dune/domain/app_preferences/base_app_preferences_data_source.dart';

final class AppPreferencesRepository {
  final BaseAppPreferencesDataSource _localDataSource;

  AppPreferencesRepository(this._localDataSource);
}
