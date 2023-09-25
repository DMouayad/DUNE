import 'package:dune/domain/app_preferences/base_app_preferences.dart';
import 'package:dune/domain/audio/base_models/base_playlist.dart';
import 'package:dune/domain/audio/base_models/listening_history_collection.dart';
import 'package:dune/domain/theme/app_theme.dart';
import 'package:dune/presentation/controllers/app_preferences_controller.dart';
import 'package:dune/presentation/controllers/app_theme_controller.dart';
import 'package:dune/presentation/controllers/local_library_controller.dart';
import 'package:dune/presentation/controllers/playback_controller.dart';
import 'package:dune/presentation/controllers/explore_music_categories_controller.dart';
import 'package:dune/presentation/controllers/explore_music_controller.dart';
import 'package:dune/presentation/controllers/search_controller.dart';
import 'package:dune/presentation/controllers/listening_history_controller.dart';
import 'package:dune/presentation/controllers/playlist_controller.dart';
import 'package:dune/domain/audio/services/audio_player.dart';
import 'package:dune/presentation/models/search_state.dart';
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
    AsyncValue<ListeningHistoryCollection>> listeningHistoryControllerProvider;

late final StateNotifierProvider<SearchController, AsyncValue<SearchState>>
    searchControllerProvider;
late final StateNotifierProvider<AppPreferencesController, BaseAppPreferences>
    appPreferencesController;
late final StateNotifierProvider<LocalLibraryController, LocalLibraryState>
    localLibraryControllerProvider;
