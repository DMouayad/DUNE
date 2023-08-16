import 'package:dune/domain/audio/base_models/base_album.dart';
import 'package:dune/domain/audio/base_models/base_artist.dart';
import 'package:dune/domain/audio/base_models/base_playlist.dart';
import 'package:dune/support/utils/result/result.dart';

import '../base_models/base_track.dart';

abstract class BaseSearchDataSource {
  FutureOrResult<List<SearchSuggestion>> getSearchSuggestionsFor(String term);

  FutureOrResult<List<BaseTrack>> searchTracks(String term, int page);

  FutureOrResult<List<BaseAlbum>> searchAlbums(String term, int page);

  FutureOrResult<List<BaseArtist>> searchArtists(String term, int page);

  FutureOrResult<List<BasePlaylist>> searchPlaylists(String term, int page);

  FutureOrResult<AllCategoriesSearchResult> searchAll(String term, int page);

  const BaseSearchDataSource();
}

final class AllCategoriesSearchResult {
  final List<BaseTrack> tracks;
  final List<BaseAlbum> albums;
  final List<BaseArtist> artists;
  final List<BasePlaylist> playlists;

  AllCategoriesSearchResult({
    this.tracks = const [],
    this.albums = const [],
    this.artists = const [],
    this.playlists = const [],
  });
}

final class SearchSuggestion {
  final String title;
  final String description;

  const SearchSuggestion({
    required this.title,
    this.description = '',
  });
}
