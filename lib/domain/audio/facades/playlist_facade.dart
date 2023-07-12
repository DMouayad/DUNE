part of 'music_facade.dart';

final class PlaylistFacade {
  final PlaylistRepository _youtubePlaylistRepository;
  final SavablePlaylistRepository _cachePlaylistRepository;

  // final PlaylistRepository _spotifyPlaylistRepository;

  PlaylistFacade({
    required PlaylistRepository youtubePlaylistRepository,
    required SavablePlaylistRepository cachePlaylistRepository,
  })  : _cachePlaylistRepository = cachePlaylistRepository,
        _youtubePlaylistRepository = youtubePlaylistRepository;

  FutureOrResult<BasePlaylist?> getPlaylist(
    String id,
    MusicSource musicSource,
  ) async {
    final repository = _getRemoteRepository(musicSource);

    return (await repository.getById(id)).fold(ifSuccess: (playlist) {
      if (playlist != null) _cachePlaylistRepository.save(playlist);
    });
  }

  FutureOrResult<List<BasePlaylist>?> getCategoryPlaylists(
    String id,
    MusicSource musicSource,
  ) async {
    final repository = _getRemoteRepository(musicSource);

    return (await repository.getCategoryPlaylists(id)).fold(
        ifSuccess: (playlists) {
      if (playlists != null) {
        _cachePlaylistRepository.saveCategoryPlaylists(id, playlists);
      }
    });
  }

  FutureOrResult<BasePlaylist?> getCachedPlaylistInfo(String id) async {
    return await _cachePlaylistRepository.getById(id);
  }

  FutureOrResult<List<BasePlaylist>?> getCachedCategoryPlaylists(
      String id) async {
    return await _cachePlaylistRepository.getCategoryPlaylists(id);
  }

  PlaylistRepository _getRemoteRepository(MusicSource musicSource) {
    return switch (musicSource) {
      MusicSource.youtube => _youtubePlaylistRepository,
      _ => throw UnimplementedError(),
    };
  }
}
