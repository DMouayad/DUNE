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

  /// Whether to notify listeners or not when [state] changes
  @override
  bool updateShouldNotify(
    BaseAppPreferences old,
    BaseAppPreferences current,
  ) {
    // if [lastSidePanelWidth] or [lastWindowSize] was changed, dont notify
    // listeners because it appears to introduce a bug causing the
    // [playbackControllerProvider] to be disposed of. Anyway, the change in these
    // properties is not important to any listener for this provider's state.
    if (old.lastSidePanelWidth != current.lastSidePanelWidth) {
      return false;
    }
    if (old.lastWindowSize != current.lastWindowSize) {
      return false;
    }
    return old != current;
  }

  Future<void> _handleUpdatingAppPreferences(
    BaseAppPreferences newPreferences,
  ) async {
    if (newPreferences != state) {
      (await _dataSource.save(newPreferences))
          .fold(ifSuccess: (prefs) => state = prefs);
    }
  }

  Future<void> setTabModeIsEnabled(bool value) async {
    _handleUpdatingAppPreferences(state.copyWith(tabsModeEnabled: value));
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
    _handleUpdatingAppPreferences(
        state.copyWith(thumbnailQualitiesOrder: option));
  }

  Future<void> setLastWindowSize(Size size) async {
    _handleUpdatingAppPreferences(state.copyWith(lastWindowSize: size));
  }

  Future<void> setLastSidePanelWidth(double? width) async {
    _handleUpdatingAppPreferences(state.copyWith(lastSidePanelWidth: width));
  }

  Future<void> setSearchEngine(MusicSource source) async {
    _handleUpdatingAppPreferences(state.copyWith(searchEngine: source));
  }

  Future<void> setExploreMusicSource(MusicSource source) async {
    (await _dataSource.save(state.copyWith(exploreMusicSource: source)))
        .fold(ifSuccess: (prefs) => state = prefs);
  }

  Future<void> setInitialPageOnStartup(InitialPageOnStartup page) async {
    (await _dataSource.save(state.copyWith(initialPageOnStartup: page)))
        .fold(ifSuccess: (prefs) => state = prefs);
  }

  Future<void> setAudioStreamingQualityOption(
    AudioStreamingQuality quality,
  ) async {
    _handleUpdatingAppPreferences(
        state.copyWith(audioStreamingQuality: quality));
  }
}
