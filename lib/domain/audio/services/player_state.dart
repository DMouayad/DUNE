part of 'audio_player.dart';

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
  final List<BaseTrack> playerTracks;
  final int? playlistCurrentTrackIndex;
  final int? playerCurrentTrackIndex;
  final AudioStreamingQuality streamingQuality;

  BaseTrack? get currentTrack {
    if (playerCurrentTrackIndex != null &&
        playerTracks.isNotEmpty &&
        playerCurrentTrackIndex! < playerTracks.length) {
      return playerTracks.elementAt(playerCurrentTrackIndex!);
    }
    return null;
  }

  TrackAudioInfo? get trackAudioInfo {
    if (currentTrack == null) return null;
    return currentTrack!.audioInfoSet?.whereQuality(
      streamingQuality,
      currentTrack!.source,
    );
  }

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
    this.playerCurrentTrackIndex,
    this.playlistCurrentTrackIndex,
    this.playerTracks = const [],
    this.streamingQuality = AudioStreamingQuality.balanced,
  });

  factory PlayerState.initial() {
    return const PlayerState(
      volume: 100.0,
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
    int? playerCurrentTrackIndex,
    BasePlaylist? currentPlaylist,
    AudioStreamingQuality? streamingQuality,
    List<BaseTrack>? playerTracks,
    bool hasPlaylist = true,
  }) {
    return PlayerState(
      volume: volume ?? this.volume,
      streamingQuality: streamingQuality ?? this.streamingQuality,
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
      playerTracks: playerTracks ?? this.playerTracks,
      playerCurrentTrackIndex:
          playerCurrentTrackIndex ?? this.playerCurrentTrackIndex,
      currentPlaylist:
          hasPlaylist ? (currentPlaylist ?? this.currentPlaylist) : null,
      playlistCurrentTrackIndex:
          playlistCurrentTrackIndex ?? this.playlistCurrentTrackIndex,
    );
  }

  @override
  List<Object?> get props => [
        volume,
        playlistCurrentTrackIndex,
        playerCurrentTrackIndex,
        playerTracks,
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
      ];

  @override
  String toString() {
    return 'PlayerState{volume: $volume, position: $position, duration: $duration, buffer: $buffer, isPlaying: $isPlaying, isBuffering: $isBuffering, isCompleted: $isCompleted, isMuted: $isMuted, autoPlayNext: $autoPlayNext, repeat: $repeat, shuffle: $shuffle, isLoading: $isLoading, currentPlaylist: {title: ${currentPlaylist?.title}, id:${currentPlaylist?.id}}, currentTrack: {title: ${currentTrack?.title}, id:${currentTrack?.id}}, playlistCurrentTrackIndex: $playlistCurrentTrackIndex}';
  }
}

enum RepeatMode { oneTimeForCurrentTrack, loopCurrentPlaylist, none }
