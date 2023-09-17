import 'package:dune/domain/audio/base_models/base_artist.dart';
import 'package:dune/domain/audio/traits/finds_by_music_source.dart';
import 'package:dune/support/utils/result/result.dart';

abstract class BaseArtistDataSource<T extends BaseArtist> {
  const BaseArtistDataSource();

  FutureOrResult<T?> find(String artistId);

  FutureOrResult<List<T>> getWhereIds(List<String> ids);
}

abstract class BaseSavableArtistDataSource<T extends BaseArtist>
    extends BaseArtistDataSource<T> with FindsByMusicSource<T> {
  const BaseSavableArtistDataSource();

  FutureOrResult<T> save(T artist);

  /// Deletes any [BaseArtist] if its `id` in the given [ids].
  FutureOrResult<List<T>> removeAllById(List<String> ids);
}
