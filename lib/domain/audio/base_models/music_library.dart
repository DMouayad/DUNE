import 'dart:collection';

import 'package:dune/support/extensions/extensions.dart';
import 'package:dune/support/models/query_options.dart';
import 'package:equatable/equatable.dart';

import 'base_album.dart';
import 'base_artist.dart';
import 'base_track.dart';

class MusicLibrary extends Equatable {
  late final HashMap<QueryOptions, List<BaseTrack>> _tracksCollection;
  late final HashMap<QueryOptions, List<BaseAlbum>> _albumsCollection;
  late final HashMap<QueryOptions, List<BaseArtist>> _artistsCollection;

  MusicLibrary()
      : _tracksCollection = HashMap(),
        _albumsCollection = HashMap(),
        _artistsCollection = HashMap();

  void setTracks(List<BaseTrack> tracks, QueryOptions queryOptions) {
    _setCollectionKeyValue(_tracksCollection, tracks, queryOptions);
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

  List<BaseTrack> getTracks([
    QueryOptions queryOptions = QueryOptions.defaultOptions,
  ]) {
    return _tracksCollection.whereQueryOptions(queryOptions);
  }

  List<BaseAlbum> getAlbums([
    QueryOptions queryOptions = QueryOptions.defaultOptions,
  ]) {
    return _albumsCollection.whereQueryOptions(queryOptions);
  }

  List<BaseArtist> getArtists([
    QueryOptions queryOptions = QueryOptions.defaultOptions,
  ]) {
    return _artistsCollection.whereQueryOptions(queryOptions);
  }

  bool get isEmpty =>
      _tracksCollection.isEmpty &&
      _albumsCollection.isEmpty &&
      _artistsCollection.isEmpty;

  @override
  List<Object?> get props => [
        _tracksCollection,
        _albumsCollection,
        _artistsCollection,
      ];
}

extension HashMapExtension<V> on HashMap<QueryOptions, List<V>> {
  List<V> whereQueryOptions(QueryOptions options) {
    final key = keys.firstWhereOrNull((e) =>
        e.sortBy == options.sortBy &&
        e.page == options.page &&
        e.sortDescending == options.sortDescending &&
        e.limit >= options.limit);

    List<V> values = whereKey(key) ?? [];
    if (values.isEmpty || key == null) return values;

    final requiredItemsIsLessThanExisting = options.limit < key.limit;
    if (requiredItemsIsLessThanExisting) {
      values = values.take(options.limit).toList();
      values = options.sortDescending ? values.reversed.toList() : values;
    }
    return values;
  }
}
