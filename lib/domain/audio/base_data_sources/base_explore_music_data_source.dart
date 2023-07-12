import 'package:dune/domain/audio/base_models/base_explore_music_collection.dart';
import 'package:dune/support/utils/result/result.dart';

abstract class BaseExploreMusicDataSource<
    T extends BaseExploreMusicCollection> {
  const BaseExploreMusicDataSource();

  FutureOrResult<List<T>> getMainItems();

  FutureOrResult<List<T>> getExploreMusicItemsByMoodsAndGenres();
}
