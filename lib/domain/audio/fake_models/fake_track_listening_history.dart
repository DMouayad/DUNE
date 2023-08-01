import 'package:dune/domain/audio/base_models/base_track.dart';
import 'package:dune/domain/audio/base_models/base_track_listening_history.dart';

final class FakeTrackListeningHistory extends BaseTrackListeningHistory {
  @override
  Set<Type> get derived => {BaseTrackListeningHistory};

  const FakeTrackListeningHistory({
    super.date,
    super.uncompletedListensTotalDuration,
    super.completedListensCount,
    super.track,
  });

  @override
  Type copyWith<Type extends BaseTrackListeningHistory>({
    BaseTrack? track,
    DateTime? date,
    Duration? uncompletedListensTotalDuration,
    int? completedListensCount,
  }) {
    return FakeTrackListeningHistory(
      track: track ?? this.track,
      date: date ?? this.date,
      completedListensCount:
          completedListensCount ?? this.completedListensCount,
      uncompletedListensTotalDuration: uncompletedListensTotalDuration ??
          this.uncompletedListensTotalDuration,
    ) as Type;
  }
}
