import 'package:dune/data/audio/isar/helpers/isar_query_builder_helpers.dart';
import 'package:dune/domain/audio/base_data_sources/base_artist_data_source.dart';
import 'package:dune/domain/audio/base_models/base_artist.dart';
import 'package:dune/support/enums/music_source.dart';
import 'package:dune/support/models/query_options.dart';
import 'package:dune/support/utils/result/result.dart';
import 'package:isar/isar.dart';

import '../models/isar_artist.dart';

class IsarArtistDataSource extends BaseSavableArtistDataSource {
  final Isar _isar;

  const IsarArtistDataSource(this._isar);

  @override
  FutureOrResult<IsarArtist?> find(String artistId) async {
    return await Result.fromAsync(() async {
      return await _isar.isarArtists
          .where()
          .idEqualToAnyMusicSource(artistId)
          .findFirst();
    });
  }

  @override
  FutureOrResult<List<IsarArtist>> getWhereIds(List<String> ids) async {
    return await Result.fromAsync(() async => await _isar.isarArtists
        .where()
        .anyOf(ids, (q, id) => q.idEqualToAnyMusicSource(id))
        .findAll());
  }

  FutureOrResult<List<IsarArtist>> getAllWhereIsarIds(List<int?> ids) async {
    return await Result.fromAsync(() async => await _isar.isarArtists
        .where()
        .anyOf(ids, (q, id) => q.isarIdEqualTo(id!))
        .findAll());
  }

  @override
  FutureOrResult<IsarArtist> save(BaseArtist artist) async {
    return await Result.fromAsync(() async {
      final IsarArtist artistToSave =
          artist is IsarArtist ? artist : IsarArtist.fromMap(artist.toMap());
      return await _isar.writeTxn(() async {
        final isarId = await _isar.isarArtists.put(artistToSave);
        return artistToSave.copyWith(isarId: isarId);
      });
    });
  }

  FutureResult<List<IsarArtist>> saveAll(List<BaseArtist> artists) async {
    return await Result.fromAsync(() async {
      final isarArtists =
          artists.map((e) => IsarArtist.fromMap(e.toMap())).toList();
      final ids = await _isar
          .writeTxn(() async => await _isar.isarArtists.putAll(isarArtists));
      List<IsarArtist> artistsWithIds = [];
      for (int i = 0; i < isarArtists.length; i++) {
        artistsWithIds.add(isarArtists[i].copyWith(isarId: ids[i]));
      }
      return artistsWithIds;
    });
  }

  @override
  FutureOrResult<List<IsarArtist>> findAllWhereSource(
      MusicSource musicSource, QueryOptions queryOptions) async {
    return await Result.fromAsync(() async {
      final baseQuery =
          _isar.isarArtists.where().musicSourceEqualTo(musicSource);
      return await applyQueryOptionsOnIsarQueryBuilder(
        baseQuery,
        queryOptions,
        sortByNameQuery: baseQuery.sortByName(),
        sortByNameDescQuery: baseQuery.sortByNameDesc(),
      ).findAll();
    });
  }

  @override
  FutureOrResult<IsarArtist?> findWhereSource(
    String id,
    MusicSource musicSource,
  ) async {
    return await Result.fromAsync(() async {
      return await _isar.isarArtists
          .where()
          .idMusicSourceEqualTo(id, musicSource)
          .findFirst();
    });
  }
}
