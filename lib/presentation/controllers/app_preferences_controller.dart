import 'dart:ui';

import 'package:dune/domain/app_preferences/base_app_preferences.dart';
import 'package:dune/domain/app_preferences/base_app_preferences_data_source.dart';
import 'package:dune/support/enums/audio_streaming_quality.dart';
import 'package:dune/support/enums/initial_page_on_startup.dart';
import 'package:dune/support/enums/music_source.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppPreferencesController extends StateNotifier<BaseAppPreferences> {
  AppPreferencesController(this._dataSource, super.state);

  final BaseAppPreferencesDataSource _dataSource;

  @override
  bool updateShouldNotify(BaseAppPreferences old, BaseAppPreferences current) {
    if (old.tabsMode.isEnabled != current.tabsMode.isEnabled) return false;
    return super.updateShouldNotify(old, current);
  }

  Future<void> _handleUpdatingAppPreferences(
    BaseAppPreferences newPreferences,
  ) async {
    if (newPreferences != state) {
      (await _dataSource.save(newPreferences)).fold(onSuccess: (prefs) {
        print(prefs.autoHideWideScreenAppBarButtons);
        state = prefs;
      });
    }
  }

  Future<void> setTabMode(TabsMode tabsMode) async {
    _handleUpdatingAppPreferences(state.copyWith(tabsMode: tabsMode));
  }

  Future<void> setShouldRememberLastWindowSize(bool value) async {
    _handleUpdatingAppPreferences(
        state.copyWith(rememberLastWindowSize: value));
  }

  Future<void> toggleSidePanelPinMode() async {
    _handleUpdatingAppPreferences(
        state.copyWith(sidePanelPinned: !state.sidePanelPinned));
  }

  Future<void> setThumbnailQualitiesOrderOption(
    ThumbnailQualitiesOrderOption option,
  ) async {
    await _handleUpdatingAppPreferences(
        state.copyWith(thumbnailQualitiesOrder: option));
  }

  Future<void> setLastWindowSize(Size size) async {
    await _handleUpdatingAppPreferences(state.copyWith(lastWindowSize: size));
  }

  Future<void> setSearchEngine(MusicSource source) async {
    await _handleUpdatingAppPreferences(state.copyWith(searchEngine: source));
  }

  Future<void> setExploreMusicSource(MusicSource source) async {
    (await _dataSource.save(state.copyWith(exploreMusicSource: source)))
        .fold(onSuccess: (prefs) => state = prefs);
  }

  Future<void> setInitialPageOnStartup(InitialPageOnStartup page) async {
    await _handleUpdatingAppPreferences(
        state.copyWith(initialPageOnStartup: page));
  }

  Future<void> setAudioStreamingQualityOption(
    AudioStreamingQuality quality,
  ) async {
    await _handleUpdatingAppPreferences(
        state.copyWith(audioStreamingQuality: quality));
  }

  Future<void> addMusicFolder(MusicFolder folder) async {
    final newMusicFoldersFolders =
        Set<MusicFolder>.from(state.localMusicFolders);
    newMusicFoldersFolders.add(folder);
    await _handleUpdatingAppPreferences(
        state.copyWith(localMusicFolders: newMusicFoldersFolders));
  }

  Future<void> removeMusicFolder(MusicFolder folder) async {
    final newFolders = Set<MusicFolder>.from(state.localMusicFolders);
    newFolders.remove(folder);
    await _handleUpdatingAppPreferences(
        state.copyWith(localMusicFolders: newFolders));
  }

  Future<void> removeSubMusicFolder({
    required MusicFolder parentMusicFolder,
    required String subFolderPath,
  }) async {
    final newFolders = Set<MusicFolder>.from(state.localMusicFolders);
    // fist remove the old parent folder
    newFolders.remove(parentMusicFolder);

    final folderWithSubRemoved =
        _removeSubFolder(parentMusicFolder, subFolderPath);
    // add the new parent folder
    newFolders.add(folderWithSubRemoved);

    await _handleUpdatingAppPreferences(
      state.copyWith(localMusicFolders: newFolders),
    );
  }

  MusicFolder _removeSubFolder(MusicFolder parentFolder, String path) {
    final newSubFolders = Set<String>.from(parentFolder.subFolders);
    newSubFolders.remove(path);
    return MusicFolder(path: parentFolder.path, subFolders: newSubFolders);
  }

  Future<void> setAutoHideAppBarButtons(bool autoHide) async {
    await _handleUpdatingAppPreferences(
      state.copyWith(autoHideWideScreenAppBarButtons: autoHide),
    );
  }
}
