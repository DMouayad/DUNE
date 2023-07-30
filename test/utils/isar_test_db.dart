import 'package:dune/data/audio/isar/repositories/isar_music_repository.dart';
import 'package:dune/data/audio/isar/seeders/isar_track_listening_history_seeder.dart';
import 'package:dune/support/helpers/isar_helper.dart';
import 'package:get_it/get_it.dart';
import 'package:isar/isar.dart';

late Isar isar;
late IsarMusicRepository isarMusicRepo;

Future<void> initIsarForTesting() async {
  final isarDBNotOpened = !GetIt.instance.isRegistered<Isar>();
  if (isarDBNotOpened) {
    isar = await IsarHelper.initForTesting();
    GetIt.instance.registerSingleton<Isar>(isar);
  } else {
    isar = GetIt.instance.get();
  }
  isarMusicRepo = IsarMusicRepository(isar: isar);
}

Future<void> refreshDatabase() async {
  isarMusicRepo = IsarMusicRepository(isar: isar);
  await isar.writeTxn(() async => await isar.clear());
}

IsarTrackListeningHistorySeeder get isarTrackListeningHistorySeeder {
  return IsarTrackListeningHistorySeeder(isarMusicRepo, isar);
}
