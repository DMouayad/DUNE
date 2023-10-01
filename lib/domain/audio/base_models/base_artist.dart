import 'package:dune/domain/audio/base_models/thumbnails_set.dart';
import 'package:dune/domain/audio/base_models/base_track.dart';
import 'package:dune/domain/audio/base_models/base_album.dart';
import 'package:dune/support/enums/music_source.dart';
import 'package:dune/support/extensions/extensions.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class BaseArtist extends Equatable {
  final String? id;
  final String? name;
  final String description;
  final String? browseId;
  final String? radioId;
  final String? shuffleId;
  final String? category;
  final ThumbnailsSet thumbnails;
  final List<BaseTrack> tracks;
  final List<BaseAlbum> albums;
  final MusicSource musicSource;

  const BaseArtist({
    required this.id,
    required this.browseId,
    required this.radioId,
    required this.shuffleId,
    required this.category,
    required this.name,
    required this.description,
    required this.thumbnails,
    required this.tracks,
    required this.albums,
    required this.musicSource,
  });

  BaseArtist setIdIfNull({bool useBrowseId = false}) {
    return copyWith(
      id: id ?? (useBrowseId && browseId != null ? browseId : shortHash(name)),
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        browseId,
        radioId,
        shuffleId,
        category,
        thumbnails,
        tracks,
        musicSource,
        albums
      ];

  BaseArtist copyWith({
    String? id,
    String? name,
    String? description,
    String? browseId,
    String? radioId,
    String? shuffleId,
    String? category,
    ThumbnailsSet? thumbnails,
    List<BaseTrack>? tracks,
    List<BaseAlbum>? albums,
    MusicSource? musicSource,
  }) {
    return BaseArtist(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      browseId: browseId ?? this.browseId,
      radioId: radioId ?? this.radioId,
      shuffleId: shuffleId ?? this.shuffleId,
      category: category ?? this.category,
      thumbnails: thumbnails ?? this.thumbnails,
      tracks: tracks ?? this.tracks,
      albums: albums ?? this.albums,
      musicSource: musicSource ?? this.musicSource,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'browseId': browseId,
      'radioId': radioId,
      'shuffleId': shuffleId,
      'category': category,
      'musicSource': musicSource.name,
      'thumbnails': thumbnails.toMap(),
      'tracks': tracks.map((e) => e.toMap()).toList(),
      'albums': albums.map((e) => e.toMap()).toList(),
    };
  }

  factory BaseArtist.fromMap(Map<String, dynamic> map) {
    final tracksListMap = map.whereKey('tracks');
    final albumsListMap = map.whereKey('albums');
    final thumbnailsMap = map.whereKey('thumbnails');

    return BaseArtist(
      id: map.whereKey('id') as String?,
      name: map.whereKey('name') as String?,
      description: map.whereKey('description') as String? ?? '',
      browseId: map.whereKey('browseId') as String?,
      radioId: map.whereKey('radioId') as String?,
      shuffleId: map.whereKey('shuffleId') as String?,
      category: map.whereKey('category') as String?,
      thumbnails: thumbnailsMap is Map<String, dynamic>
          ? ThumbnailsSet.fromMap(thumbnailsMap)
          : const ThumbnailsSet(),
      tracks: tracksListMap is List
          ? tracksListMap.map((e) => BaseTrack.fromMap(e)).toList()
          : [],
      albums: albumsListMap is List
          ? albumsListMap.map((e) => BaseAlbum.fromMap(e)).toList()
          : [],
      musicSource: map.whereKey('musicSource') as MusicSource,
    );
  }
}
