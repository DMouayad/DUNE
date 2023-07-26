import 'package:dune/domain/audio/base_models/base_artist.dart';
import 'package:equatable/equatable.dart';

import 'base_track.dart';

abstract class BaseListeningHistoryMonthSummary extends Equatable {
  final int? month;
  final int? year;
  final int? tracksCount;
  final double? tracksCountIncreasePercentage;
  final List<MonthListeningHistoryTrackSummary> topTracks;
  final int? tracksRepetitionPercent;
  final DateTime? mostListenedOnDay;
  final int? artistsCount;
  final int listeningMinutesTotal;
  final List<MonthListeningHistoryArtistSummary> topArtists;

  const BaseListeningHistoryMonthSummary({
    this.month,
    this.year,
    this.tracksCount,
    this.tracksCountIncreasePercentage,
    this.topTracks = const [],
    this.tracksRepetitionPercent,
    this.mostListenedOnDay,
    this.artistsCount,
    required this.listeningMinutesTotal,
    required this.topArtists,
  });

  @override
  List<Object?> get props => [
        month,
        tracksCount,
        year,
        tracksCountIncreasePercentage,
        topTracks,
        tracksRepetitionPercent,
        mostListenedOnDay,
        artistsCount,
        listeningMinutesTotal,
        topArtists,
      ];
}

typedef MonthListeningHistoryArtistSummary = ({
  BaseArtist artist,
  int listenedToTracksCount
});

class MonthListeningHistoryTrackSummary extends Equatable {
  final BaseTrack? track;
  final int completedListensCount;
  final int totalListeningMinutes;

  const MonthListeningHistoryTrackSummary({
    this.track,
    this.completedListensCount = 0,
    this.totalListeningMinutes = 0,
  });

  @override
  List<Object?> get props =>
      [track, completedListensCount, totalListeningMinutes];
}
