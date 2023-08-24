import 'package:dune/data/audio/isar/repositories/isar_music_repository.dart';
import 'package:dune/domain/audio/base_models/base_track_listening_history.dart';
import 'package:dune/domain/audio/seeders/track_listening_history_seeder.dart';

final class IsarTrackListeningHistorySeeder
    extends TrackListeningHistorySeeder {
  IsarTrackListeningHistorySeeder(
    IsarMusicRepository repository,
  ) : super(
          onSaveTrackHistory: (history) =>
              _onSaveTrackHistory(history, repository),
        );

  static Future<void> _onSaveTrackHistory(
    BaseTrackListeningHistory history,
    IsarMusicRepository repository,
  ) async {
    final track = history.track!;

    await repository.listeningHistory.incrementTrackCompletedListensCount(
      track,
      history.date!,
      count: history.completedListensCount!,
    );
    await repository.listeningHistory.addToTrackUncompletedListensDuration(
      track,
      history.date!,
      history.uncompletedListensTotalDuration!,
    );
  }
}
