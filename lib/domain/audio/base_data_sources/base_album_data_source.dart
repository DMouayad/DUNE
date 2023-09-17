import 'package:dune/domain/audio/base_models/base_album.dart';
import 'package:dune/domain/audio/traits/finds_by_music_source.dart';
import 'package:dune/support/utils/result/result.dart';

abstract class BaseAlbumDataSource<T extends BaseAlbum> {
  const BaseAlbumDataSource();

  FutureOrResult<T?> find(String artistId);

  FutureOrResult<List<T>> getWhereIds(List<String> ids);
}

abstract class BaseSavableAlbumDataSource<T extends BaseAlbum>
    extends BaseAlbumDataSource<T> with FindsByMusicSource<T> {
  const BaseSavableAlbumDataSource();

  FutureOrResult<T> save(T artist);

  /// Deletes any [BaseAlbum] if its `id` in the given [ids].
  FutureOrResult<List<T>> removeAllById(List<String> ids);
}
