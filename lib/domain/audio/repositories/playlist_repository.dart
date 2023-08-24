import 'package:dune/domain/audio/base_data_sources/base_playlist_data_source.dart';
import 'package:dune/domain/audio/base_models/base_playlist.dart';
import 'package:dune/domain/audio/traits/finds_by_music_source.dart';
import 'package:dune/support/utils/result/result.dart';

base class PlaylistRepository<T extends BasePlaylistDataSource> {
  final T _dataSource;

  const PlaylistRepository(this._dataSource);

  FutureOrResult<BasePlaylist?> getById(String id) async {
    return await _dataSource.find(id);
  }

  FutureOrResult<List<BasePlaylist>?> getCategoryPlaylists(
    String categoryId,
  ) async {
    return await _dataSource.getCategoryPlaylists(categoryId);
  }
}

abstract base class SavablePlaylistRepository<
        T extends BaseSavablePlaylistDataSource> extends PlaylistRepository<T>
    with FindsByMusicSource<BasePlaylist> {
  const SavablePlaylistRepository(super.dataSource);

  FutureOrResult<BasePlaylist> save(BasePlaylist playlist);

  FutureOrResult<List<BasePlaylist>> saveCategoryPlaylists(
    String categoryId,
    List<BasePlaylist> playlists,
  ) async {
    return await _dataSource.saveCategoryPlaylists(categoryId, playlists);
  }

  FutureOrResult<List<BasePlaylist>> saveAll(
    List<BasePlaylist> playlists,
  ) async {
    final List<BasePlaylist> result = [];

    for (BasePlaylist playlist in playlists) {
      final savingPlaylistResult = await save(playlist);
      if (savingPlaylistResult.isSuccess) {
        result.add(savingPlaylistResult.requireValue);
      }
    }
    return result.asResult;
  }
}
