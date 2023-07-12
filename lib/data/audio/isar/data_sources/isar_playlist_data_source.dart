import 'package:dune/data/audio/isar/models/isar_category_playlists.dart';
import 'package:dune/data/audio/isar/models/isar_playlist.dart';
import 'package:dune/data/audio/isar/models/isar_thumbnails_set.dart';
import 'package:dune/domain/audio/base_data_sources/base_playlist_data_source.dart';
import 'package:dune/domain/audio/base_models/base_playlist.dart';
import 'package:dune/support/logger_service.dart';
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
          .filter()
          .idEqualTo(playlistId)
          .findFirst();
    });
  }

  @override
  FutureOrResult<IsarPlaylist> save(BasePlaylist playlist) async {
    return await Result.fromAsync(() async {
      final isarPlaylist = playlist is IsarPlaylist
          ? playlist
          : _getIsarPlaylistFromBase(playlist);
      return await _isar.writeTxn(() async {
        // write the playlist to the db and get it's assigned [ID].
        final playlistId = await _isar.isarPlaylists.put(isarPlaylist);
        return isarPlaylist.copyWith(isarId: playlistId);
      });
    });
  }

  IsarPlaylist _getIsarPlaylistFromBase(BasePlaylist playlist) {
    return IsarPlaylist(
      id: playlist.id,
      author: IsarPlaylistAuthor(
        name: playlist.author?.name,
        id: playlist.author?.id,
      ),
      thumbnails: IsarThumbnailsSet.fromMap(playlist.thumbnails.toMap()),
      description: playlist.description,
      duration: playlist.duration,
      durationSeconds: playlist.durationSeconds,
      title: playlist.title,
      createdAt: playlist.createdAt,
    );
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
          .anyOf(ids, (q, id) => q.idEqualTo(id))
          .findAll();
    });
  }

  FutureResult<List<String>?> getCategoryPlaylistsIds(String categoryId) async {
    return await Result.fromAsync(() async {
      return await _isar.isarCategoryPlaylists
          .filter()
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
    List<BasePlaylist> playlists,
  ) async {
    return await Result.fromAnother(() async {
      List<String> ids = [];
      for (BasePlaylist playlist in playlists) {
        if (playlist.id != null) {
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
      List<BasePlaylist> playlists) async {
    List<IsarPlaylist> result = [];
    for (BasePlaylist playlist in playlists) {
      final savingPlaylistResult = await save(playlist);
      if (savingPlaylistResult.isFailure) {
        Log.e(savingPlaylistResult);
      } else {
        result.add(savingPlaylistResult.requireValue);
      }
    }
    return result.asResult;
  }
}
