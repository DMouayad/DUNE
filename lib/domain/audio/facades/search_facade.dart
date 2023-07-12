part of 'music_facade.dart';

final class SearchFacade {
  final SearchRepository _youtubeSearchRepo;

  // TODO: IMPLEMENT
  // final SearchRepository _localSearchRepo;
  // final SearchRepository _spotifySearchRepo;

  const SearchFacade({required SearchRepository youtubeSearchRepository})
      : _youtubeSearchRepo = youtubeSearchRepository;

  FutureResult<List<SearchSuggestion>> getSearchSuggestionsFor(
    String query,
    MusicSource source,
  ) async {
    return await _getRepoFor(source).getSearchSuggestionsFor(query);
  }

  SearchRepository _getRepoFor(MusicSource source) {
    return switch (source) {
      MusicSource.youtube => _youtubeSearchRepo,
      _ => throw UnimplementedError(),
    };
  }

  FutureOrResult<List<BaseTrack>> searchTracks(
      String term, int page, MusicSource source) async {
    return await _getRepoFor(source).searchTracks(term, page);
  }

  FutureOrResult<List<BaseAlbum>> searchAlbums(
      String term, int page, MusicSource source) async {
    return await _getRepoFor(source).searchAlbums(term, page);
  }

  FutureOrResult<List<BaseArtist>> searchArtists(
      String term, int page, MusicSource source) async {
    return await _getRepoFor(source).searchArtists(term, page);
  }

  FutureOrResult<List<BasePlaylist>> searchPlaylists(
      String term, int page, MusicSource source) async {
    return await _getRepoFor(source).searchPlaylists(term, page);
  }

  FutureOrResult<AllCategoriesSearchResult> searchAll(
      String term, int page, MusicSource source) async {
    return await _getRepoFor(source).searchAll(term, page);
  }
}
