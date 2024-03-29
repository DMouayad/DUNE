import 'dart:async';

import 'package:dune/domain/audio/base_models/audio_info_set.dart';
import 'package:dune/domain/audio/base_models/base_playlist.dart';
import 'package:dune/domain/audio/base_models/base_track.dart';
import 'package:dune/domain/audio/base_models/track_audio_info.dart';
import 'package:dune/domain/audio/facades/music_facade.dart';
import 'package:dune/presentation/utils/listening_history_helper.dart';
import 'package:dune/support/enums/audio_streaming_quality.dart';
import 'package:dune/support/enums/music_source.dart';
import 'package:dune/support/logger_service.dart';
import 'package:dune/support/extensions/extensions.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

part 'player_state.dart';

abstract class AudioPlayer {
  late PlayerState _currentState;

  PlayerState get state => _currentState;

  Stream<PlayerState> get stateStream => _stateStreamController.stream;
  late final StreamController<PlayerState> _stateStreamController;
  late final AudioPlayerStreams streams;
  late final StreamSubscription<PlayerState> _statesSub;
  late final ListeningHistoryHelper _listeningHistoryHelper;

  AudioPlayer(
    PlayerState initialState,
    ListeningHistoryHelper listeningHistoryHelper,
    Stream<bool> playing,
    Stream<bool> completed,
    Stream<Duration> position,
    Stream<Duration> duration,
    Stream<double> volume,
    Stream<double> rate,
    Stream<double> pitch,
    Stream<bool> buffering,
    Stream<Duration> buffer,
    Stream<RepeatMode> repeatMode,
  ) {
    _currentState = initialState;
    _listeningHistoryHelper = listeningHistoryHelper;
    streams = AudioPlayerStreams(
      playing,
      completed,
      position,
      duration,
      volume,
      rate,
      pitch,
      buffering,
      buffer,
      repeatMode,
    );
    _stateStreamController = StreamController.broadcast(sync: true);
    _statesSub = _stateStreamController.stream.listen((event) {
      _currentState = event;
    });
    setVolume(initialState.volume);

    streams.playing.listen((playing) {
      if (playing && state.currentTrack == null) {
        return;
      }
      _listeningHistoryHelper.onPlayingChanged(playing, state);
      _stateStreamController.add(state.copyWith(isPlaying: playing));
    });

    streams.buffer.listen((value) {
      _stateStreamController.add(state.copyWith(buffer: value));
    });

    streams.buffering.listen((value) {
      Log.i("buffering: $value");
      _stateStreamController
          .add(state.copyWith(isBuffering: value, isPlaying: !value));
      _listeningHistoryHelper.onBufferingStateChanged(value, state);
    });

    streams.completed.listen((value) {
      _stateStreamController.add(
        state.copyWith(
            isCompleted: value, isPlaying: state.isPlaying ? !value : null),
      );

      Log.i("completed: $value");
      if (state.repeat == RepeatMode.oneTimeForCurrentTrack) {
        // prev();
        // startOrPause();
      }
    });

    streams.position.listen((value) {
      _stateStreamController.add(state.copyWith(position: value));
    });
    streams.duration.listen((value) {
      _stateStreamController.add(state.copyWith(duration: value));
    });
    streams.volume.listen((value) {
      _stateStreamController
          .add(state.copyWith(volume: value, isMuted: value == 0.0));
    });
  }

  void start();

  void pause();

  void startOrPause();

  void next() {
    if (state.currentPlaylist != null) {
      _playNextTrackInPlaylist();
    } else {
      onPlayNext();
    }
  }

  void _playNextTrackInPlaylist() {
    final isNotLastTrack = state.playlistCurrentTrackIndex !=
        state.currentPlaylist!.tracks.length - 1;

    if (isNotLastTrack && state.currentPlaylist!.tracks.isNotEmpty) {
      final nextTrackInPlaylistIndex = state.playlistCurrentTrackIndex! + 1;

      _playTrack(
        state.currentPlaylist!.tracks.elementAt(nextTrackInPlaylistIndex),
      );
    }
  }

  void onPlayNext();

  void onPlayPrevious();

  void prev() {
    if (state.currentPlaylist != null) {
      _playPrevTrackInPlaylist();
    } else {
      onPlayPrevious();
    }
  }

  void _playPrevTrackInPlaylist() {
    final isNotFirstTrack = state.playlistCurrentTrackIndex != 0;
    if (isNotFirstTrack && state.currentPlaylist!.tracks.isNotEmpty) {
      final previousTrackInPlaylistIndex = state.playlistCurrentTrackIndex! - 1;
      _playTrack(
        state.currentPlaylist!.tracks.elementAt(previousTrackInPlaylistIndex),
      );
    }
  }

  @mustCallSuper
  void setVolume(double value) {
    _stateStreamController.add(state.copyWith(volume: value));
  }

  double getVolumeStep();

  @mustCallSuper
  void decreaseVolume() {
    _stateStreamController
        .add(state.copyWith(volume: state.volume - getVolumeStep()));
  }

  @mustCallSuper
  void increaseVolume() {
    _stateStreamController
        .add(state.copyWith(volume: state.volume + getVolumeStep()));
  }

  @mustCallSuper
  void toggleRepeat() {
    final newRepeatMode = RepeatMode.values.elementAt(
      state.repeat.index == RepeatMode.values.last.index
          ? 0
          : state.repeat.index + 1,
    );
    _stateStreamController.add(state.copyWith(repeat: newRepeatMode));
  }

