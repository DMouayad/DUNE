import 'package:dune/domain/audio/base_models/base_artist.dart';
import 'package:dune/domain/audio/base_models/base_listening_history_month_summary.dart';
import 'package:isar/isar.dart';

import 'isar_artist.dart';
import 'isar_track_month_listening_history.dart';

part 'isar_listening_history_month_summary.g.dart';

@Collection(ignore: {
  'props',
  'hashCode',
  'stringify',
  'derived',
  'topArtists',
  'topTracks'
})
final class IsarListeningHistoryMonthSummary
    extends BaseListeningHistoryMonthSummary {
  IsarListeningHistoryMonthSummary({
    this.id,
    this.isarTopTracks = const [],
    this.isarTopArtists = const [],
    super.listeningMinutesTotal = 0,
    super.artistsCount,
    super.month,
    super.year,
    super.mostListenedOnDay,
    super.tracksCount,
    super.tracksCountIncreasePercentage,
    super.tracksRepetitionPercent,
  }) : super(
          topTracks: isarTopTracks,
          topArtists: isarTopArtists.map((e) => e.toRecord()).toList(),
        );

  @Index(composite: [CompositeIndex('year')], unique: true)
  @override
  int? get month => super.month;
  Id? id;

  @override
  List<MonthListeningHistoryArtistSummary> get topArtists {
    final result = <MonthListeningHistoryArtistSummary>[];
    for (var item in isarTopArtists) {
      if (item.artist != null) {
        result.add((
          artist: item.artist!,
          listenedToTracksCount: item.listenedToTracksCount ?? 0,
        ));
      }
    }
    return result;
  }

  @override
  Set<Type> get derived => {BaseListeningHistoryMonthSummary};
  final List<IsarMonthListeningHistoryTrackSummary> isarTopTracks;
  final List<IsarMonthListeningHistoryArtistSummary> isarTopArtists;

  IsarListeningHistoryMonthSummary copyWith({
    Id? id,
    int? month,
    int? year,
    int? tracksCount,
    double? tracksCountIncreasePercentage,
    List<IsarMonthListeningHistoryTrackSummary>? isarTopTracks,
    int? tracksRepetitionPercent,
    DateTime? mostListenedOnDay,
    int? artistsCount,
    int? listeningMinutesTotal,
    List<IsarMonthListeningHistoryArtistSummary>? topArtists,
  }) {
    return IsarListeningHistoryMonthSummary(
      id: id ?? this.id,
      month: month ?? this.month,
      year: year ?? this.year,
      mostListenedOnDay: mostListenedOnDay ?? this.mostListenedOnDay,
      isarTopTracks: isarTopTracks ?? this.isarTopTracks,
      isarTopArtists: topArtists ?? isarTopArtists,
      tracksCount: tracksCount ?? this.tracksCount,
      artistsCount: artistsCount ?? this.artistsCount,
      listeningMinutesTotal:
          listeningMinutesTotal ?? this.listeningMinutesTotal,
      tracksCountIncreasePercentage:
          tracksCountIncreasePercentage ?? this.tracksCountIncreasePercentage,
      tracksRepetitionPercent:
          tracksRepetitionPercent ?? this.tracksRepetitionPercent,
    );
  }
}

@Embedded(ignore: {'artist'})
class IsarMonthListeningHistoryArtistSummary {
  final IsarArtist? artist;
  final String? artistId;
  final int? listenedToTracksCount;

  IsarMonthListeningHistoryArtistSummary({
    this.artist,
    this.artistId,
    this.listenedToTracksCount,
  });

  ({BaseArtist artist, int listenedToTracksCount}) toRecord() {
    return (artist: artist!, listenedToTracksCount: listenedToTracksCount!);
  }
}
