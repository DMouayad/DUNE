import 'dart:io';

import 'package:dune/data/audio/isar/repositories/isar_music_repository.dart';
import 'package:dune/data/audio/local/services/taggy_track_from_file_extractor.dart';
import 'package:dune/data/audio/youtube/repositories/youtube_music_repository.dart';
import 'package:dune/domain/app_preferences/base_app_preferences.dart';
import 'package:dune/domain/audio/facades/music_facade.dart';
import 'package:dune/domain/audio/services/audio_library_scanner.dart';
import 'package:dune/navigation/navigation.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

void registerNavigationService(BaseAppPreferences appPreferences) {
  final tabsEnabled = appPreferences.tabsMode.isEnabled;
  // will have one tab at the initial app startup
  final startupDestination = appPreferences.initialStartupDestination;

  TabsState? initialTabsState;
  if (tabsEnabled) {
    initialTabsState =
        AppNavigationUtils.getInitialTabsState(startupDestination);
  }
  // initialize the [AppNavigation] service
  AppNavigation.registerInstance(
    appPreferences.initialStartupDestination,
    initialTabsState,
  );
}

Future<void> registerMusicFacades(Isar isar, [Directory? appDir]) async {
  final isarMusicRepository = IsarMusicRepository(isar: isar);
  final appDocumentsDir = appDir ?? await getApplicationDocumentsDirectory();

  MusicFacade.setInstance(
    localMusicRepository: isarMusicRepository,
    listeningHistoryRepository: isarMusicRepository.listeningHistory,
    youtubeMusicRepository: YoutubeMusicRepository(),
    audioLibraryScanner: AudioLibraryScanner(
      trackExtractor: TaggyTrackFromFileExtractor(),
      directoryToSaveExtractedImages: appDocumentsDir.path,
    ),
  );
}
