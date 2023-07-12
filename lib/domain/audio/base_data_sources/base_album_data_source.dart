import 'package:dune/domain/audio/base_models/base_album.dart';
import 'package:dune/support/utils/result/result.dart';

abstract class BaseAlbumDataSource<T extends BaseAlbum> {
  const BaseAlbumDataSource();

  FutureOrResult<T?> find(String artistId);

  FutureOrResult<List<T>> getWhereIds(List<String> ids);

  FutureOrResult<T> save(T artist);
}
