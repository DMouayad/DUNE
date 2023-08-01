import 'package:equatable/equatable.dart';

import 'base_track.dart';

abstract class BaseTrackListeningHistory<T extends BaseTrack>
    extends Equatable {
  final T? track;
  final DateTime? date;
  final Duration? uncompletedListensTotalDuration;
  final int? completedListensCount;

  Duration? get totalListeningDuration {
    return TrackListeningHistoryHelper.getTotalListeningDuration(
      completedListensCount,
      track?.duration,
      uncompletedListensTotalDuration,
    );
  }

  const BaseTrackListeningHistory({
    this.date,
    this.uncompletedListensTotalDuration,
    this.completedListensCount,
    this.track,
  });

  Type copyWith<Type extends BaseTrackListeningHistory>({
    T? track,
    DateTime? date,
    Duration? uncompletedListensTotalDuration,
    int? completedListensCount,
  });

  Map<String, dynamic> toMap() {
    return {
      'track': track?.toMap(),
      'date': date?.toIso8601String(),
      'uncompletedListensTotalDuration': uncompletedListensTotalDuration,
      'completedListensCount': completedListensCount,
    };
  }

  @override
  List<Object?> get props =>
      [track, date, uncompletedListensTotalDuration, completedListensCount];
}

class TrackListeningHistoryHelper {
  static Duration? getTotalListeningDuration(
    int? completedListensCount,
    Duration? trackDuration,
    Duration? uncompletedListensTotalDuration,
  ) {
    Duration? totalDuration;
    if (completedListensCount != null && trackDuration != null) {
      totalDuration =
          Duration(seconds: completedListensCount * trackDuration.inSeconds);
    }
    if (uncompletedListensTotalDuration != null) {
      totalDuration =
          (totalDuration ?? Duration.zero) + uncompletedListensTotalDuration;
    }
    return totalDuration;
  }
}
