import 'dart:collection';

import 'package:dune/domain/audio/base_models/base_playlist.dart';
import 'package:dune/support/extensions/extensions.dart';
import 'package:dune/support/models/query_options.dart';
import 'package:equatable/equatable.dart';

import 'base_album.dart';
import 'base_artist.dart';
import 'base_track.dart';

class MusicLibrary extends Equatable {
  late final HashMap<QueryOptions, List<BaseTrack>> _tracksCollection;
  late final HashMap<QueryOptions, List<BasePlaylist>> _playlistsCollection;
  late final HashMap<QueryOptions, List<BaseAlbum>> _albumsCollection;
  late final HashMap<QueryOptions, List<BaseArtist>> _artistsCollection;

  MusicLibrary()
      : _tracksCollection = HashMap(),
        _playlistsCollection = HashMap(),
        _albumsCollection = HashMap(),
        _artistsCollection = HashMap();

  void setTracks(List<BaseTrack> tracks, QueryOptions queryOptions) {
    _setCollectionKeyValue(_tracksCollection, tracks, queryOptions);
  }

  void setPlaylists(List<BasePlaylist> playlists, QueryOptions queryOptions) {
    _setCollectionKeyValue(_playlistsCollection, playlists, queryOptions);
  }

  void setAlbums(List<BaseAlbum> albums, QueryOptions queryOptions) {
    _setCollectionKeyValue(_albumsCollection, albums, queryOptions);
  }

  void setArtists(List<BaseArtist> artists, QueryOptions queryOptions) {
    _setCollectionKeyValue(_artistsCollection, artists, queryOptions);
  }

  void _setCollectionKeyValue<T>(
    HashMap<QueryOptions, List<T>> collection,
    List<T> values,
    QueryOptions queryOptions,
  ) {
    collection.update(queryOptions, (value) => values, ifAbsent: () => values);
  }

  void _addToCollection<T>(
    HashMap<QueryOptions, List<T>> collection,
    List<T> values,
    QueryOptions queryOptions,
  ) {
    collection.update(queryOptions, (value) => [...value, ...values],
        ifAbsent: () => values);
  }

  List<BaseTrack>? getTracks(QueryOptions queryOptions) {
    return _tracksCollection.whereKey(queryOptions);
  }

  List<BaseAlbum>? getAlbums(QueryOptions queryOptions) {
    return _albumsCollection.whereKey(queryOptions);
  }

  List<BasePlaylist>? getPlaylists(QueryOptions queryOptions) {
    return _playlistsCollection.whereKey(queryOptions);
  }

  List<BaseArtist>? getArtists(QueryOptions queryOptions) {
    return _artistsCollection.whereKey(queryOptions);
  }

  @override
  List<Object?> get props => [
        _tracksCollection,
        _albumsCollection,
        _artistsCollection,
        _playlistsCollection
      ];
}
