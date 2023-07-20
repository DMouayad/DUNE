part of 'music_facade.dart';

final class PlaylistFacade {
  final PlaylistRepository _youtubePlaylistRepository;
  final SavablePlaylistRepository _localRepository;
  final PlaylistRepository? _spotifyPlaylistRepository;

  PlaylistFacade({
    required PlaylistRepository youtubePlaylistRepository,
    PlaylistRepository? spotifyPlaylistRepository,
    required SavablePlaylistRepository localPlaylistRepository,
  })  : _localRepository = localPlaylistRepository,
        _youtubePlaylistRepository = youtubePlaylistRepository,
        _spotifyPlaylistRepository = spotifyPlaylistRepository;

  FutureOrResult<BasePlaylist?> getPlaylist(
    String id,
    MusicSource musicSource,
  ) async {
    final repository = _getRemoteRepository(musicSource);

    return (await repository.getById(id)).fold(onSuccess: (playlist) {
      if (playlist != null) {
        _localRepository
            .save(playlist)
            .foldThen(onFailure: (error) => Log.e(error));
      }
    });
  }

  FutureOrResult<List<BasePlaylist>?> getCategoryPlaylists(
    String id,
    MusicSource musicSource,
  ) async {
    final repository = _getRemoteRepository(musicSource);

    return (await repository.getCategoryPlaylists(id)).fold(
        onSuccess: (playlists) {
      if (playlists != null) {
        _localRepository.saveCategoryPlaylists(id, playlists);
      }
    });
  }

  FutureOrResult<BasePlaylist?> getCachedPlaylistInfo(String id) async {
    return await _localRepository.getById(id);
  }

  FutureOrResult<List<BasePlaylist>?> getCachedCategoryPlaylists(
      String id) async {
    return await _localRepository.getCategoryPlaylists(id);
  }

  PlaylistRepository _getRemoteRepository(MusicSource musicSource) {
    return switch (musicSource) {
      MusicSource.youtube => _youtubePlaylistRepository,
      MusicSource.spotify => _spotifyPlaylistRepository!,
      _ => throw UnimplementedError(),
    };
  }
}
