import 'package:dune/data/audio/isar/models/isar_track.dart';
import 'package:dune/domain/audio/base_models/base_track_record.dart';
import 'package:dune/support/extensions/extensions.dart';
import 'package:isar/isar.dart';

part 'isar_track_record.g.dart';

@Collection(ignore: {'track'})
final class IsarTrackRecord extends BaseTrackRecord<IsarTrack> {
  Id? id;
  @Index(unique: true, replace: true)
  final String? trackId;

  final List<IsarListeningRecord> _listeningHistory;

  @override
  List<IsarListeningRecord> get listeningHistory => _listeningHistory;

  IsarTrackRecord({
    List<IsarListeningRecord> listeningHistory = const [],
    super.track,
    this.id,
    this.trackId,
  })  : _listeningHistory = listeningHistory,
        super(listeningHistory: listeningHistory);

  IsarTrackRecord copyWith({
    IsarTrack? track,
    String? trackId,
    int? id,
    List<IsarListeningRecord>? listeningHistory,
  }) {
    return IsarTrackRecord(
      track: track ?? this.track,
      id: id ?? this.id,
      trackId: trackId ?? this.trackId,
      listeningHistory: listeningHistory ?? this.listeningHistory,
    );
  }

  IsarTrackRecord withAddedUncompletedListensTotalDurationOnDate(
    DateTime date,
    Duration duration,
  ) {
    final newListeningHistory =
        List<IsarListeningRecord>.from(listeningHistory);
    final listeningRecord =
        newListeningHistory.firstWhereOrNull((e) => e.date == date.onlyDate);
    if (listeningRecord != null) {
      newListeningHistory.remove(listeningRecord);

      newListeningHistory.add(
          listeningRecord.withAddedUncompletedListensTotalDuration(duration));
    } else {
      newListeningHistory.add(
        IsarListeningRecord(
            date: date, uncompletedListensTotalDuration: duration),
      );
    }
    return copyWith(listeningHistory: newListeningHistory);
  }

  IsarTrackRecord withCompletedListensCountIncrementedByOneOnDate(
      DateTime date) {
    final newListeningHistory =
        List<IsarListeningRecord>.from(listeningHistory);
    final listeningRecord =
        newListeningHistory.firstWhereOrNull((e) => e.date == date.onlyDate);
    if (listeningRecord != null) {
      newListeningHistory.remove(listeningRecord);

      newListeningHistory
          .add(listeningRecord.withCompletedListensCountIncrementedByOne());
    } else {
      newListeningHistory.add(
        IsarListeningRecord(date: date, completedListensCount: 1),
      );
    }
    return copyWith(listeningHistory: newListeningHistory);
  }
}

@Embedded(ignore: {'uncompletedListensTotalDuration'})
class IsarListeningRecord extends ListeningRecord {
  IsarListeningRecord({
    super.date,
    super.completedListensCount,
    Duration? uncompletedListensTotalDuration,
  }) : uncompletedListensTotalDurationInSeconds =
            (uncompletedListensTotalDuration ?? Duration.zero).inSeconds;

  final int uncompletedListensTotalDurationInSeconds;

  @override
  Duration get uncompletedListensTotalDuration =>
      Duration(seconds: uncompletedListensTotalDurationInSeconds);

  IsarListeningRecord withCompletedListensCountIncrementedByOne() {
    return IsarListeningRecord(
      date: date,
      uncompletedListensTotalDuration: uncompletedListensTotalDuration,
      completedListensCount: (completedListensCount ?? 0) + 1,
    );
  }

  IsarListeningRecord withAddedUncompletedListensTotalDuration(
      Duration duration) {
    return IsarListeningRecord(
      date: date,
      uncompletedListensTotalDuration:
          duration + uncompletedListensTotalDuration,
    );
  }
}
