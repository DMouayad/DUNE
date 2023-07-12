import 'package:dune/data/audio/isar/data_sources/isar_playlist_data_source.dart';
import 'package:dune/data/audio/isar/helpers/isar_models_relation_helper.dart';
import 'package:dune/data/audio/isar/models/isar_playlist.dart';
import 'package:dune/data/audio/isar/repositories/isar_track_repository.dart';
import 'package:dune/domain/audio/base_models/base_playlist.dart';
import 'package:dune/domain/audio/repositories/playlist_repository.dart';
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

  @override
  FutureOrResult<IsarPlaylist> save(BasePlaylist playlist) async {
    return await Result.fromAnother(() async {
      //  first we save the playlist tracks to database.
      final tracksResult = await _trackRepository.saveAll(playlist.tracks);
      if (tracksResult.isFailure) {
        return tracksResult.mapFailure((error) => error);
      }
      final isarPlaylistResult = await _playlistDataSource.save(playlist);
      if (isarPlaylistResult.isFailure) return isarPlaylistResult;
      final tracks = tracksResult.requireValue;
      final tracksIds = tracks.map((e) => e.id).toList();
      final isarPlaylist = isarPlaylistResult.requireValue
          .copyWith(tracks: tracks, tracksIds: tracksIds);

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
}
