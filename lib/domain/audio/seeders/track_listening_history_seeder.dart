import 'package:dune/domain/audio/base_models/base_track.dart';
import 'package:dune/domain/audio/base_models/base_track_listening_history.dart';
import 'package:dune/domain/audio/factories/track_listening_history_factory.dart';
import 'package:faker/faker.dart';

base class TrackListeningHistorySeeder {
  final Future<void> Function(
      BaseTrackListeningHistory trackHistory, DateTime date) onSaveTrackHistory;

  TrackListeningHistorySeeder({required this.onSaveTrackHistory});

  DateTime get _now => DateTime.now();

  DateTime get _randomDate => faker.date.dateTimeBetween(
      DateTime(_now.year, _now.month), DateTime(_now.year, _now.month, 32));

  Future<BaseTrackListeningHistory> seedOne([
    BaseTrack? track,
    DateTime? date,
  ]) async {
    final trackHistory =
        TrackListeningHistoryFactory().setTrack(track).create();
    await onSaveTrackHistory(trackHistory, date ?? _randomDate);
    return trackHistory;
  }

  Future<List<BaseTrackListeningHistory>> seedCount([
    DateTime? date,
    int? count,
  ]) async {
    final tracksHistories = TrackListeningHistoryFactory()
        .createCount(count ?? faker.randomGenerator.integer(30));

    for (var history in tracksHistories) {
      await onSaveTrackHistory(history, date ?? _randomDate);
    }
    return tracksHistories;
  }
}
