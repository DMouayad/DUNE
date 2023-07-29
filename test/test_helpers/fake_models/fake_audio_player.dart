import 'dart:async';

import 'package:dune/domain/audio/base_models/audio_info_set.dart';
import 'package:dune/domain/audio/base_models/base_album.dart';
import 'package:dune/domain/audio/base_models/base_artist.dart';
import 'package:dune/domain/audio/base_models/base_track.dart';
import 'package:dune/domain/audio/base_models/track_audio_info.dart';
import 'package:dune/presentation/models/audio_player.dart';
import 'package:dune/presentation/models/player_state.dart';
import 'package:dune/presentation/utils/listening_history_helper.dart';
import 'package:dune/support/enums/music_source.dart';
import 'package:dune/support/extensions/extensions.dart';

class FakeAudioPlayerStreams {
  /// Whether playing or not.
  Stream<bool> get playing => playingStreamController.stream;
  late final StreamController<bool> playingStreamController;

  Stream<bool> get completed => completedStreamController.stream;
  late final StreamController<bool> completedStreamController;

  /// Current playback position.
  Stream<Duration> get position => positionStreamController.stream;
  late final StreamController<Duration> positionStreamController;

  /// Current playback duration.
  Stream<Duration> get duration => durationStreamController.stream;
  late final StreamController<Duration> durationStreamController;

  /// Current volume.
  Stream<double> get volume => volumeStreamController.stream;
  late final StreamController<double> volumeStreamController;

  /// Current playback rate.
  Stream<double> get rate => rateStreamController.stream;
  late final StreamController<double> rateStreamController;

  /// Current pitch.
  Stream<double> get pitch => pitchStreamController.stream;
  late final StreamController<double> pitchStreamController;

  /// Whether buffering or not.
  Stream<bool> get buffering => bufferingStreamController.stream;
  late final StreamController<bool> bufferingStreamController;

  /// Current buffer position.
  /// This indicates how much of the stream has been decoded & cached by the demuxer.
  Stream<Duration> get buffer => bufferStreamController.stream;
  late final StreamController<Duration> bufferStreamController;

  /// Current playlist repeat mode.
  Stream<RepeatMode> get repeatMode => repeatModeStreamController.stream;
  late final StreamController<RepeatMode> repeatModeStreamController;

  FakeAudioPlayerStreams() {
    playingStreamController = StreamController.broadcast(sync: true);
    completedStreamController = StreamController.broadcast(sync: true);
    positionStreamController = StreamController.broadcast(sync: true);
    durationStreamController = StreamController.broadcast(sync: true);
    volumeStreamController = StreamController.broadcast(sync: true);
    rateStreamController = StreamController.broadcast(sync: true);
    pitchStreamController = StreamController.broadcast(sync: true);
    bufferingStreamController = StreamController.broadcast(sync: true);
    bufferStreamController = StreamController.broadcast(sync: true);
    repeatModeStreamController = StreamController.broadcast(sync: true);
  }

  Future<void> dispose() async {
    await playingStreamController.close();
    await completedStreamController.close();
    await positionStreamController.close();
    await durationStreamController.close();
    await volumeStreamController.close();
    await rateStreamController.close();
    await pitchStreamController.close();
    await bufferingStreamController.close();
    await bufferStreamController.close();
    await repeatModeStreamController.close();
  }
}

class FakeAudioPlayer extends AudioPlayer {
  final FakeAudioPlayerStreams _streams;
  final List<BaseTrack> _playerPlaylist = [];
  int? _currentTrackIndex;

  FakeAudioPlayer(this._streams, ListeningHistoryHelper listeningHistoryHelper)
      : super(
          PlayerState.initial(),
          listeningHistoryHelper,
          _streams.playing,
          _streams.completed,
          _streams.position,
          _streams.duration,
          _streams.volume,
          _streams.rate,
          _streams.pitch,
          _streams.buffering,
          _streams.buffer,
          _streams.repeatMode,
        );

  @override
  Future<AudioInfoSet?> getTrackAudioInfoSet(
    BaseTrack track,
    MusicSource? musicSource,
  ) async {
    return track.audioInfoSet;
  }

  @override
  Future<void> addTrackToPlayerPlaylist(
    TrackAudioInfo trackAudioInfo,
    BaseTrack track,
  ) async {
    if (_playerPlaylist.isEmpty || _currentTrackIndex == null) {
      _currentTrackIndex = 0;
    } else {
      _currentTrackIndex = _currentTrackIndex! + 1;
    }
    _playerPlaylist.add(track);
    setCurrentTrack(track);
    start();
  }

  @override
  double getVolumeStep() => 8;

  @override
  Future<void> jumpToTrackInPlaylist(BaseTrack track) async {
    _currentTrackIndex =
        _playerPlaylist.indexWhere((element) => element.id == track.id);
    setCurrentTrack(track);
    startOrPause();
  }

  @override
  void onPlayNext() {
    final currentTrackIsLast = _currentTrackIndex == _playerPlaylist.length - 1;
    if (currentTrackIsLast || _playerPlaylist.isEmpty) {
      return;
    }
    _currentTrackIndex = (_currentTrackIndex ?? 0) + 1;
    setCurrentTrack(_playerPlaylist[_currentTrackIndex!]);
    start();
  }

  @override
  void onPlayPrevious() {
    final currentTrackIsFirst = _currentTrackIndex == 0;
    if (currentTrackIsFirst || _playerPlaylist.isEmpty) {
      return;
    }
    _currentTrackIndex = (_currentTrackIndex ?? 1) - 1;
    setCurrentTrack(_playerPlaylist[_currentTrackIndex!]);
    start();
  }

  @override
  void pause() => _streams.playingStreamController.add(false);

  @override
  void start() => _streams.playingStreamController.add(true);

  @override
  void startOrPause() => state.isPlaying ? pause() : start();

  @override
  bool trackExistsInCurrentPlaylist(BaseTrack<BaseAlbum, BaseArtist> track) {
    return _playerPlaylist.containsWhere((e) => e.id == track.id);
  }

  @override
  Future<void> disposePlayer() async {
    await _streams.dispose();
    return super.disposePlayer();
  }
}
