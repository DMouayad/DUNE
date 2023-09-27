import 'package:dune/data/app_preferences/isar/isar_app_preferences_data_source.dart';
import 'package:dune/domain/app_preferences/app_preferences_factory.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../utils/isar_testing_utils.dart';

void main() {
  late final IsarAppPreferencesDataSource dataSource;
  setUpAll(() async {
    await IsarTestingUtils.initIsarForTesting();
    dataSource = IsarAppPreferencesDataSource(IsarTestingUtils.isar);
  });
  setUp(() async => await IsarTestingUtils.refreshDatabase());

  test('it successfully stores a [BaseAppPreferences]', () async {
    final prefs = AppPreferencesFactory().create();
    final result = await dataSource.save(prefs);
    expect(result.isSuccess, true);
  });
  test('it returns an identical [BaseAppPreferences] instance after saving',
      () async {
    final prefs = AppPreferencesFactory().create();
    final result = await dataSource.save(prefs);
    expect(result.requireValue, prefs);
  });
  test('it saves all [BaseAppPreferences] properties', () async {
    final prefsToSave = AppPreferencesFactory().create();
    final result = await dataSource.save(prefsToSave);
    expect(result.isSuccess, true);
    // read after saving it
    final prefsFromStorage = (await dataSource.loadPreferences()).requireValue;
    expect(prefsFromStorage, prefsToSave);
  });
}
