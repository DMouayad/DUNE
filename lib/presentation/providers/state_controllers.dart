import 'package:dune/domain/app_preferences/base_app_preferences.dart';
import 'package:dune/domain/audio/base_models/base_play_history.dart';
import 'package:dune/domain/audio/base_models/base_playlist.dart';
import 'package:dune/domain/audio/base_models/base_track.dart';
import 'package:dune/domain/theme/app_theme.dart';
import 'package:dune/presentation/controllers/app_preferences_controller.dart';
import 'package:dune/presentation/controllers/app_theme_controller.dart';
import 'package:dune/presentation/controllers/playback_controller.dart';
import 'package:dune/presentation/controllers/explore_music_categories_controller.dart';
import 'package:dune/presentation/controllers/explore_music_controller.dart';
import 'package:dune/presentation/controllers/search_controller.dart';
import 'package:dune/presentation/controllers/listening_history_controller.dart';
import 'package:dune/presentation/controllers/playlist_controller.dart';
import 'package:dune/presentation/controllers/selection_controller.dart';
import 'package:dune/presentation/models/player_state.dart';
import 'package:dune/presentation/models/search_state.dart';
import 'package:dune/presentation/models/selection_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Manage and provide the state of an [AppTheme] data.
late final StateNotifierProvider<AppThemeController, AppTheme>
    appThemeControllerProvider;

late final StateNotifierProvider<PlaybackController, PlayerState>
    playbackControllerProvider;

late final StateNotifierProvider<PlaylistController, AsyncValue<BasePlaylist?>>
    playlistControllerProvider;
late final StateNotifierProvider<ExploreMusicCategoriesController,
        ExploreMusicCategoriesControllerState>
    exploreMusicCategoriesControllerProvider;

late final StateNotifierProvider<ExploreMusicController,
    AsyncValue<ExploreMusicState>> exploreMusicControllerProvider;

late final StateNotifierProvider<ListeningHistoryController,
    AsyncValue<List<BaseListeningHistory>>> listeningHistoryControllerProvider;

late final StateNotifierProvider<SearchController, AsyncValue<SearchState>>
    searchControllerProvider;
late final StateNotifierProvider<AppPreferencesController, BaseAppPreferences>
    appPreferencesController;

final StateNotifierProvider<SelectionController<BaseTrack>,
        SelectionState<BaseTrack>> tracksSelectionControllerProvider =
    StateNotifierProvider(
  (ref) => SelectionController(SelectionState(false, {})),
);
