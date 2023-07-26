import 'package:dune/data/audio/isar/data_sources/isar_listening_history_month_summary_data_source.dart';
import 'package:dune/data/audio/isar/data_sources/isar_track_listening_history_data_source.dart';
import 'package:dune/data/audio/isar/helpers/isar_models_relation_helper.dart';
import 'package:dune/data/audio/isar/models/isar_artist.dart';
import 'package:dune/data/audio/isar/models/isar_listening_history_month_summary.dart';
import 'package:dune/data/audio/isar/models/isar_track.dart';
import 'package:dune/data/audio/isar/models/isar_track_listening_history.dart';
import 'package:dune/data/audio/isar/models/isar_track_month_listening_history.dart';
import 'package:dune/domain/audio/base_models/base_listening_history_month_summary.dart';
import 'package:dune/domain/audio/repositories/listening_history_month_summary_repository.dart';
import 'package:dune/support/utils/result/result.dart';
import 'package:isar/isar.dart';

class IsarListeningHistoryMonthSummaryRepository
    extends ListeningHistoryMonthSummaryRepository {
  IsarListeningHistoryMonthSummaryRepository(
    IsarTrackListeningHistoryDataSource trackListeningHistoryDataSource,
    IsarListeningHistoryMonthSummaryDataSource dataSource,
    this._relationHelper,
    this._isar,
  ) : super(dataSource, trackListeningHistoryDataSource);

  final IsarModelsRelationHelper _relationHelper;
  final Isar _isar;

  @override
  FutureResult<BaseListeningHistoryMonthSummary> createMonthSummary({
    required int month,
    required int year,
  }) async {
    final tracksHistoryMonthQuery = _isar.isarTrackListeningHistorys
        .where()
        .dateBetween(DateTime(year, month), DateTime(year, month, 31));
    final tracksIds = await tracksHistoryMonthQuery
        .filter()
        .trackIdIsNotNull()
        .distinctByTrackId()
        .limit(50)
        .trackIdProperty()
        .findAll();
    final List<IsarTrack> tracks;
    if (tracksIds.isNotEmpty) {
      tracks = await _isar.isarTracks
          .where()
          .anyOf(tracksIds, (q, element) => q.idEqualTo(element!))
          .findAll();
    } else {
      tracks = [];
    }

    final List<IsarMonthListeningHistoryTrackSummary> topTracks = [];
    final artistsIds = tracks
        .map((e) => e.artistsIds)
        .expand((element) => element)
        .toSet()
        .toList();
    final artistsTracksListeningCount = <String, int>{};
    int totalListeningMinutes = 0;
    for (var track in tracks) {
      final completedListensCount = await tracksHistoryMonthQuery
          .filter()
          .trackIdEqualTo(track.id)
          .completedListensCountProperty()
          .sum();
      final listeningDurationInSec = await tracksHistoryMonthQuery
          .filter()
          .trackIdEqualTo(track.id)
          .totalListeningDurationInSecondsProperty()
          .sum();
      totalListeningMinutes += (listeningDurationInSec ~/ 60);
      topTracks.add(
        IsarMonthListeningHistoryTrackSummary(
          track: track,
          trackId: track.id,
          completedListensCount: completedListensCount,
          totalListeningMinutes: listeningDurationInSec ~/ 60,
        ),
      );
      for (var artistId in track.artistsIds) {
        if (artistsTracksListeningCount.containsKey(artistId)) {
          artistsTracksListeningCount[artistId] =
              artistsTracksListeningCount[artistId]! + 1;
        } else {
          artistsTracksListeningCount[artistId] = 1;
        }
      }
    }
    topTracks.sort(
      (t1, t2) => -t1.totalListeningMinutes.compareTo(t2.totalListeningMinutes),
    );

    final artists = await _isar.isarArtists
        .where()
        .anyOf(artistsIds, (q, element) => q.idEqualTo(element))
        .findAll();
    final topArtists = <IsarMonthListeningHistoryArtistSummary>[];
    for (var artist in artists) {
      final artistHasTrackCount =
          artistsTracksListeningCount.containsKey(artist.id);
      if (artistHasTrackCount) {
        topArtists.add(IsarMonthListeningHistoryArtistSummary(
          listenedToTracksCount: artistsTracksListeningCount[artist.id],
          artist: artist,
          artistId: artist.id,
        ));
      }
    }

    final monthSummary = IsarListeningHistoryMonthSummary(
      month: month,
      year: year,
      tracksCount: tracksIds.length,
      isarTopTracks: topTracks,
      artistsCount: artistsTracksListeningCount.length,
      isarTopArtists: topArtists,
      listeningMinutesTotal: totalListeningMinutes,
    );

    final isarId = await _isar.writeTxn(() async =>
        await _isar.isarListeningHistoryMonthSummarys.put(monthSummary));

    return monthSummary.copyWith(id: isarId).asResult;
  }

  @override
  FutureResult<BaseListeningHistoryMonthSummary?> getMonthSummary({
    required int month,
    required int year,
  }) async {
    return (await super.getMonthSummary(month: month, year: year))
        .flatMapSuccessAsync((value) async {
      if (value == null) return value.asResult;
      return await _relationHelper.loadRelationsForMonthSummary(value);
    });
  }
}
