import 'package:dune/presentation/models/search_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//
import 'package:dune/domain/audio/base_data_sources/base_search_data_source.dart';
import 'package:dune/domain/audio/facades/music_facade.dart';
import 'package:dune/support/enums/music_source.dart';
import 'package:dune/support/utils/result/result.dart';

class SearchController extends StateNotifier<AsyncValue<SearchState>> {
  SearchController() : super(const AsyncValue.data(SearchState()));

  void clearSearchState() {
    state = const AsyncValue.data(SearchState());
  }

  SearchState get _emptySearchState => const SearchState();

  void _setStateToLoadingWithPreviousData(String query) {
    state = const AsyncValue<SearchState>.loading().copyWithPrevious(
      AsyncValue.data(state.requireValue.copyWith(query: query)),
    );
  }

  Future<void> _handleSearchRequest<T>({
    required String query,
    required FutureOrResult<T> Function() searchResultFuture,
    required AsyncValue<SearchState> Function(T result) stateOnSuccess,
  }) async {
    _setStateToLoadingWithPreviousData(query);
    final searchResult = await searchResultFuture();
    if (searchResult.isFailure) {
      state = _getStateFromFailureResult(searchResult.asFailure);
    } else {
      state = stateOnSuccess(searchResult.requireValue);
    }
  }

  Future<void> getSuggestions(
      String term, MusicSource searchMusicSource) async {
    final query = term.trim();
    if (query.isEmpty) {
      state = AsyncValue.data(
          state.requireValue.copyWith(query: '', searchSuggestions: []));
    } else if (query != state.valueOrNull?.query) {
      state = const AsyncValue<SearchState>.loading().copyWithPrevious(
        AsyncValue.data(state.requireValue.copyWith(query: query)),
      );
      (await MusicFacade.search
              .getSearchSuggestionsFor(query, searchMusicSource))
          .fold(
        ifSuccess: (suggestions) {
          state = AsyncValue.data(
              state.requireValue.copyWith(searchSuggestions: suggestions));
        },
        ifFailure: (error) => state =
            AsyncValue<SearchState>.error(error, error.stackTrace)
                .copyWithPrevious(state),
      );
    }
  }

  void setSearchFilter(SearchFilter filter) {
    state = AsyncValue.data(
        (state.valueOrNull ?? const SearchState()).copyWith(filter: filter));
  }

  AsyncValue<SearchState> _getStateFromFailureResult(FailureResult result) {
    return AsyncError<SearchState>(result.error, result.error.stackTrace)
        .copyWithPrevious(
      AsyncValue.data(_emptySearchState.copyWith(
        query: state.requireValue.query,
        filter: state.requireValue.filter,
        searchSuggestions: state.requireValue.searchSuggestions,
      )),
    );
  }

  void getMoreResultsFor(SearchFilter filter, MusicSource source) {
    state = AsyncValue.data(
        state.requireValue.copyWithAdded(loadingMoreOf: {filter}));

    getSearchResults(
      state.requireValue.query,
      source,
      filter: filter,
      page: switch (filter) {
        SearchFilter.all => 1,
        SearchFilter.songs => state.requireValue.songsSearchResult.page + 1,
        SearchFilter.albums => state.requireValue.albumsSearchResult.page + 1,
        SearchFilter.artists => state.requireValue.artistsSearchResult.page + 1,
        SearchFilter.playlists =>
          state.requireValue.playlistsSearchResult.page + 1,
      },
    );
  }

  void getSearchResults(
    String query,
    MusicSource source, {
    int page = 1,
    SearchFilter? filter,
  }) async {
    switch (filter ?? state.requireValue.filter) {
      case SearchFilter.all:
        _handleSearchRequest<AllCategoriesSearchResult>(
          query: query,
          searchResultFuture: () {
            return MusicFacade.search.searchAll(query, page, source);
          },
          stateOnSuccess: (result) {
            return AsyncValue.data(state.requireValue.copyWith(
              albumsSearchResult: (data: result.albums, page: page),
              artistsSearchResult: (data: result.artists, page: page),
              playlistsSearchResult: (data: result.playlists, page: page),
              songsSearchResult: (data: result.tracks, page: page),
            ));
          },
        );
      case SearchFilter.artists:
        _handleSearchRequest(
          query: query,
          searchResultFuture: () {
            return MusicFacade.search.searchArtists(query, page, source);
          },
          stateOnSuccess: (result) {
            final data = page != 1
                ? state.requireValue.copyWithAdded(
                    artistsSearchResult: (data: result, page: page))
                : state.requireValue.copyWith(
                    artistsSearchResult: (data: result, page: page),
                  );
            return AsyncValue.data(
                data.copyWithLoadingMoreOfFilterRemoved(filter));
          },
        );
      case SearchFilter.albums:
        _handleSearchRequest(
          query: query,
          searchResultFuture: () {
            return MusicFacade.search.searchAlbums(query, page, source);
          },
          stateOnSuccess: (result) {
            final data = page != 1
                ? state.requireValue.copyWithAdded(
                    albumsSearchResult: (data: result, page: page))
                : state.requireValue
                    .copyWith(albumsSearchResult: (data: result, page: page));
            return AsyncValue.data(
                data.copyWithLoadingMoreOfFilterRemoved(filter));
          },
        );
      case SearchFilter.playlists:
        _handleSearchRequest(
          query: query,
          searchResultFuture: () {
            return MusicFacade.search.searchPlaylists(query, page, source);
          },
          stateOnSuccess: (result) {
            final data = page != 1
                ? state.requireValue.copyWithAdded(
                    playlistsSearchResult: (data: result, page: page))
                : state.requireValue.copyWith(
                    playlistsSearchResult: (data: result, page: page));
            return AsyncValue.data(
                data.copyWithLoadingMoreOfFilterRemoved(filter));
          },
        );
      case SearchFilter.songs:
        _handleSearchRequest(
          query: query,
          searchResultFuture: () {
            return MusicFacade.search.searchTracks(query, page, source);
          },
          stateOnSuccess: (result) {
            final data = page != 1
                ? state.requireValue.copyWithAdded(
                    songsSearchResult: (data: result, page: page))
                : state.requireValue
                    .copyWith(songsSearchResult: (data: result, page: page));
            return AsyncValue.data(
                data.copyWithLoadingMoreOfFilterRemoved(filter));
          },
        );
    }
  }

  void clearSuggestions() {
    state = AsyncData(
      state.requireValue.copyWith(searchSuggestions: [], query: ''),
    );
  }
}
