import 'package:dune/domain/audio/base_data_sources/base_playlist_data_source.dart';
import 'package:dune/domain/audio/base_models/base_playlist.dart';
import 'package:dune/support/utils/result/result.dart';

abstract base class PlaylistRepository<T extends BasePlaylistDataSource>
    with PlaylistUseCases {
  final T _dataSource;

  PlaylistRepository(this._dataSource);

  @override
  FutureOrResult<BasePlaylist?> getById(String id) async {
    return await _dataSource.find(id);
  }

  @override
  FutureOrResult<List<BasePlaylist>?> getCategoryPlaylists(
    String categoryId,
  ) async {
    return await _dataSource.getCategoryPlaylists(categoryId);
  }
}

mixin PlaylistUseCases {
  FutureOrResult<BasePlaylist?> getById(String id);

  FutureOrResult<List<BasePlaylist>?> getCategoryPlaylists(
    String categoryId,
  );
}

abstract base class SavablePlaylistRepository<
    T extends BaseSavablePlaylistDataSource> extends PlaylistRepository<T> {
  SavablePlaylistRepository(super.dataSource);

  FutureOrResult<BasePlaylist> save(BasePlaylist playlist);

  FutureOrResult<List<BasePlaylist>> saveCategoryPlaylists(
    String categoryId,
    List<BasePlaylist> playlists,
  ) async {
    return await _dataSource.saveCategoryPlaylists(categoryId, playlists);
  }
}
