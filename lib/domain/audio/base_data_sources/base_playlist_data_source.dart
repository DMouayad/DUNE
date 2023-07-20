import 'package:dune/domain/audio/base_models/base_playlist.dart';
import 'package:dune/support/utils/result/result.dart';

abstract class BasePlaylistDataSource<T extends BasePlaylist> {
  const BasePlaylistDataSource();

  FutureOrResult<T?> find(String playlistId);

  FutureOrResult<List<T>?> getCategoryPlaylists(String categoryId);
}

abstract class BaseSavablePlaylistDataSource<T extends BasePlaylist>
    extends BasePlaylistDataSource<T> {
  FutureOrResult<T> save(T playlist);

  FutureOrResult<List<T>> saveCategoryPlaylists(
    String categoryId,
    List<T> playlists,
  );
}
