import 'package:dune/domain/audio/base_data_sources/base_explore_music_data_source.dart';
import 'package:dune/support/utils/result/result.dart';

import '../base_models/base_explore_music_collection.dart';

base class ExploreMusicRepository {
  final BaseExploreMusicDataSource<BaseExploreMusicCollection>
      _exploreMusicDataSource;

  List<BaseExploreMusicCollection>? _homeExploreMusicCollections;
  List<BaseExploreMusicCollection>? _moodsAndGenresCollections;

  ExploreMusicRepository(this._exploreMusicDataSource);

  FutureOrResult<List<BaseExploreMusicCollection>>
      getExploreMusicMainItems() async {
    if (_homeExploreMusicCollections != null) {
      return _homeExploreMusicCollections!.asResult;
    }
    final result = (await _exploreMusicDataSource.getMainItems()).fold(
      ifSuccess: (result) => _homeExploreMusicCollections = result,
    );
    return result.flatMapFailure((error) {
      if (_homeExploreMusicCollections != null) {
        return FailureResult.withPreviousValue(
          error,
          _homeExploreMusicCollections!,
        );
      }
      return result;
    });
  }

  FutureOrResult<List<BaseExploreMusicCollection>>
      getExploreMusicItemsByMoodsAndGenres() async {
    if (_moodsAndGenresCollections != null) {
      return _moodsAndGenresCollections!.asResult;
    }
    return (await _exploreMusicDataSource
            .getExploreMusicItemsByMoodsAndGenres())
        .fold(
      ifSuccess: (result) => _moodsAndGenresCollections = result,
    );
  }
}
