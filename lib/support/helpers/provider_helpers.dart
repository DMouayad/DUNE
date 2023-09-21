import 'package:dune/presentation/controllers/local_library_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:isar/isar.dart';
import 'package:system_theme/system_theme.dart';
import 'package:media_kit/media_kit.dart' as mediaKit;

//
import 'package:dune/data/app_preferences/isar/isar_app_preferences.dart';
import 'package:dune/data/app_preferences/isar/isar_app_preferences_data_source.dart';
import 'package:dune/data/theme/isar_theme_data_source.dart';
import 'package:dune/domain/app_preferences/base_app_preferences.dart';
import 'package:dune/domain/theme/theme_repository.dart';
import 'package:dune/domain/theme/app_theme.dart';
import 'package:dune/presentation/controllers/app_preferences_controller.dart';
import 'package:dune/presentation/controllers/app_theme_controller.dart';
import 'package:dune/presentation/controllers/explore_music_categories_controller.dart';
import 'package:dune/presentation/controllers/search_controller.dart';
import 'package:dune/presentation/controllers/listening_history_controller.dart';
import 'package:dune/presentation/models/audio_player.dart';
import 'package:dune/presentation/models/media_kit_audio_player.dart';
import 'package:dune/presentation/providers/state_controllers.dart';
import 'package:dune/presentation/controllers/playback_controller.dart';
import 'package:dune/presentation/controllers/explore_music_controller.dart';
import 'package:dune/presentation/controllers/playlist_controller.dart';
import 'package:dune/presentation/utils/listening_history_helper.dart';

AudioPlayer registerAudioPlayer(Ref ref) {
  final listeningHistoryHelper = ListeningHistoryHelper(
    ref
        .read(listeningHistoryControllerProvider.notifier)
        .incrementTodayTrackCompletedListensCount,
    ref
        .read(listeningHistoryControllerProvider.notifier)
        .addPlaylistToTodayListeningHistory,
    ref
        .read(listeningHistoryControllerProvider.notifier)
        .addToTodayTrackUncompletedListensDuration,
  );
  final notAlreadyRegistered = !GetIt.instance.isRegistered<AudioPlayer>();
  if (notAlreadyRegistered) {
    GetIt.instance.registerSingleton<AudioPlayer>(
      MediaKitAudioPlayer(
        mediaKit.Player(
          configuration: const mediaKit.PlayerConfiguration(
            vo: null,
            title: 'DUNE',
            logLevel: mediaKit.MPVLogLevel.debug,
          ),
        ),
        listeningHistoryHelper,
        () => ref.watch(
            appPreferencesController.select((value) => value.volumeStep)),
      ),
    );
  }
  return GetIt.instance.get<AudioPlayer>();
}

void registerControllersProviders() {
  final libraryController = LocalLibraryController()..loadLibraryFromStorage();
  localLibraryControllerProvider =
      StateNotifierProvider((ref) => libraryController);
  playbackControllerProvider = StateNotifierProvider((ref) {
    return PlaybackController(registerAudioPlayer(ref));
  });

  searchControllerProvider = StateNotifierProvider((ref) => SearchController());

  exploreMusicControllerProvider = StateNotifierProvider(
    (ref) {
      final musicSource = ref.read(appPreferencesController).exploreMusicSource;
      return ExploreMusicController()..fetchAll(musicSource);
    },
  );

  playlistControllerProvider =
      StateNotifierProvider((ref) => PlaylistController());
  exploreMusicCategoriesControllerProvider =
      StateNotifierProvider((ref) => ExploreMusicCategoriesController());

  listeningHistoryControllerProvider = StateNotifierProvider(
    (ref) => ListeningHistoryController(),
  );
}

Future<AppTheme> registerThemeProvider(Isar isar) async {
  // load the current accent color of the system
  await SystemTheme.accentColor.load();
  final repo = ThemeRepository(
      IsarThemeDataSource(isar, SystemTheme.accentColor.toMaterialColor));
  await repo.loadAppTheme();

  appThemeControllerProvider =
      StateNotifierProvider<AppThemeController, AppTheme>((ref) {
    return AppThemeController(repo);
  });
  return repo.currentTheme;
}

Future<BaseAppPreferences> registerAppPreferencesControllerProvider(
  Isar isar,
) async {
  final dataSource = IsarAppPreferencesDataSource(isar);
  final prefs = (await dataSource.loadPreferences()).mapTo(
    onSuccess: (value) => value,
    onFailure: (_) => IsarAppPreferences(),
  );

  appPreferencesController = StateNotifierProvider(
    (ref) => AppPreferencesController(dataSource, prefs),
  );
  return prefs;
}

extension SystemAccentColorExtension on SystemAccentColor {
  MaterialColor get toMaterialColor {
    return MaterialColor(accent.value, {
      100: lightest,
      300: lighter,
      400: light,
      500: accent,
      600: dark,
      700: darker,
      800: darkest,
    });
  }
}
