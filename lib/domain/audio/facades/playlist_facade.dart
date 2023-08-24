part of 'music_facade.dart';

final class PlaylistFacade {
  final PlaylistRepository? _youtubePlaylistRepo;
  final PlaylistRepository? _spotifyPlaylistRepo;
  final SavablePlaylistRepository _localPlaylistRepo;

  PlaylistFacade({
    PlaylistRepository? youtubePlaylistRepository,
    PlaylistRepository? spotifyPlaylistRepository,
    required SavablePlaylistRepository localPlaylistRepository,
  })  : _localPlaylistRepo = localPlaylistRepository,
        _youtubePlaylistRepo = youtubePlaylistRepository,
        _spotifyPlaylistRepo = spotifyPlaylistRepository;

  FutureOrResult<BasePlaylist?> getPlaylistFromOriginSource(
    String id,
    MusicSource musicSource,
  ) async {
    final remoteRepo = _getRemoteRepository(musicSource);
    if (remoteRepo == null) return null.asResult;
    return (await remoteRepo.getById(id)).fold(onSuccess: (playlist) {
      if (playlist != null) {
        _localPlaylistRepo.save(playlist);
      }
    });
  }

  FutureOrResult<List<BasePlaylist>?> getCategoryPlaylists(
    String id,
    MusicSource musicSource,
  ) async {
    final remoteRepo = _getRemoteRepository(musicSource);
    if (remoteRepo == null) return null.asResult;
    return (await remoteRepo.getCategoryPlaylists(id)).fold(
        onSuccess: (playlists) {
      if (playlists != null) {
        _localPlaylistRepo.saveCategoryPlaylists(id, playlists);
      }
    });
  }

  FutureOrResult<BasePlaylist?> getPlaylistFromLocalStorage(String id) async {
    return await _localPlaylistRepo.getById(id);
  }

  FutureOrResult<List<BasePlaylist>?> getCategoryPlaylistsFromLocalStorage(
    String id,
  ) async {
    return await _localPlaylistRepo.getCategoryPlaylists(id);
  }

  PlaylistRepository? _getRemoteRepository(MusicSource musicSource) {
    return switch (musicSource) {
      MusicSource.youtube => _youtubePlaylistRepo,
      MusicSource.spotify => _spotifyPlaylistRepo,
      _ => _localPlaylistRepo,
    };
  }
}
