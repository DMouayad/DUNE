import 'package:dune/domain/audio/base_models/base_artist.dart';
import 'package:dune/support/utils/result/result.dart';

abstract class BaseArtistDataSource<T extends BaseArtist> {
  const BaseArtistDataSource();

  FutureOrResult<T?> find(String artistId);

  FutureOrResult<List<T>> getWhereIds(List<String> ids);

  FutureOrResult<T> save(T artist);
}
