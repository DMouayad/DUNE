import 'package:dune/domain/audio/base_models/base_track.dart';
import 'package:dune/domain/audio/base_models/base_track_listening_history.dart';

final class FakeTrackListeningHistory extends BaseTrackListeningHistory {
  FakeTrackListeningHistory({
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
    // TODO: implement copyWith
    throw UnimplementedError();
  }
}
