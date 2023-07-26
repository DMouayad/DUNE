import 'package:dune/domain/audio/base_models/base_track.dart';
import 'package:dune/domain/audio/base_models/base_track_listening_history.dart';
import 'package:dune/support/extensions/extensions.dart';
import 'package:faker/faker.dart';

import '../base_model_factory.dart';
import 'fake_track.dart';

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

final class FakeTrackListeningHistoryFactory
    extends BaseModelFactory<FakeTrackListeningHistory> {
  late final BaseTrack? _track;
  late final DateTime? _date;
  late final Duration? _uncompletedListensTotalDuration;
  late final int? _completedListensCount;

  FakeTrackListeningHistoryFactory() {
    _track = _date =
        _uncompletedListensTotalDuration = _completedListensCount = null;
  }

  @override
  FakeTrackListeningHistory create() {
    return FakeTrackListeningHistory(
      date: _date ?? faker.date.dateTime().onlyDate,
      track: _track ?? FakeTrackFactory().create(),
      uncompletedListensTotalDuration: _uncompletedListensTotalDuration ??
          Duration(seconds: faker.randomGenerator.integer(10000)),
      completedListensCount:
          _completedListensCount ?? faker.randomGenerator.integer(300),
    );
  }

  FakeTrackListeningHistoryFactory setTrack(BaseTrack track) {
    return _copyWith(track: track);
  }

  FakeTrackListeningHistoryFactory setCompletedListensCount(int count) {
    return _copyWith(completedListensCount: count);
  }

  FakeTrackListeningHistoryFactory setUnCompletedListensTotalDuration(
    Duration duration,
  ) {
    return _copyWith(uncompletedListensTotalDuration: duration);
  }

  FakeTrackListeningHistoryFactory._({
    required BaseTrack? track,
    required DateTime? date,
    required Duration? uncompletedListensTotalDuration,
    required int? completedListensCount,
  })  : _track = track,
        _date = date,
        _uncompletedListensTotalDuration = uncompletedListensTotalDuration,
        _completedListensCount = completedListensCount;

  FakeTrackListeningHistoryFactory _copyWith({
    BaseTrack? track,
    DateTime? date,
    Duration? uncompletedListensTotalDuration,
    int? completedListensCount,
  }) {
    return FakeTrackListeningHistoryFactory._(
      track: track ?? _track,
      date: date ?? _date,
      uncompletedListensTotalDuration:
          uncompletedListensTotalDuration ?? _uncompletedListensTotalDuration,
      completedListensCount: completedListensCount ?? _completedListensCount,
    );
  }
}
