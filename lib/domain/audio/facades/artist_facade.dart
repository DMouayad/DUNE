part of 'music_facade.dart';

final class ArtistFacade {
  final ArtistRepository? _youtubeArtistRepo;
  final ArtistRepository? _spotifyArtistRepo;
  final SavableArtistRepository _localArtistRepo;

  ArtistFacade({
    ArtistRepository? youtubeArtistRepository,
    ArtistRepository? spotifyArtistRepository,
    required SavableArtistRepository localArtistRepository,
  })  : _localArtistRepo = localArtistRepository,
        _youtubeArtistRepo = youtubeArtistRepository,
        _spotifyArtistRepo = spotifyArtistRepository;

  FutureOrResult<BaseArtist?> getArtistFromOriginSource(
    String id,
    MusicSource musicSource,
  ) async {
    final remoteRepo = _getRemoteRepository(musicSource);
    if (remoteRepo == null) return null.asResult;
    return (await remoteRepo.getById(id)).fold(onSuccess: (playlist) {
      if (playlist != null) {
        _localArtistRepo.save(playlist);
      }
    });
  }

  FutureOrResult<BaseArtist?> getArtistFromLocalStorage(String id) async {
    return await _localArtistRepo.getById(id);
  }

  ArtistRepository? _getRemoteRepository(MusicSource musicSource) {
    return switch (musicSource) {
      MusicSource.youtube => _youtubeArtistRepo,
      MusicSource.spotify => _spotifyArtistRepo,
      _ => _localArtistRepo,
    };
  }
}
