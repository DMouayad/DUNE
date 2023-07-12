import 'package:dune/domain/audio/facades/music_facade.dart';
import 'package:dune/domain/audio/base_models/base_explore_music_collection.dart';
import 'package:dune/support/enums/music_source.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ExploreMusicController
    extends StateNotifier<AsyncValue<ExploreMusicState>> {
  ExploreMusicController() : super(const AsyncValue.data(ExploreMusicState()));

  Future<void> loadHomeCollections(MusicSource source) async {
    state =
        const AsyncValue<ExploreMusicState>.loading().copyWithPrevious(state);

    state =
        (await MusicFacade.exploreMusic.getExploreMusicMainItems(source)).mapTo(
            onSuccess: (collections) {
              if (state.hasValue) {
                return AsyncValue.data(
                  state.requireValue.copyWith(homeCollections: collections),
                );
              } else {
                return AsyncData(
                  ExploreMusicState(homeCollections: collections),
                );
              }
            },
            onFailure: (error) => AsyncValue.error(error, error.stackTrace));
  }

  Future<void> loadMoodsAndGenresCollections(MusicSource source) async {
    state =
        const AsyncValue<ExploreMusicState>.loading().copyWithPrevious(state);

    state = (await MusicFacade.exploreMusic
            .getExploreMusicItemsByMoodsAndGenres(source))
        .mapTo(onSuccess: (collections) {
      return AsyncValue.data(
          state.requireValue.copyWith(moodsAndGenresCollections: collections));
    }, onFailure: (error) {
      return AsyncValue.error(error, error.stackTrace);
    });
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
