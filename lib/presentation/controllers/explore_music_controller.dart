import 'package:dune/domain/audio/facades/music_facade.dart';
import 'package:dune/domain/audio/base_models/base_explore_music_collection.dart';
import 'package:dune/support/enums/music_source.dart';
import 'package:dune/support/utils/result/result.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ExploreMusicController
    extends StateNotifier<AsyncValue<ExploreMusicState>> {
  ExploreMusicController() : super(const AsyncValue.data(ExploreMusicState()));

  Future<void> loadHomeCollections(MusicSource source) async {
    state =
        const AsyncValue<ExploreMusicState>.loading().copyWithPrevious(state);

    (await MusicFacade.exploreMusic.getExploreMusicMainItems(source)).fold(
      onSuccess: (collections) {
        state = AsyncValue.data(
          state.valueOrNull?.copyWith(homeCollections: collections) ??
              ExploreMusicState(homeCollections: collections),
        );
      },
      onFailure: _handleError,
    );
  }

  Future<void> loadMoodsAndGenresCollections(MusicSource source) async {
    state =
        const AsyncValue<ExploreMusicState>.loading().copyWithPrevious(state);
    final dataResult = await MusicFacade.exploreMusic
        .getExploreMusicItemsByMoodsAndGenres(source);
    dataResult.fold(
      onSuccess: (collections) {
        state = AsyncValue.data(
          state.valueOrNull?.copyWith(moodsAndGenresCollections: collections) ??
              ExploreMusicState(moodsAndGenresCollections: collections),
        );
      },
      onFailure: _handleError,
    );
  }

  void _handleError(AppError error) {
    final errorState =
        AsyncValue<ExploreMusicState>.error(error, error.stackTrace);
    if (state.hasValue) {
      state = errorState.copyWithPrevious(AsyncData(state.requireValue));
    } else {
      state = errorState;
    }
  }

  Future<void> fetchAll(MusicSource musicSource) async {
    await loadHomeCollections(musicSource);
    await loadMoodsAndGenresCollections(musicSource);
  }
}

final class ExploreMusicState {
  final List<BaseExploreMusicCollection> homeCollections;
  final List<BaseExploreMusicCollection> moodsAndGenresCollections;

  const ExploreMusicState({
    this.homeCollections = const [],
    this.moodsAndGenresCollections = const [],
  });

  ExploreMusicState copyWith({
    List<BaseExploreMusicCollection>? homeCollections,
    List<BaseExploreMusicCollection>? moodsAndGenresCollections,
  }) {
    return ExploreMusicState(
      homeCollections: homeCollections ?? this.homeCollections,
      moodsAndGenresCollections:
          moodsAndGenresCollections ?? this.moodsAndGenresCollections,
    );
  }
}
