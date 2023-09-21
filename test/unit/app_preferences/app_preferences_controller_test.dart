import 'package:dune/data/app_preferences/isar/isar_app_preferences_data_source.dart';
import 'package:dune/domain/app_preferences/base_app_preferences.dart';
import 'package:dune/domain/app_preferences/base_app_preferences_data_source.dart';
import 'package:dune/presentation/controllers/app_preferences_controller.dart';
import 'package:dune/presentation/utils/music_folder_helper.dart';
import 'package:dune/support/enums/audio_streaming_quality.dart';
import 'package:dune/support/enums/music_source.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../utils/constants.dart';
import '../../utils/isar_testing_utils.dart';

void main() {
  late AppPreferencesController controller;
  late final BaseAppPreferencesDataSource dataSource;
  setUpAll(() async {
    await IsarTestingUtils.initIsarForTesting();
    dataSource = IsarAppPreferencesDataSource(IsarTestingUtils.isar);
  });
  setUp(() {
    controller =
        AppPreferencesController(dataSource, const BaseAppPreferences());
  });
  group('updating [BaseAppPreferences.TabsMode]', () {
    //TODO: find out why this test is failing thought it's working in the app
    // test(
    //   "switching from vertical to horizontal [TabsMode] updates the state's [tabsMode]",
    //   () async {
    //     const modes =
    //         (initialMode: TabsMode.vertical, newMode: TabsMode.horizontal);
    //     // act
    //     await controller.setTabMode(modes.newMode);
    //     expectLater(controller.state.tabsMode, modes.newMode);
    //   },
    // );

    test("[setTabMode] SHOULD NOT update the state's [tabsMode]", () async {
      const newTabsMode = TabsMode.disabled;
      expect(controller.state.tabsMode != newTabsMode, true);
      // act
      await controller.setTabMode(newTabsMode);
      // Until now, enabling\disabling tabs mode will only take effect
      // on the next app-start. so it shouldn't update the state.
      expect(controller.state.tabsMode != newTabsMode, true);
    });
  });

  group(
    'add/remove library music folders',
    () {
      test(
          "it adds a new [MusicFolder] instance to the state's [localMusicFolders]",
          () async {
        final newFolder = MusicFolderHelper.createInstance(
            kPathToMusicFolderWithoutSubFolders, {});
        await controller.addMusicFolder(newFolder!);
        expect(controller.state.localMusicFolders.single, newFolder);
      });
      test('it adds sub-folders of specified music folder', () async {
        final newFolder = MusicFolderHelper.createInstance(
            kPathToMusicFolderWithSubFolders, {});
        await controller.addMusicFolder(newFolder!);

        expect(
            controller.state.localMusicFolders.single.subFolders, isNotEmpty);
      });
    },
  );

  test("[setExploreMusicSource] updates the state's [exploreMusicSource]",
      () async {
    const newSource = MusicSource.spotify;
    expect(controller.state.exploreMusicSource != newSource, true);
    // act
    await controller.setExploreMusicSource(newSource);

    expect(controller.state.exploreMusicSource, newSource);
  });
  test("[setSearchEngine] updates the state's [searchEngine]", () async {
    const newSource = MusicSource.spotify;
    expect(controller.state.searchEngine != newSource, true);
    // act
    await controller.setSearchEngine(newSource);

    expect(controller.state.searchEngine, newSource);
  });
  test(
      "[setThumbnailQualitiesOrderOption] updates the state's [thumbnailQualitiesOrder]",
      () async {
    const newSource = ThumbnailQualitiesOrderOption.lowest;
    expect(controller.state.thumbnailQualitiesOrder != newSource, true);
    // act
    await controller.setThumbnailQualitiesOrderOption(newSource);
    expect(controller.state.thumbnailQualitiesOrder, newSource);
  });
  test(
      "[setAudioStreamingQualityOption] updates the state's [audioStreamingQuality]",
      () async {
    const newSource = AudioStreamingQuality.lowest;
    expect(controller.state.audioStreamingQuality != newSource, true);
    // act
    await controller.setAudioStreamingQualityOption(newSource);
    expect(controller.state.audioStreamingQuality, newSource);
  });
}
