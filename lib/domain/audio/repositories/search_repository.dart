import 'package:dune/domain/audio/base_data_sources/base_search_data_source.dart';
import 'package:dune/domain/audio/base_models/base_album.dart';
import 'package:dune/domain/audio/base_models/base_artist.dart';
import 'package:dune/domain/audio/base_models/base_track.dart';
import 'package:dune/support/utils/result/result.dart';

import '../base_models/base_playlist.dart';

base class SearchRepository {
  final BaseSearchDataSource _dataSource;

  SearchRepository(this._dataSource);

  FutureOrResult<List<SearchSuggestion>> getSearchSuggestionsFor(
    String term,
  ) async {
    return await _dataSource.getSearchSuggestionsFor(term);
  }

  FutureOrResult<List<BaseTrack>> searchTracks(String term, int page) async {
    return await _dataSource.searchTracks(term, page);
  }

  FutureOrResult<List<BaseAlbum>> searchAlbums(String term, int page) async {
    return await _dataSource.searchAlbums(term, page);
  }

  FutureOrResult<List<BaseArtist>> searchArtists(String term, int page) async {
    return await _dataSource.searchArtists(term, page);
  }

  FutureOrResult<List<BasePlaylist>> searchPlaylists(
      String term, int page) async {
    return await _dataSource.searchPlaylists(term, page);
  }

  FutureOrResult<AllCategoriesSearchResult> searchAll(
      String term, int page) async {
    return await _dataSource.searchAll(term, page);
  }
}
