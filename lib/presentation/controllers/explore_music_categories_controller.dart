import 'package:collection/collection.dart';
import 'package:dune/domain/audio/facades/music_facade.dart';
import 'package:dune/support/enums/music_source.dart';
import 'package:dune/support/logger_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//
import 'package:dune/domain/audio/base_models/base_playlist.dart';

typedef ExploreMusicCategoriesControllerState
    = AsyncValue<({String? categoryId, List<BasePlaylist> playlists})>;

const initialState = ExploreMusicCategoriesControllerState.data(
    (categoryId: null, playlists: []));

class ExploreMusicCategoriesController
    extends StateNotifier<ExploreMusicCategoriesControllerState> {
  ExploreMusicCategoriesController() : super(initialState);

  Future<void> get(String categoryId, MusicSource musicSource) async {
    state = const ExploreMusicCategoriesControllerState.loading()
        .copyWithPrevious(state.hasValue && state.value != null
            ? AsyncData(state.value!)
            : initialState);
    (await MusicFacade.playlists.getCachedCategoryPlaylists(categoryId))
        .foldAsync(
      ifSuccess: (playlists) async {
        if (playlists != null) {
          print('category playlists were found in local storage');
          state = const ExploreMusicCategoriesControllerState.loading()
              .copyWithPrevious(
            ExploreMusicCategoriesControllerState.data(
                (categoryId: categoryId, playlists: playlists)),
          );
        }
        (await MusicFacade.playlists
                .getCategoryPlaylists(categoryId, musicSource))
            .fold(
          ifSuccess: (playlistsFromRemote) {
            print(
                'fetched playlists from remote datasource ${playlistsFromRemote?.runtimeType}');
            if (playlistsFromRemote != null &&
                _playlistsHaveDifferentTracks(
                  playlistsFromRemote,
                  state.valueOrNull?.playlists,
                )) {
              print("playlists has new value");
              state = AsyncData(
                  (categoryId: categoryId, playlists: playlistsFromRemote));
            } else {
              state = AsyncData(state.requireValue);
            }
          },
          ifFailure: (error) async {
            Log.e(error);
            if (state.hasValue) {
              state = ExploreMusicCategoriesControllerState.error(
                      error, error.stackTrace)
                  .copyWithPrevious(AsyncData(state.requireValue));
            } else {
              state = ExploreMusicCategoriesControllerState.error(
                  error, error.stackTrace);
            }
          },
        );
      },
      ifFailure: (error) async {
        state = AsyncValue.error(error, error.stackTrace);
      },
    );
  }

  bool _playlistsHaveDifferentTracks(
    List<BasePlaylist>? first,
    List<BasePlaylist>? second,
  ) {
    final firstTracksIds = first
        ?.map((e) => e.tracks.map((e) => e.id))
        .expand((element) => element)
        .toList();
    final secondTracksIds = second
        ?.map((e) => e.tracks.map((e) => e.id))
        .expand((element) => element)
        .toList();
    return !const ListEquality().equals(firstTracksIds, secondTracksIds);
  }
}
