import 'package:dune/data/audio/isar/helpers/isar_sort_helper.dart';
import 'package:dune/data/audio/isar/models/isar_category_playlists.dart';
import 'package:dune/data/audio/isar/models/isar_playlist.dart';
import 'package:dune/domain/audio/base_data_sources/base_playlist_data_source.dart';
import 'package:dune/domain/audio/base_models/base_playlist.dart';
import 'package:dune/support/enums/music_source.dart';
import 'package:dune/support/logger_service.dart';
import 'package:dune/support/models/query_options.dart';
import 'package:dune/support/utils/result/result.dart';
import 'package:isar/isar.dart';

class IsarPlaylistDataSource
    extends BaseSavablePlaylistDataSource<IsarPlaylist> {
  final Isar _isar;

  IsarPlaylistDataSource(this._isar);

  @override
  FutureOrResult<IsarPlaylist?> find(String playlistId) async {
    return await Result.fromAsync(() async {
      return await _isar.isarPlaylists
          .where()
          .idEqualToAnyMusicSource(playlistId)
          .findFirst();
    });
  }

  @override
  FutureOrResult<IsarPlaylist> save(IsarPlaylist playlist) async {
    return await Result.fromAsync(() async {
      return await _isar.writeTxn(() async {
        // write the playlist to the db and get it's assigned [ID].
        final playlistId = await _isar.isarPlaylists.put(playlist);
        return playlist.copyWith(isarId: playlistId);
      });
    });
  }

  FutureOrResult<List<IsarPlaylist>> getWhereIsarId(List<int?> ids) async {
    return await Result.fromAsync(() async {
      return await _isar.isarPlaylists
          .where()
          .anyOf(ids, (q, id) => q.isarIdEqualTo(id!))
          .findAll();
    });
  }

  FutureOrResult<List<IsarPlaylist>> getWhereId(List<String> ids) async {
    return await Result.fromAsync(() async {
      return await _isar.isarPlaylists
          .where()
          .anyOf(ids, (q, id) => q.idEqualToAnyMusicSource(id))
          .findAll();
    });
  }

  FutureResult<List<String>?> getCategoryPlaylistsIds(String categoryId) async {
    return await Result.fromAsync(() async {
      return await _isar.isarCategoryPlaylists
          .where()
          .categoryIdEqualTo(categoryId)
          .playlistsIdsProperty()
          .findFirst();
    });
  }

  @override
  FutureOrResult<List<IsarPlaylist>> getCategoryPlaylists(
    String categoryId,
  ) async {
    // handled in [IsarPlaylistRepository]
    throw UnimplementedError();
  }

  @override
  FutureOrResult<List<IsarPlaylist>> saveCategoryPlaylists(
    String categoryId,
    List<IsarPlaylist> playlists,
  ) async {
    return await Result.fromAnother(() async {
      List<String> ids = [];
      for (BasePlaylist playlist in playlists) {
        if (playlist.id == null) {
          Log.e("playlist has no id");
        } else {
          ids.add(playlist.id!);
        }
      }
      var isarCategoryPlaylists = IsarCategoryPlaylists(
        categoryId: categoryId,
        playlistsIds: ids,
      );
      await _isar.writeTxn(() async {
        final id = await _isar.isarCategoryPlaylists.put(isarCategoryPlaylists);
        isarCategoryPlaylists = isarCategoryPlaylists.copyWith(id: id);
      });
      return await saveAll(playlists);
    });
  }

  FutureOrResult<List<IsarPlaylist>> saveAll(
      List<IsarPlaylist> playlists) async {
    List<IsarPlaylist> result = [];
    for (var playlist in playlists) {
      final savingPlaylistResult = await save(playlist);
      if (savingPlaylistResult.isFailure) {
        Log.e(savingPlaylistResult);
      } else {
        result.add(savingPlaylistResult.requireValue);
      }
    }
    return result.asResult;
  }

  @override
  FutureOrResult<List<IsarPlaylist>> findAllWhereSource(
    MusicSource musicSource,
    QuerySortOptions sortOptions,
  ) async {
    return await Result.fromAsync(() async {
      final baseQuery =
          _isar.isarPlaylists.where().musicSourceEqualTo(musicSource);
      return await sortIsarQueryByOptions(
        baseQuery,
        sortOptions,
        sortByCreatedAtQuery: baseQuery.sortByCreatedAt(),
        sortByCreatedAtDescQuery: baseQuery.sortByCreatedAtDesc(),
        sortByNameQuery: baseQuery.sortByTitle(),
        sortByNameDescQuery: baseQuery.sortByTitleDesc(),
      ).findAll();
    });
  }

  @override
  FutureOrResult<IsarPlaylist?> findWhereSource(
    String id,
    MusicSource musicSource,
  ) async {
    return await Result.fromAsync(() async {
      return await _isar.isarPlaylists
          .where()
          .idMusicSourceEqualTo(id, musicSource)
          .findFirst();
    });
  }
}
