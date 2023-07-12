part of 'music_facade.dart';

final class TrackFacade {
  final OnlineSourceTrackRepository _youtubeTrackRepository;
  final SavableTrackRepository _localTrackRepository;

  TrackFacade({
    required OnlineSourceTrackRepository youtubeTrackRepository,
    required SavableTrackRepository localTrackRepository,
  })  : _youtubeTrackRepository = youtubeTrackRepository,
        _localTrackRepository = localTrackRepository;

  FutureResult<AudioInfoSet> getTrackAudioInfo(BaseTrack track) async {
    if (track.audioInfoSet != null) return track.audioInfoSet!.asResult;
    return (await _getMusicSourceRepo(track.source).getTrackAudioInfo(track))
        .fold(ifSuccess: (audioInfo) {
      _localTrackRepository.saveTrackAudioInfo(track, audioInfo);
    });
  }

  OnlineSourceTrackRepository _getMusicSourceRepo(MusicSource source) {
    return switch (source) {
      MusicSource.youtube => _youtubeTrackRepository,
      _ => throw UnimplementedError(),
    };
  }
}
