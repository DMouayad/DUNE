part of 'music_facade.dart';

final class ExploreMusicFacade {
  final ExploreMusicRepository _youtubeRepository;

  const ExploreMusicFacade({
    required ExploreMusicRepository youtubeRepository,
    ExploreMusicRepository? spotifyRepository,
  })  : _youtubeRepository = youtubeRepository,
        _spotifyRepository = spotifyRepository;

  //TODO: implement this when adding Spotify as a music source
  final ExploreMusicRepository? _spotifyRepository;

  FutureOrResult<List<BaseExploreMusicCollection>> getExploreMusicMainItems(
      MusicSource musicSource) async {
    return await _getRepoFor(musicSource).getExploreMusicMainItems();
  }

  FutureOrResult<List<BaseExploreMusicCollection>>
      getExploreMusicItemsByMoodsAndGenres(MusicSource musicSource) async {
    return await _getRepoFor(musicSource)
        .getExploreMusicItemsByMoodsAndGenres();
  }

  ExploreMusicRepository _getRepoFor(MusicSource musicSource) {
    return switch (musicSource) {
      MusicSource.youtube => _youtubeRepository,
      MusicSource.spotify => _spotifyRepository!,
      _ => throw UnimplementedError(),
    };
  }
}
