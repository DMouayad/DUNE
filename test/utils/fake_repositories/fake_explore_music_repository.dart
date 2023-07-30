import 'package:dune/domain/audio/base_data_sources/base_explore_music_data_source.dart';
import 'package:dune/domain/audio/factories/explore_music_collection_factory.dart';
import 'package:dune/domain/audio/repositories/explore_music_repository.dart';
import 'package:dune/support/utils/result/result.dart';

final class FakeExploreMusicRepository extends ExploreMusicRepository {
  FakeExploreMusicRepository({
    required FutureOrResult<List<FakeExploreMusicCollection>>
        getItemsByMoodsAndGenresResult,
    required FutureOrResult<List<FakeExploreMusicCollection>>
        getMainItemsResult,
  }) : super(
          FakeExploreMusicDateSource(
              getItemsByMoodsAndGenresResult, getMainItemsResult),
        );
}

final class FakeExploreMusicDateSource
    extends BaseExploreMusicDataSource<FakeExploreMusicCollection> {
  FakeExploreMusicDateSource(
    this.getItemsByMoodsAndGenresResult,
    this.getMainItemsResult,
  );

  final FutureOrResult<List<FakeExploreMusicCollection>>
      getItemsByMoodsAndGenresResult;
  final FutureOrResult<List<FakeExploreMusicCollection>> getMainItemsResult;

  @override
  FutureOrResult<List<FakeExploreMusicCollection>>
      getExploreMusicItemsByMoodsAndGenres() async {
    return await getItemsByMoodsAndGenresResult;
  }

  @override
  FutureOrResult<List<FakeExploreMusicCollection>> getMainItems() async {
    return await getMainItemsResult;
  }
}