  void toggleMute() {
    state.isMuted ? setVolume(50.0) : setVolume(0.0);
  }

  void updateCurrentTrackIndex(String? trackId) {
    if (state.playerTracks.isEmpty) {
      _stateStreamController.add(state.copyWith(playerCurrentTrackIndex: null));
    } else {
      final trackIndex = state.playerTracks.indexWhere((e) => e.id == trackId);
      if (trackIndex != -1) {
        _stateStreamController
            .add(state.copyWith(playerCurrentTrackIndex: trackIndex));
      }
      if (state.currentPlaylistNotNull) {
        _updatePlaylistCurrentTrackIndex(trackId);
      }
    }
  }

  void _updatePlaylistCurrentTrackIndex(String? trackId) {
    final trackIndexInPlaylist =
        state.currentPlaylist!.tracks.indexWhere((e) => e.id == trackId);
    if (trackIndexInPlaylist != -1) {
      _stateStreamController.add(
        state.copyWith(playlistCurrentTrackIndex: trackIndexInPlaylist),
      );
    }
  }

  @mustCallSuper
  void toggleShuffle({bool? enabled}) {
    _stateStreamController
        .add(state.copyWith(shuffle: enabled ?? !state.shuffle));
  }

  @mustCallSuper
  void seek(Duration position) async {
    if (state.currentTrack == null) return;
    _stateStreamController.add(state.copyWith(position: position));
  }

  Future<void> playPlaylist(
    BasePlaylist playlist, {
    BaseTrack? track,
    bool shuffle = false,
    MusicSource? musicSource,
  }) async {
    final (BaseTrack trackToPlay, int index) trackData = shuffle
        ? playlist.tracks.randomElementWithIndex()
        : track != null
            ? (track, playlist.tracks.indexOf(track))
            : (playlist.tracks.first, 0);

    _stateStreamController.add(state.copyWith(
      currentPlaylist:
          state.currentPlaylist?.id != playlist.id ? playlist : null,
      playlistCurrentTrackIndex: trackData.$2,
    ));

    _playTrack(trackData.$1, musicSource: musicSource);
    toggleShuffle(enabled: shuffle);
  }

  Future<void> playSingleTrack(
    BaseTrack track, {
    MusicSource? musicSource,
  }) async {
    _stateStreamController.add(state.copyWith(hasPlaylist: false));
    await _playTrack(track, musicSource: musicSource);
  }

  Future<void> _playTrack(BaseTrack track, {MusicSource? musicSource}) async {
    if (state.currentTrack?.id == track.id) {
      startOrPause();
      return;
    }
    if (state.isPlaying) {
      // pause current playing track to load the new one
      pause();
    }
    _stateStreamController.add(state.copyWith(isLoading: true));

    if (trackExistsInCurrentPlaylist(track)) {
      await jumpToTrack(track);
    } else {
      // or else add the track to player playlist
      final AudioInfoSet? audioInfoSet =
          await getTrackAudioInfoSet(track, musicSource);
      final trackAudio = audioInfoSet?.whereQuality(
        state.streamingQuality,
        musicSource ?? track.source,
      );
      if (trackAudio != null) {
        await addTrackToPlayerPlaylist(
            trackAudio, track.copyWith(audioInfoSet: audioInfoSet));
        _listeningHistoryHelper.addPlaylistToListeningHistory(state);
      }
    }
    if (state.isLoading) {
      _stateStreamController.add(state.copyWith(isLoading: false));
    }
  }

  bool trackExistsInCurrentPlaylist(BaseTrack track);

  Future<void> jumpToTrack(BaseTrack track);

  @mustCallSuper
  Future<void> addTrackToPlayerPlaylist(
    TrackAudioInfo trackAudioInfo,
    BaseTrack track,
  ) async {
    final newPlayerTracks = {...state.playerTracks, track}.toList();
    _stateStreamController.add(state.copyWith(playerTracks: newPlayerTracks));
  }

  Future<AudioInfoSet?> getTrackAudioInfoSet(
    BaseTrack track,
    MusicSource? musicSource,
  ) async {
    return (await MusicFacade.tracks.getTrackAudioInfo(
      track,
      musicSource: musicSource,
    ))
        .mapTo(
      onSuccess: (audioInfoSet) {
        return audioInfoSet;
      },
      onFailure: (error) {
        Log.e(error);
        return null;
      },
    );
  }

  @mustCallSuper
  Future<void> disposePlayer() async {
    _statesSub.cancel();
  }

  void setAudioStreamingQuality(AudioStreamingQuality value) {
    _stateStreamController.add(state.copyWith(streamingQuality: value));
  }
}

class AudioPlayerStreams {
  /// Whether playing or not.
  final Stream<bool> playing;

  final Stream<bool> completed;

  /// Current playback position.
  final Stream<Duration> position;

  /// Current playback duration.
  final Stream<Duration> duration;

  /// Current volume.
  final Stream<double> volume;

  /// Current playback rate.
  final Stream<double> rate;

  /// Current pitch.
  final Stream<double> pitch;

  /// Whether buffering or not.
  final Stream<bool> buffering;

  /// Current buffer position.
  /// This indicates how much of the stream has been decoded & cached by the demuxer.
  final Stream<Duration> buffer;

  /// Current playlist repeat mode.
  final Stream<RepeatMode> repeatMode;

  AudioPlayerStreams(
    this.playing,
    this.completed,
    this.position,
    this.duration,
    this.volume,
    this.rate,
    this.pitch,
    this.buffering,
    this.buffer,
    this.repeatMode,
  );
}
