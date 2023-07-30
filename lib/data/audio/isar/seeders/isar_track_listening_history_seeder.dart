import 'package:dune/data/audio/isar/models/isar_track_listening_history.dart';
import 'package:dune/data/audio/isar/repositories/isar_music_repository.dart';
import 'package:dune/domain/audio/base_models/base_track_listening_history.dart';
import 'package:dune/domain/audio/seeders/track_listening_history_seeder.dart';
import 'package:dune/support/extensions/extensions.dart';
import 'package:isar/isar.dart';

final class IsarTrackListeningHistorySeeder
    extends TrackListeningHistorySeeder {
  IsarTrackListeningHistorySeeder(
    IsarMusicRepository repository,
    Isar isar,
  ) : super(
          onSaveTrackHistory: (history, date) =>
              _onSaveTrackHistory(history, date, repository, isar),
        );

  static Future<void> _onSaveTrackHistory(
    BaseTrackListeningHistory history,
    DateTime date,
    IsarMusicRepository repository,
    Isar isar,
  ) async {
    final track = history.track!;
    final result1 = await repository.listeningHistory
        .incrementTrackCompletedListensCount(track, date);

    final isarTrackHistory = result1.requireValue.tracksListeningHistory
        .whereKey(date.onlyDate)
        ?.firstWhereOrNull((element) => element.track?.id == track.id);

    await isar.writeTxn(
      () async => await isar.isarTrackListeningHistorys.put(
        isarTrackHistory!.copyWith(
          completedListensCount: history.completedListensCount,
          uncompletedListensTotalDuration:
              history.uncompletedListensTotalDuration,
        ),
      ),
    );
  }
}
