import 'package:dune/domain/audio/base_models/base_track.dart';
import 'package:dune/domain/audio/base_models/base_track_listening_history.dart';
import 'package:dune/domain/audio/factories/track_listening_history_factory.dart';
import 'package:dune/support/logger_service.dart';
import 'package:faker/faker.dart';

base class TrackListeningHistorySeeder {
  final Future<void> Function(BaseTrackListeningHistory trackHistory)
      onSaveTrackHistory;

  TrackListeningHistorySeeder({required this.onSaveTrackHistory});

  Future<BaseTrackListeningHistory> seedOne([
    BaseTrack? track,
    DateTime? date,
  ]) async {
    final trackHistory =
        TrackListeningHistoryFactory().setDate(date).setTrack(track).create();
    await onSaveTrackHistory(trackHistory);
    return trackHistory;
  }

  Future<List<BaseTrackListeningHistory>> seedCount([
    DateTime? date,
    int? count,
  ]) async {
    final tracksHistories = TrackListeningHistoryFactory()
        .setDate(date)
        .createCount(count ?? faker.randomGenerator.integer(100));
    for (int i = 0; i < tracksHistories.length; i++) {
      await onSaveTrackHistory(tracksHistories[i]);
      Log.d("Seeding TrackListeningHistories: [${i + 1}] Done.");
    }
    return tracksHistories;
  }
}
