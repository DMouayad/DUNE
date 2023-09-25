import 'package:dune/domain/audio/base_models/base_track.dart';
import 'package:dune/domain/audio/base_models/track_audio_info.dart';
import 'package:dune/presentation/utils/listening_history_helper.dart';
import 'package:dune/support/logger_service.dart';
import 'package:dune/support/extensions/extensions.dart';
import 'package:media_kit/media_kit.dart' as mediakit;

import '../../../../domain/audio/services/audio_player.dart';

final class MediaKitAudioPlayer extends AudioPlayer {
  final mediakit.Player _player;
  final double Function() getUserSpecifiedVolumeStep;

  MediaKitAudioPlayer(
    this._player,
    ListeningHistoryHelper listeningHistoryHelper,
    this.getUserSpecifiedVolumeStep,
  ) : super(
          PlayerState.initial(),
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
        ) {
    _player.stream.playlist.listen((event) {
      // get the currently playing media
      final currentPlayingMedia = event.medias.elementAt(event.index);
      updateCurrentTrackIndex(currentPlayingMedia.extras?['trackId']);
    });
  }

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
  Future<void> jumpToTrack(BaseTrack track) async {
    final mediakit.Media? trackMediaInCurrentPlaylist =
        _getTrackMediaFromPlayerPlaylist(track);

    await _player.jump(trackMediaInCurrentPlaylist?.extras?['index']);
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
  bool trackExistsInCurrentPlaylist(BaseTrack track) {
    // check if [track] media has already been added to the playlist
    final mediakit.Media? trackMediaInCurrentPlaylist =
        _getTrackMediaFromPlayerPlaylist(track);
    return trackMediaInCurrentPlaylist != null;
  }

  mediakit.Media? _getTrackMediaFromPlayerPlaylist(BaseTrack track) {
    return _player.state.playlist.medias
        .firstWhereOrNull((media) => media.extras?['trackId'] == track.id);
  }

  @override
  Future<void> decreaseVolume() async {
    await _player.setVolume(state.volume);
    super.decreaseVolume();
  }

  @override
  Future<void> increaseVolume() async {
    await _player.setVolume(state.volume);
    super.increaseVolume();
  }

  @override
  Future<void> addTrackToPlayerPlaylist(
    TrackAudioInfo trackAudioInfo,
    BaseTrack track,
  ) async {
    super.addTrackToPlayerPlaylist(trackAudioInfo, track);
    try {
      if (_player.state.playlist.medias.isEmpty) {
        final trackMedia = mediakit.Media(
          trackAudioInfo.url!,
          extras: {'trackId': track.id, 'index': 0},
        );
        await _player.open(mediakit.Playlist([trackMedia], index: 0));
      } else {
        final trackMedia = mediakit.Media(trackAudioInfo.url!, extras: {
          'trackId': track.id,
          'index': _player.state.playlist.index + 1
        });
        await _player.add(trackMedia);
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
