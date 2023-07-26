import 'package:dune/domain/audio/facades/music_facade.dart';
import 'package:dune/support/enums/music_source.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//
import 'package:dune/domain/audio/base_models/base_playlist.dart';

class PlaylistController extends StateNotifier<AsyncValue<BasePlaylist?>> {
  PlaylistController() : super(const AsyncData(null));

  PlaylistFacade get _playlistData => MusicFacade.playlists;

  Future<void> get(String playlistId, MusicSource musicSource) async {
    // if (state.valueOrNull?.id == playlistId) return;

    state = const AsyncLoading<BasePlaylist?>()
        .copyWithPrevious(AsyncData(state.valueOrNull));

    (await _playlistData.getCachedPlaylistInfo(playlistId)).foldAsync(
      onSuccess: (playlist) async {
        print('fetched local playlist');
        if (playlist != null) {
          print('playlist found in local storage');
          state = const AsyncLoading<BasePlaylist?>()
              .copyWithPrevious(AsyncValue.data(playlist));
        }
        (await _playlistData.getPlaylist(playlistId, musicSource)).fold(
          onSuccess: (playlist) {
            print('fetched playlist from remote datasource');
            if (playlist?.hasSameTracksAsOther(state.valueOrNull) ?? true) {
              state = AsyncData(state.value);
            } else {
              print("playlist has new value");
              state = AsyncData(playlist);
            }
          },
          onFailure: (error) async {
            if (state.hasValue) {
              state = AsyncValue<BasePlaylist?>.error(error, error.stackTrace)
                  .copyWithPrevious(AsyncData(state.requireValue));
            } else {
              state = AsyncValue<BasePlaylist>.error(error, error.stackTrace);
            }
          },
        );
      },
      onFailure: (error) async {
        state = AsyncValue.error(error, error.stackTrace);
      },
    );
  }
}
