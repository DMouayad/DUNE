import 'package:flutter_test/flutter_test.dart';
import 'package:dune/domain/audio/facades/music_facade.dart';
import 'package:dune/domain/audio/factories/explore_music_collection_factory.dart';
import 'package:dune/support/enums/music_source.dart';
import 'package:dune/support/utils/error/app_error.dart';
import 'package:dune/support/utils/result/result.dart';

import '../../../utils/fake_repositories/fake_explore_music_repository.dart';

void main() {
  group('test fetched items are returned from the provided [MusicSource]', () {
    late final ExploreMusicFacade facade;
    final youtubeFactory =
        ExploreMusicCollectionFactory().setYoutubeAsSource().setItemsCount(10);
    final spotifyFactory = ExploreMusicCollectionFactory()
        .setMusicSource(MusicSource.spotify)
        .setItemsCount(10);

    setUpAll(() {
      facade = ExploreMusicFacade(
        youtubeRepository: FakeExploreMusicRepository(
          getItemsByMoodsAndGenresResult:
              youtubeFactory.createCount(10).asResult,
          getMainItemsResult: youtubeFactory.createCount(10).asResult,
        ),
        spotifyRepository: FakeExploreMusicRepository(
          getItemsByMoodsAndGenresResult:
              spotifyFactory.createCount(10).asResult,
          getMainItemsResult: spotifyFactory.createCount(10).asResult,
        ),
      );
    });
    test(
        'it returns explore items from YouTube when specified source is [MusicSource.youtube]',
        () async {
      final results =
          await facade.getExploreMusicMainItems(MusicSource.youtube);

      expect(results.requireValue.every((e) => e.source == MusicSource.youtube),
          true);
    });
    test(
        'it returns explore items from Spotify when specified source is [MusicSource.spotify]',
        () async {
      final results =
          await facade.getExploreMusicMainItems(MusicSource.spotify);
      expect(
        results.requireValue.every((e) => e.source == MusicSource.spotify),
        true,
      );
    });
  });
  group('in case of an error, a [FailureResult] should be returned', () {
    late final ExploreMusicFacade facade;
    final failureResult = FailureResult<List<FakeExploreMusicCollection>,
        AppError>.withAppException(
      AppException.cannotConnectToServer,
    );
    final failureResultFuture =
        Future.delayed(const Duration(milliseconds: 100), () => failureResult);
    setUpAll(() {
      facade = ExploreMusicFacade(
        youtubeRepository: FakeExploreMusicRepository(
          getItemsByMoodsAndGenresResult: failureResultFuture,
          getMainItemsResult: failureResultFuture,
        ),
      );
    });
    test(
        '[failureResult] should be returned when calling'
        '[getExploreMusicItemsByMoodsAndGenres]', () async {
      final result = await facade
          .getExploreMusicItemsByMoodsAndGenres(MusicSource.youtube);
      expectLater(result.isFailure, true);
      expectLater(
        result.asFailure.error.appException,
        failureResult.error.appException,
      );
    });
    test(
        '[failureResult] should be returned when calling'
        '[getExploreMusicMainItems]', () async {
      final result = await facade.getExploreMusicMainItems(MusicSource.youtube);
      expectLater(result.isFailure, true);
      expectLater(
        result.asFailure.error.appException,
        failureResult.error.appException,
      );
    });
  });
}
