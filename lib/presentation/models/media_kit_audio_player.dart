import 'package:dune/domain/audio/base_models/base_album.dart';
import 'package:dune/domain/audio/base_models/base_artist.dart';
import 'package:dune/domain/audio/base_models/base_track.dart';
import 'package:dune/presentation/models/player_state.dart';
import 'package:dune/presentation/utils/listening_history_helper.dart';
import 'package:dune/support/enums/audio_streaming_quality.dart';
import 'package:dune/support/logger_service.dart';
import 'package:dune/support/extensions/extensions.dart';
import 'package:media_kit/media_kit.dart' as mediakit;

import 'audio_player.dart';

final class MediaKitAudioPlayer extends AudioPlayer {
  final mediakit.Player _player;
  final AudioStreamingQuality Function() getStreamingQuality;
  final double Function() getUserSpecifiedVolumeStep;

  MediaKitAudioPlayer(
    this._player,
    PlayerState initialState,
    ListeningHistoryHelper listeningHistoryHelper,
    this.getStreamingQuality,
    this.getUserSpecifiedVolumeStep,
  ) : super(
          initialState,
          listeningHistoryHelper,
          _player.stream.playing,
          _player.stream.completed,
          _player.stream.position,
          _player.stream.duration,
          _player.stream.volume,
          _player.stream.rate,
          _player.stream.pitch,
          _player.stream.buffering,
          _player.stream.buffer,
          _player.stream.playlistMode.map(
            (event) => switch (event) {
              mediakit.PlaylistMode.none => RepeatMode.none,
              mediakit.PlaylistMode.single => RepeatMode.oneTimeForCurrentTrack,
              mediakit.PlaylistMode.loop => RepeatMode.loopCurrentPlaylist,
            },
          ),
          null,
          _player.stream.audioBitrate,
        );

  @override
  Future<void> toggleShuffle({bool? enabled}) async {
    await _player.setShuffle(enabled ?? !state.shuffle);
    super.toggleShuffle(enabled: enabled);
  }

  @override
  void seek(Duration position) async {
    if (state.currentTrack == null) return;
    _player.seek(position).then((_) => super.seek(position));
  }

  @override
  void setVolume(double value) {
    super.setVolume(value);
    _player.setVolume(value);
  }

  @override
  double getVolumeStep() => getUserSpecifiedVolumeStep();

  @override
  Future<void> jumpToTrackInPlaylist(BaseTrack track) async {
    final mediakit.Media? trackMediaInCurrentPlaylist =
        _getTrackMediaFromPlayerPlaylist(track);

    await _player.jump(trackMediaInCurrentPlaylist?.extras?['index']);
    setCurrentTrack(track);
  }

  @override
  void onPlayNext() => _player.next();

  @override
  void toggleRepeat() {
    super.toggleRepeat();

    _player.setPlaylistMode(switch (state.repeat) {
      RepeatMode.none => mediakit.PlaylistMode.none,
      RepeatMode.oneTimeForCurrentTrack => mediakit.PlaylistMode.single,
      RepeatMode.loopCurrentPlaylist => mediakit.PlaylistMode.loop,
    });
  }

  @override
  void onPlayPrevious() => _player.previous();

  @override
  void start() => _player.play();

  @override
  void pause() => _player.pause();

  @override
  void startOrPause() => _player.playOrPause();

  @override
  AudioStreamingQuality get streamingQuality => getStreamingQuality();

  @override
  bool trackExistsInCurrentPlaylist(BaseTrack<BaseAlbum, BaseArtist> track) {
    // check if [track] media has already been added to the playlist
    final mediakit.Media? trackMediaInCurrentPlaylist =
        _getTrackMediaFromPlayerPlaylist(track);
    return trackMediaInCurrentPlaylist != null;
  }

  mediakit.Media? _getTrackMediaFromPlayerPlaylist(
      BaseTrack<BaseAlbum, BaseArtist> track) {
    return _player.state.playlist.medias
        .firstWhereOrNull((media) => media.extras?['trackId'] == track.id);
  }

  @override
  void decreaseVolume() {
    super.decreaseVolume();
    _player.setVolume(state.volume);
  }

  @override
  void increaseVolume() {
    super.increaseVolume();
    _player.setVolume(state.volume);
  }

  @override
  Future<void> addTrackToPlayerPlaylist(
    String trackUrl,
    BaseTrack<BaseAlbum, BaseArtist> track,
  ) async {
    try {
      if (_player.state.playlist.medias.isEmpty) {
        final trackMedia = mediakit.Media(
          trackUrl,
          extras: {'trackId': track.id, 'index': 0},
        );
        await _player.open(mediakit.Playlist([trackMedia], index: 0));
        setCurrentTrack(track);
      } else {
        final trackMedia = mediakit.Media(trackUrl, extras: {
          'trackId': track.id,
          'index': _player.state.playlist.index + 1
        });
        await _player.add(trackMedia);
        setCurrentTrack(track);
        await _player.next();
        await _player.play();
      }
    } on Exception catch (e) {
      Log.e(e);
    }
  }

  @override
  Future<void> disposePlayer() async {
    await _player.dispose();
    super.disposePlayer();
  }
}
