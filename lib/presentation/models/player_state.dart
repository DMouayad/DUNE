import 'package:dune/domain/audio/base_models/base_playlist.dart';
import 'package:dune/domain/audio/base_models/base_track.dart';
import 'package:equatable/equatable.dart';

class PlayerState extends Equatable {
  final double volume;
  final Duration position;
  final Duration duration;

  final Duration buffer;
  final bool isPlaying;
  final bool isBuffering;
  final bool isCompleted;
  final bool isMuted;
  final bool autoPlayNext;
  final RepeatMode repeat;
  final bool shuffle;
  final bool isLoading;
  final BasePlaylist? currentPlaylist;
  final BaseTrack? currentTrack;
  final int? playlistCurrentTrackIndex;

  bool get currentPlaylistNotNull => currentPlaylist != null;

  bool get isPaused => currentTrack != null && !isPlaying;

  bool get isIdle => (!isPlaying && !isLoading && !isPaused);

  const PlayerState({
    required this.volume,
    required this.position,
    required this.buffer,
    required this.duration,
    required this.isPlaying,
    required this.isBuffering,
    required this.isCompleted,
    required this.isMuted,
    required this.shuffle,
    required this.isLoading,
    required this.repeat,
    required this.autoPlayNext,
    this.currentPlaylist,
    this.currentTrack,
    this.playlistCurrentTrackIndex,
  });

  factory PlayerState.initial() {
    return const PlayerState(
      volume: 70.0,
      position: Duration.zero,
      buffer: Duration.zero,
      duration: Duration.zero,
      isPlaying: false,
      isBuffering: false,
      shuffle: false,
      isCompleted: false,
      isMuted: false,
      autoPlayNext: false,
      repeat: RepeatMode.none,
      isLoading: false,
    );
  }

  PlayerState copyWith({
    double? volume,
    Duration? position,
    Duration? duration,
    Duration? buffer,
    bool? isPlaying,
    bool? isBuffering,
    bool? isCompleted,
    bool? isMuted,
    RepeatMode? repeat,
    bool? shuffle,
    bool? isLoading,
    bool? autoPlayNext,
    int? playlistCurrentTrackIndex,
    BasePlaylist? currentPlaylist,
    BaseTrack? currentTrack,
  }) {
    return PlayerState(
      volume: volume ?? this.volume,
      position: position ?? this.position,
      duration: duration ?? this.duration,
      buffer: buffer ?? this.buffer,
      isPlaying: isPlaying ?? this.isPlaying,
      isBuffering: isBuffering ?? this.isBuffering,
      isCompleted: isCompleted ?? this.isCompleted,
      isMuted: isMuted ?? this.isMuted,
      repeat: repeat ?? this.repeat,
      shuffle: shuffle ?? this.shuffle,
      autoPlayNext: autoPlayNext ?? this.autoPlayNext,
      isLoading: isLoading ?? this.isLoading,
      currentTrack: currentTrack ?? this.currentTrack,
      currentPlaylist: currentPlaylist ?? this.currentPlaylist,
      playlistCurrentTrackIndex:
          playlistCurrentTrackIndex ?? this.playlistCurrentTrackIndex,
    );
  }

  @override
  List<Object?> get props => [
        volume,
        playlistCurrentTrackIndex,
        position,
        duration,
        buffer,
        isPlaying,
        isBuffering,
        isCompleted,
        isMuted,
        repeat,
        shuffle,
        isLoading,
        autoPlayNext,
        currentPlaylist,
        currentTrack,
      ];

  @override
  String toString() {
    return 'PlayerState{volume: $volume, position: $position, duration: $duration, buffer: $buffer, isPlaying: $isPlaying, isBuffering: $isBuffering, isCompleted: $isCompleted, isMuted: $isMuted, autoPlayNext: $autoPlayNext, repeat: $repeat, shuffle: $shuffle, isLoading: $isLoading, currentPlaylist: {title: ${currentPlaylist?.title}, id:${currentPlaylist?.id}}, currentTrack: {title: ${currentTrack?.title}, id:${currentTrack?.id}}, playlistCurrentTrackIndex: $playlistCurrentTrackIndex}';
  }
}

enum RepeatMode { oneTimeForCurrentTrack, loopCurrentPlaylist, none }
