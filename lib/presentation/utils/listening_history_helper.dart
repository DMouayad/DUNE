import 'package:dune/domain/audio/base_models/base_playlist.dart';
import 'package:dune/domain/audio/base_models/base_track.dart';

import '../models/player_state.dart';

base class ListeningHistoryHelper {
  String? _lastPlayedTrackId;
  DateTime? _startedListeningToCurrentTrackAt;
  Duration? _lastTrackListeningDuration;

  final void Function(BaseTrack) incrementTodayTrackCompletedListensCount;
  final void Function(BasePlaylist) addPlaylistToTodayListeningHistory;
  final void Function(BaseTrack, Duration)
      addToTodayTrackUncompletedListensDuration;

  ListeningHistoryHelper(
    this.incrementTodayTrackCompletedListensCount,
    this.addPlaylistToTodayListeningHistory,
    this.addToTodayTrackUncompletedListensDuration,
  );

  void saveListeningDuration(PlayerState state) {
    if (_lastTrackListeningDuration != null &&
        _lastTrackListeningDuration! > const Duration(seconds: 5)) {
      final completedOneListen = state.currentTrack!.duration == null
          ? state.isCompleted
          : _lastTrackListeningDuration!.inSeconds >=
              state.currentTrack!.duration!.inSeconds;
      if (completedOneListen) {
        incrementTodayTrackCompletedListensCount(state.currentTrack!);
      } else {
        addToTodayTrackUncompletedListensDuration(
          state.currentTrack!,
          _lastTrackListeningDuration! - const Duration(seconds: 1),
        );
      }
    }
    _lastTrackListeningDuration = null;
  }

  void calculateListeningDuration() {
    _lastTrackListeningDuration ??= Duration.zero;
    _lastTrackListeningDuration = _lastTrackListeningDuration! +
        DateTime.now().difference(_startedListeningToCurrentTrackAt!);
    _startedListeningToCurrentTrackAt = null;
  }

  void onPlayingChanged(bool playing, PlayerState state) {
    if (!playing || state.currentTrack?.id != _lastPlayedTrackId) {
      if (_startedListeningToCurrentTrackAt != null) {
        calculateListeningDuration();
        saveListeningDuration(state);
      }
    }
    if (playing) {
      _lastPlayedTrackId ??= state.currentTrack?.id;
      _startedListeningToCurrentTrackAt ??= DateTime.now();
    }
  }

  void addPlaylistToListeningHistory(PlayerState state) {
    if (state.currentPlaylist?.title != null) {
      addPlaylistToTodayListeningHistory(state.currentPlaylist!);
    }
  }

  void onBufferingStateChanged(bool value, PlayerState state) {
    print("Buffer position: ${state.buffer}");
    print("Current player position: ${state.position}");
    if (state.isBuffering && (state.buffer < state.position)) {
      print("Buffering");
      //  waite 5 sec before saving the record of the last listening session
      calculateListeningDuration();
      final lastPlayedTrackId = _lastPlayedTrackId;
      Future.delayed(const Duration(seconds: 5), () {
        // if the playing did not continue, save the last listening session
        if (!state.isBuffering &&
            (!state.isPlaying || lastPlayedTrackId != _lastPlayedTrackId)) {
          saveListeningDuration(state);
        }
      });
    }
  }
}
