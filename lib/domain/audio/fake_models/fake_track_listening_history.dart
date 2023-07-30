import 'package:dune/domain/audio/base_models/base_track.dart';
import 'package:dune/domain/audio/base_models/base_track_listening_history.dart';
import 'package:dune/domain/audio/factories/base_model_factory.dart';
import 'package:dune/domain/audio/factories/track_factory.dart';
import 'package:dune/support/extensions/extensions.dart';
import 'package:faker/faker.dart';

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
