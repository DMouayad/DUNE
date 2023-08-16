import 'package:dune/data/audio/isar/helpers/isar_sort_helper.dart';
import 'package:dune/data/audio/isar/models/isar_album.dart';
import 'package:dune/domain/audio/base_data_sources/base_album_data_source.dart';
import 'package:dune/support/enums/music_source.dart';
import 'package:dune/support/models/query_options.dart';
import 'package:dune/support/utils/result/result.dart';
import 'package:isar/isar.dart';

class IsarAlbumDataSource implements BaseSavableAlbumDataSource<IsarAlbum> {
  IsarAlbumDataSource(this._isar);

  final Isar _isar;

  @override
  FutureOrResult<IsarAlbum?> find(String albumId) async {
    return await Result.fromAsync(
      () async => await _isar.isarAlbums
          .where()
          .idEqualToAnyMusicSource(albumId)
          .findFirst(),
    );
  }

  @override
  FutureOrResult<IsarAlbum> save(IsarAlbum album) async {
    return await Result.fromAsync(() async {
      final id =
          await _isar.writeTxn(() async => await _isar.isarAlbums.put(album));
      return album.copyWith(isarId: id);
    });
  }

  FutureOrResult<List<IsarAlbum>> saveAll(List<IsarAlbum> albums) async {
    return await Result.fromAsync(() async {
      await _isar.writeTxn(() async {
        await _isar.isarAlbums.putAll(albums);
      });
      return albums;
    });
  }

  @override
  FutureOrResult<List<IsarAlbum>> getWhereIds(List<String> ids) async {
    return await Result.fromAsync(() async {
      return await _isar.isarAlbums
          .where()
          .anyOf(ids, (q, id) => q.idEqualToAnyMusicSource(id))
          .findAll();
    });
  }

  @override
  FutureOrResult<List<IsarAlbum>> findAllWhereSource(
      MusicSource musicSource, QuerySortOptions sortOptions) async {
    return await Result.fromAsync(
      () async {
        final baseQuery =
            _isar.isarAlbums.where().musicSourceEqualTo(musicSource);
        return await sortIsarQueryByOptions(
          baseQuery,
          sortOptions,
          sortByDateReleasedQuery: baseQuery.sortByReleaseDate(),
          sortByDateReleasedDescQuery: baseQuery.sortByReleaseDateDesc(),
          sortByNameQuery: baseQuery.sortByTitle(),
          sortByNameDescQuery: baseQuery.sortByTitleDesc(),
        ).findAll();
      },
    );
  }

  @override
  FutureOrResult<IsarAlbum?> findWhereSource(
      String id, MusicSource musicSource) async {
    return await Result.fromAsync(
      () async => await _isar.isarAlbums
          .where()
          .idMusicSourceEqualTo(id, musicSource)
          .findFirst(),
    );
  }
}
