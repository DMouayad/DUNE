import 'package:dune/data/audio/isar/models/isar_track.dart';
import 'package:dune/domain/audio/base_models/base_track_listening_history.dart';
import 'package:isar/isar.dart';

part 'isar_track_listening_history.g.dart';

@Collection(ignore: {
  'track',
  'uncompletedListensTotalDuration',
  'totalListeningDuration',
  'props',
  'derived',
  'stringify'
})
final class IsarTrackListeningHistory
    extends BaseTrackListeningHistory<IsarTrack> {
  Id? id;
  @Index(unique: true, replace: true)
  final String? trackId;

  @override
  Set<Type> get derived => {BaseTrackListeningHistory};

  @override
  @Index()
  DateTime? get date => super.date;

  IsarTrackListeningHistory({
    this.id,
    this.trackId,
    super.track,
    super.completedListensCount,
    super.date,
    this.uncompletedListensTotalDurationInSeconds = 0,
  })  : totalListeningDurationInSeconds =
            TrackListeningHistoryHelper.getTotalListeningDuration(
                  completedListensCount,
                  track?.duration,
                  Duration(seconds: uncompletedListensTotalDurationInSeconds),
                )?.inSeconds ??
                0,
        super(
          uncompletedListensTotalDuration:
              Duration(seconds: uncompletedListensTotalDurationInSeconds),
        );

  final int uncompletedListensTotalDurationInSeconds;
  final int totalListeningDurationInSeconds;

  @override
  Duration get uncompletedListensTotalDuration =>
      Duration(seconds: uncompletedListensTotalDurationInSeconds);

  IsarTrackListeningHistory copyWithCompletedListensCountIncrementedByOne() {
    return copyWith(
      completedListensCount: (completedListensCount ?? 0) + 1,
    );
  }

  IsarTrackListeningHistory copyWithAddedUncompletedListensTotalDuration(
    Duration duration,
  ) {
    return copyWith(
      uncompletedListensTotalDuration:
          duration + uncompletedListensTotalDuration,
    );
  }

  @override
  Type copyWith<Type extends BaseTrackListeningHistory>({
    IsarTrack? track,
    DateTime? date,
    Duration? uncompletedListensTotalDuration,
    int? completedListensCount,
  }) {
    return IsarTrackListeningHistory(
      track: track ?? this.track,
      id: id,
      trackId: trackId,
      date: date ?? this.date,
      uncompletedListensTotalDurationInSeconds:
          (uncompletedListensTotalDuration ??
                  this.uncompletedListensTotalDuration)
              .inSeconds,
      completedListensCount:
          completedListensCount ?? this.completedListensCount,
    ) as Type;
  }
}
