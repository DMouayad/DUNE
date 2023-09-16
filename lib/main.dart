import 'package:dune/support/helpers/isar_helper.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:media_kit/media_kit.dart';

//
import 'package:dune/dune_app.dart';
import 'package:dune/support/helpers/app_window_helper.dart';
import 'package:dune/support/helpers/platform_helpers.dart';
import 'package:dune/data/audio/local/services/taggy_track_from_file_extractor.dart';
import 'package:path_provider/path_provider.dart';
import 'data/audio/isar/repositories/isar_music_repository.dart';
import 'data/audio/youtube/repositories/youtube_music_repository.dart';
import 'domain/audio/facades/music_facade.dart';
import 'domain/audio/services/audio_library_scanner.dart';
import 'support/helpers/provider_helpers.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MediaKit.ensureInitialized();
  await _registerDependencies();

  runApp(const ProviderScope(child: DuneApp()));
}

Future<void> _registerDependencies() async {
  final isar = await IsarHelper.init();
  // await isar.writeTxn(() async => await isar.clear());
  final isarMusicRepository = IsarMusicRepository(isar: isar);
  // IsarTrackListeningHistorySeeder(isarMusicRepository, isar).seedCount();
  final appDocumentsDir = await getApplicationDocumentsDirectory();
  MusicFacade.setInstance(
    localMusicRepository: isarMusicRepository,
    listeningHistoryRepository: isarMusicRepository.listeningHistory,
    youtubeMusicRepository: YoutubeMusicRepository(),
    audioLibraryScanner: AudioLibraryScanner(
      trackExtractor: TaggyTrackFromFileExtractor(),
      directoryToSaveExtractedImages: appDocumentsDir.path,
    ),
  );

  final currentTheme = await registerThemeProvider(isar);

  final appPreferences = await registerAppPreferencesControllerProvider(isar);
  // if it's a desktop platform(Windows-Mac-Linux),
  // configure the app window style.
  if (isDesktopNotWebPlatform) {
    await AppWindowHelper.initConfigurations(appPreferences);

    await AppWindowHelper.setWindowEffect(currentTheme);
  }
  // initialize global [Provider]s variables
  registerControllersProviders();
}
