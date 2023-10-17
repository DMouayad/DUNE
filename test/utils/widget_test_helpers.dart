import 'dart:io';

import 'package:dune/data/app_preferences/isar/isar_app_preferences.dart';
import 'package:dune/domain/app_preferences/base_app_preferences.dart';
import 'package:dune/support/helpers/dependencies_helper.dart';
import 'package:dune/support/helpers/provider_helpers.dart';
import 'package:flutter_taggy/flutter_taggy.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:media_kit/media_kit.dart';

import 'isar_testing_utils.dart';

Future<void> registerDependenciesForWidgetTest([
  BaseAppPreferences? initialAppPrefs,
]) async {
  TestWidgetsFlutterBinding.ensureInitialized();
  MediaKit.ensureInitialized();
  Taggy.initialize();
  await IsarTestingUtils.initIsarForTesting();

  await registerThemeProvider(IsarTestingUtils.isar);

  if (initialAppPrefs != null) {
    // this is necessary before loading stored instance in the [registerAppPreferencesControllerProvider] method
    await updatePreferencesInIsarDB(initialAppPrefs);
  }
  await registerAppPreferencesControllerProvider(IsarTestingUtils.isar);

  await registerMusicFacades(IsarTestingUtils.isar, Directory.systemTemp);

  registerControllersProviders();
}

Future<void> updatePreferencesInIsarDB(
    BaseAppPreferences appPreferences) async {
  await IsarTestingUtils.isar.writeTxn(() async {
    await IsarTestingUtils.isar.isarAppPreferences.clear();
    await IsarTestingUtils.isar.isarAppPreferences
        .put(IsarAppPreferences.fromBase(appPreferences));
  });
}
