import 'package:dune/domain/audio/base_data_sources/base_search_data_source.dart';
import 'package:dune/domain/audio/base_models/base_album.dart';
import 'package:dune/domain/audio/base_models/base_artist.dart';
import 'package:dune/domain/audio/base_models/base_track.dart';
import 'package:dune/domain/audio/base_models/base_playlist.dart';

class SearchState {
  final ({List<BaseTrack> data, int page}) songsSearchResult;
  final ({List<BaseAlbum> data, int page}) albumsSearchResult;
  final ({List<BaseArtist> data, int page}) artistsSearchResult;
  final ({List<BasePlaylist> data, int page}) playlistsSearchResult;
  final List<SearchSuggestion> searchSuggestions;
  final SearchFilter filter;
  final String query;
  final Set<SearchFilter> loadingMoreOf;

  const SearchState({
    this.query = '',
    this.loadingMoreOf = const {},
    this.songsSearchResult = (data: const [], page: 1),
    this.albumsSearchResult = (data: const [], page: 1),
    this.artistsSearchResult = (data: const [], page: 1),
    this.playlistsSearchResult = (data: const [], page: 1),
    this.searchSuggestions = const [],
    this.filter = SearchFilter.all,
  });

  SearchState copyWithAdded({
    ({List<BaseTrack> data, int page})? songsSearchResult,
    ({List<BaseAlbum> data, int page})? albumsSearchResult,
    ({List<BaseArtist> data, int page})? artistsSearchResult,
    ({List<BasePlaylist> data, int page})? playlistsSearchResult,
    Set<SearchFilter>? loadingMoreOf,
  }) {
    return copyWith(songsSearchResult: (
      data: [
        ...this.songsSearchResult.data,
        ...(songsSearchResult?.data ?? [])
      ],
      page: songsSearchResult?.page ?? this.songsSearchResult.page,
    ), artistsSearchResult: (
      data: [
        ...this.artistsSearchResult.data,
        ...(artistsSearchResult?.data ?? [])
      ],
      page: artistsSearchResult?.page ?? this.artistsSearchResult.page,
    ), albumsSearchResult: (
      data: [
        ...this.albumsSearchResult.data,
        ...(albumsSearchResult?.data ?? [])
      ],
      page: albumsSearchResult?.page ?? this.albumsSearchResult.page,
    ), playlistsSearchResult: (
      data: [
        ...this.playlistsSearchResult.data,
        ...(playlistsSearchResult?.data ?? [])
      ],
      page: playlistsSearchResult?.page ?? this.playlistsSearchResult.page,
    ), loadingMoreOf: {
      ...this.loadingMoreOf,
      ...(loadingMoreOf ?? {})
    });
  }

  SearchState copyWith({
    ({List<BaseTrack> data, int page})? songsSearchResult,
    ({List<BaseAlbum> data, int page})? albumsSearchResult,
    ({List<BaseArtist> data, int page})? artistsSearchResult,
    ({List<BasePlaylist> data, int page})? playlistsSearchResult,
    List<SearchSuggestion>? searchSuggestions,
    SearchFilter? filter,
    String? query,
    Set<SearchFilter>? loadingMoreOf,
  }) {
    return SearchState(
      songsSearchResult: songsSearchResult ?? this.songsSearchResult,
      albumsSearchResult: albumsSearchResult ?? this.albumsSearchResult,
      artistsSearchResult: artistsSearchResult ?? this.artistsSearchResult,
      playlistsSearchResult:
          playlistsSearchResult ?? this.playlistsSearchResult,
      searchSuggestions: searchSuggestions ?? this.searchSuggestions,
      filter: filter ?? this.filter,
      query: query ?? this.query,
      loadingMoreOf: loadingMoreOf ?? this.loadingMoreOf,
    );
  }

  @override
  String toString() {
    return 'SearchState{songsSearchResult: $songsSearchResult, albumsSearchResult: $albumsSearchResult, artistsSearchResult: $artistsSearchResult, playlistsSearchResult: $playlistsSearchResult, searchSuggestions: $searchSuggestions, filter: $filter, query: $query}';
  }

  SearchState copyWithLoadingMoreOfFilterRemoved(SearchFilter? filter) {
    if (filter == null) return this;
    final newLoadingMoreOf = Set<SearchFilter>.from(loadingMoreOf);
    newLoadingMoreOf.remove(filter);
    return copyWith(loadingMoreOf: newLoadingMoreOf);
  }
}

enum SearchFilter {
  all,
  artists,
  songs,
  playlists,
  albums;

  bool get isAll => this == all;

  bool get hasSongs => this == all || this == songs;

  bool get hasArtists => this == all || this == songs;

  bool get hasAlbums => this == all || this == albums;

  bool get hasPlaylists => this == all || this == playlists;
}
