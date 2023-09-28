part of 'music_facade.dart';

final class AlbumFacade {
  final AlbumRepository? _youtubeAlbumRepo;
  final AlbumRepository? _spotifyAlbumRepo;
  final SavableAlbumRepository _localAlbumRepo;

  AlbumFacade({
    AlbumRepository? youtubeAlbumRepository,
    AlbumRepository? spotifyAlbumRepository,
    required SavableAlbumRepository localAlbumRepository,
  })  : _localAlbumRepo = localAlbumRepository,
        _youtubeAlbumRepo = youtubeAlbumRepository,
        _spotifyAlbumRepo = spotifyAlbumRepository;

  FutureOrResult<BaseAlbum?> getAlbumFromOriginSource(
    String id,
    MusicSource musicSource,
  ) async {
    final remoteRepo = _getRemoteRepository(musicSource);
    if (remoteRepo == null) return null.asResult;
    return (await remoteRepo.getById(id)).fold(onSuccess: (playlist) {
      if (playlist != null) {
        _localAlbumRepo.save(playlist);
      }
    });
  }

  FutureOrResult<BaseAlbum?> getAlbumFromLocalStorage(String id) async {
    return await _localAlbumRepo.getById(id);
  }

  AlbumRepository? _getRemoteRepository(MusicSource musicSource) {
    return switch (musicSource) {
      MusicSource.youtube => _youtubeAlbumRepo,
      MusicSource.spotify => _spotifyAlbumRepo,
      _ => _localAlbumRepo,
    };
  }
}
