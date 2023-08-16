import 'package:dune/data/audio/isar/data_sources/isar_playlist_data_source.dart';
import 'package:dune/data/audio/isar/helpers/isar_models_relation_helper.dart';
import 'package:dune/data/audio/isar/models/isar_playlist.dart';
import 'package:dune/data/audio/isar/models/isar_thumbnails_set.dart';
import 'package:dune/data/audio/isar/repositories/isar_track_repository.dart';
import 'package:dune/domain/audio/base_models/base_playlist.dart';
import 'package:dune/domain/audio/repositories/playlist_repository.dart';
import 'package:dune/support/enums/music_source.dart';
import 'package:dune/support/models/query_options.dart';
import 'package:dune/support/utils/result/result.dart';

final class IsarPlaylistRepository
    extends SavablePlaylistRepository<IsarPlaylistDataSource> {
  IsarPlaylistRepository(
    this._playlistDataSource,
    this._trackRepository,
    this._relationHelper,
  ) : super(_playlistDataSource);

  final IsarTrackRepository _trackRepository;
  final IsarPlaylistDataSource _playlistDataSource;
  final IsarModelsRelationHelper _relationHelper;

  @override
  FutureOrResult<IsarPlaylist?> getById(String id) async {
    return (await _playlistDataSource.find(id))
        .flatMapSuccessAsync((value) async {
      if (value != null) {
        return await _relationHelper.loadRelationsForPlaylist(value, true);
      }
      return value.asResult;
    });
  }

  IsarPlaylist _getIsarPlaylistFromBase(BasePlaylist playlist) {
    final tracksIds = playlist.tracks.map((e) => e.id).toList();
    return IsarPlaylist(
      id: playlist.id,
      author: IsarPlaylistAuthor(
        name: playlist.author?.name,
        id: playlist.author?.id,
      ),
      musicSource: playlist.musicSource,
      tracksIds: tracksIds,
      isarThumbnails: IsarThumbnailsSet.fromMap(playlist.thumbnails.toMap()),
      description: playlist.description,
      duration: playlist.duration,
      durationSeconds: playlist.durationSeconds,
      title: playlist.title,
      createdAt: playlist.createdAt,
    );
  }

  @override
  FutureOrResult<List<BasePlaylist>> saveCategoryPlaylists(
    String categoryId,
    List<BasePlaylist> playlists,
  ) async {
    return await _playlistDataSource.saveCategoryPlaylists(
      categoryId,
      playlists.map((e) => _getIsarPlaylistFromBase(e)).toList(),
    );
  }

  @override
  FutureOrResult<IsarPlaylist> save(BasePlaylist playlist) async {
    return await Result.fromAnother(() async {
      //  first we save the playlist tracks to database.
      final tracksResult = await _trackRepository.saveAll(playlist.tracks);
      if (tracksResult.isFailure) {
        return tracksResult.mapFailure((error) => error);
      }
      final tracks = tracksResult.requireValue;

      final isarPlaylist =
          _getIsarPlaylistFromBase(playlist).copyWith(tracks: tracks);
      return await _playlistDataSource.save(isarPlaylist);
    });
  }

  @override
  FutureOrResult<List<BasePlaylist>?> getCategoryPlaylists(
    String categoryId,
  ) async {
    final fetchingCategoryPlaylistsIds =
        await _playlistDataSource.getCategoryPlaylistsIds(categoryId);
    if (fetchingCategoryPlaylistsIds.isFailure) {
      return fetchingCategoryPlaylistsIds.mapFailure((error) => error);
    }

    final playlistsIds = fetchingCategoryPlaylistsIds.requireValue;
    if (playlistsIds == null) return const SuccessResult(null);
    // first get playlists with matching [playlistsIds]
    // then return them with tracks added for each one of them.
    return (await _playlistDataSource.getWhereId(playlistsIds))
        .flatMapSuccessAsync((playlists) async {
      return await _relationHelper.loadRelationsForPlaylists(
        playlists,
        loadTracksRelations: false,
      );
    });
  }

  @override
  FutureOrResult<List<BasePlaylist>> findAllWhereSource(
      MusicSource musicSource, QuerySortOptions sortOptions) async {
    return (await _playlistDataSource.findAllWhereSource(
      musicSource,
      sortOptions,
    ))
        .flatMapSuccessAsync((value) async {
      if (value.isNotEmpty) {
        return await _relationHelper.loadRelationsForPlaylists(
          value,
          loadTracksRelations: true,
        );
      }
      return value.asResult;
    });
  }

  @override
  FutureOrResult<BasePlaylist?> findWhereSource(
    String id,
    MusicSource musicSource,
  ) async {
    return (await _playlistDataSource.findWhereSource(id, musicSource))
        .flatMapSuccessAsync((value) async {
      if (value != null) {
        return await _relationHelper.loadRelationsForPlaylist(value, true);
      }
      return value.asResult;
    });
  }
}
