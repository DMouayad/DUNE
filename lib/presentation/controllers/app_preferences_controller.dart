import 'dart:io';
import 'dart:ui';

import 'package:dune/domain/app_preferences/base_app_preferences.dart';
import 'package:dune/domain/app_preferences/base_app_preferences_data_source.dart';
import 'package:dune/support/enums/audio_streaming_quality.dart';
import 'package:dune/support/enums/initial_page_on_startup.dart';
import 'package:dune/support/enums/music_source.dart';
import 'package:dune/support/extensions/extensions.dart';
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
      (await _dataSource.save(newPreferences))
          .fold(onSuccess: (prefs) => state = prefs);
    }
  }

  Future<void> setTabMode(TabsMode tabsMode) async {
    _handleUpdatingAppPreferences(state.copyWith(tabsMode: tabsMode));
  }

  Future<void> setShouldRememberLastWindowSize(bool value) async {
    _handleUpdatingAppPreferences(
        state.copyWith(rememberLastWindowSize: value));
  }

  Future<void> setShouldRememberLastSidePanelSize(bool value) async {
    _handleUpdatingAppPreferences(
        state.copyWith(rememberLastSidePanelSize: value));
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

  Future<void> setLastSidePanelWidth(double? width) async {
    await _handleUpdatingAppPreferences(
        state.copyWith(lastSidePanelWidth: width));
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

  Future<void> addMusicFolder(String path) async {
    final newMusicFoldersFolders =
        Set<MusicFolder>.from(state.localMusicFolders);

    /// paths of all sub folders
    final subFolders = Directory(path)
        .listSync(recursive: true)
        .whereType<Directory>()
        .toList()
        .map((e) => e.absolute.path)
        .toSet();
    final musicFolder = MusicFolder(path: path, subFolders: subFolders);

    newMusicFoldersFolders.add(musicFolder);
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
    final newSubFolders = Set<String>.from(parentMusicFolder.subFolders);
    newSubFolders.remove(subFolderPath);
    final newParentMF = MusicFolder(
      path: parentMusicFolder.path,
      subFolders: newSubFolders,
    );
    final newFolders = Set<MusicFolder>.from(state.localMusicFolders);
    newFolders.remove(parentMusicFolder);
    newFolders.add(newParentMF);
    await _handleUpdatingAppPreferences(
      state.copyWith(localMusicFolders: newFolders),
    );
  }

  bool musicFolderAlreadyExists(String path) {
    final existsAsParentMF =
        state.localMusicFolders.containsWhere((e) => e.path == path);
    if (!existsAsParentMF) {
      return state.localMusicFolders
          .containsWhere((e) => e.subFolders.contains(path));
    }
    return existsAsParentMF;
  }
}
