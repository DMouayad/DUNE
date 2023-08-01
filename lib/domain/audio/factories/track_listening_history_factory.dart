import 'package:dune/domain/audio/base_models/base_track.dart';
import 'package:dune/domain/audio/factories/base_model_factory.dart';
import 'package:dune/domain/audio/fake_models/fake_track_listening_history.dart';
import 'package:dune/support/extensions/extensions.dart';
import 'package:faker/faker.dart';

import 'track_factory.dart';

final class TrackListeningHistoryFactory
    extends BaseModelFactory<FakeTrackListeningHistory> {
  late final BaseTrack? _track;
  late final DateTime? _date;
  late final Duration? _uncompletedListensTotalDuration;
  late final int? _completedListensCount;

  TrackListeningHistoryFactory() {
    _track = _date =
        _uncompletedListensTotalDuration = _completedListensCount = null;
  }

  @override
  FakeTrackListeningHistory create() {
    return FakeTrackListeningHistory(
      date: _date ?? faker.randomDateFromCurrentMonth,
      track: _track ?? TrackFactory().create(),
      uncompletedListensTotalDuration: _uncompletedListensTotalDuration ??
          Duration(seconds: faker.randomGenerator.integer(10000)),
      completedListensCount:
          _completedListensCount ?? faker.randomGenerator.integer(200),
    );
  }

  TrackListeningHistoryFactory setTrack(BaseTrack? track) {
    return _copyWith(track: track);
  }

  TrackListeningHistoryFactory setCompletedListensCount(int count) {
    return _copyWith(completedListensCount: count);
  }

  TrackListeningHistoryFactory setUnCompletedListensTotalDuration(
    Duration duration,
  ) {
    return _copyWith(uncompletedListensTotalDuration: duration);
  }

  TrackListeningHistoryFactory._({
    required BaseTrack? track,
    required DateTime? date,
    required Duration? uncompletedListensTotalDuration,
    required int? completedListensCount,
  })  : _track = track,
        _date = date,
        _uncompletedListensTotalDuration = uncompletedListensTotalDuration,
        _completedListensCount = completedListensCount;

  TrackListeningHistoryFactory _copyWith({
    BaseTrack? track,
    DateTime? date,
    Duration? uncompletedListensTotalDuration,
    int? completedListensCount,
  }) {
    return TrackListeningHistoryFactory._(
      track: track ?? _track,
      date: date ?? _date,
      uncompletedListensTotalDuration:
          uncompletedListensTotalDuration ?? _uncompletedListensTotalDuration,
      completedListensCount: completedListensCount ?? _completedListensCount,
    );
  }

  TrackListeningHistoryFactory setDate(DateTime? date) {
    return _copyWith(date: date);
  }
}
