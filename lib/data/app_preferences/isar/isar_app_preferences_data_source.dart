import 'package:dune/domain/app_preferences/base_app_preferences.dart';
import 'package:dune/domain/app_preferences/base_app_preferences_data_source.dart';
import 'package:dune/support/utils/result/result.dart';
import 'package:isar/isar.dart';

import 'isar_app_preferences.dart';
import 'isar_music_folder.dart';

class IsarAppPreferencesDataSource extends BaseAppPreferencesDataSource {
  final Isar _isar;

  IsarAppPreferencesDataSource(this._isar);

  @override
  FutureOrResult<IsarAppPreferences> loadPreferences() async {
    return await Result.fromAsync(() async {
      IsarAppPreferences? savedPrefs =
          await _isar.isarAppPreferences.where().anyId().findFirst();
      if (savedPrefs == null) {
        savedPrefs = IsarAppPreferences();
        _isar.writeTxn(() => _isar.isarAppPreferences.put(savedPrefs!));
      }
      return savedPrefs;
    });
  }

  @override
  FutureOrResult<IsarAppPreferences> save(
      BaseAppPreferences preferences) async {
    return await Result.fromAsync(() async {
      IsarAppPreferences model = _isarFromBase(preferences);
      return await _isar.writeTxn(() async {
        await _isar.isarAppPreferences.clear();
        await _isar.isarAppPreferences.put(model);
        return model;
      });
    });
  }

  IsarAppPreferences _isarFromBase(BaseAppPreferences base) {
    return IsarAppPreferences(
      exploreMusicSource: base.exploreMusicSource,
      sidePanelPinned: base.sidePanelPinned,
      rememberLastWindowSize: base.rememberLastWindowSize,
      usePrimaryColorInCardColor: base.usePrimaryColorInCardColor,
      initialPageOnStartup: base.initialPageOnStartup,
      autoHideWideScreenAppBarButtons: base.autoHideWideScreenAppBarButtons,
      volumeStep: base.volumeStep,
      tabsMode: base.tabsMode,
      thumbnailQualitiesOrder: base.thumbnailQualitiesOrder,
      lastWindowHeight: base.lastWindowSize?.height,
      lastWindowWidth: base.lastWindowSize?.width,
      audioStreamingQuality: base.audioStreamingQuality,
      searchEngine: base.searchEngine,
      localMusicFoldersList: base.localMusicFolders
          .map((e) => IsarMusicFolder.fromBase(e))
          .toList(),
    );
  }
}
