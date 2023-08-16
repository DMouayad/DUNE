import 'package:dune/data/audio/isar/helpers/isar_sort_helper.dart';
import 'package:dune/data/audio/isar/models/isar_track.dart';
import 'package:dune/domain/audio/base_data_sources/base_track_data_source.dart';
import 'package:dune/support/enums/music_source.dart';
import 'package:dune/support/models/query_options.dart';
import 'package:dune/support/utils/result/result.dart';
import 'package:isar/isar.dart';

class IsarTrackDataSource implements BaseSavableTrackDataSource<IsarTrack> {
  IsarTrackDataSource(this._isar);

  final Isar _isar;

  @override
  FutureOrResult<IsarTrack?> find(String trackId) async {
    return await Result.fromAsync(
      () async => await _isar.isarTracks
          .where()
          .idEqualToAnySource(trackId)
          .findFirst(),
    );
  }

  @override
  FutureOrResult<IsarTrack> save(IsarTrack track) async {
    return await Result.fromAsync(() async {
      final id =
          await _isar.writeTxn(() async => await _isar.isarTracks.put(track));
      return track.copyWithIsar(isarId: id);
    });
  }

  FutureOrResult<List<IsarTrack>> saveAll(List<IsarTrack> tracks) async {
    return await Result.fromAsync(() async {
      await _isar.writeTxn(() async {
        await _isar.isarTracks.putAll(tracks);
      });
      return tracks;
    });
  }

  @override
  FutureOrResult<List<IsarTrack>> getWhereIds(List<String> ids) async {
    return await Result.fromAsync(() async {
      return await _isar.isarTracks
          .where()
          .anyOf(ids, (q, id) => q.idEqualToAnySource(id))
          .findAll();
    });
  }

  @override
  FutureOrResult<List<IsarTrack>> findAllWhereSource(
    MusicSource musicSource,
    QuerySortOptions sortOptions,
  ) async {
    return await Result.fromAsync(
      () async {
        final baseQuery = _isar.isarTracks.where().sourceEqualTo(musicSource);
        return await sortIsarQueryByOptions(
          baseQuery,
          sortOptions,
          sortByDateReleasedQuery: baseQuery.sortByYear(),
          sortByDateReleasedDescQuery: baseQuery.sortByYearDesc(),
          sortByNameQuery: baseQuery.sortByTitle(),
          sortByNameDescQuery: baseQuery.sortByTitleDesc(),
        ).findAll();
      },
    );
  }

  @override
  FutureOrResult<IsarTrack?> findWhereSource(
      String id, MusicSource musicSource) async {
    return await Result.fromAsync(
      () async => await _isar.isarTracks
          .where()
          .idSourceEqualTo(id, musicSource)
          .findFirst(),
    );
  }
}
