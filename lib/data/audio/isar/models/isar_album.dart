import 'package:dune/data/audio/isar/models/isar_artist.dart';
import 'package:dune/domain/audio/base_models/base_album.dart';
import 'package:dune/support/extensions/extensions.dart';
import 'package:flutter/foundation.dart';
import 'package:isar/isar.dart';

import 'isar_thumbnails_set.dart';
import 'isar_track.dart';

part 'isar_album.g.dart';

@Collection(ignore: {
  'tracks',
  'artists',
  'thumbnails',
  'props',
  'derived',
  'hashCode',
  'stringify'
})
class IsarAlbum extends BaseAlbum {
  Id? isarId;
  final String? albumArtistId;
  final List<String> featuredArtistsIds;
  final List<String> tracksIds;

  @override
  Set<Type> get derived => {BaseAlbum};

  final IsarThumbnailsSet isarThumbnails;

  @override
  @Index(unique: true, replace: true)
  String? get id => super.id;

  IsarAlbum({
    super.id = '',
    this.isarId,
    this.albumArtistId,
    this.featuredArtistsIds = const [],
    this.tracksIds = const [],
    super.artists = const [],
    super.browseId = '',
    super.category = '',
    super.duration = '',
    super.isExplicit = false,
    this.isarThumbnails = const IsarThumbnailsSet(),
    super.title = '',
    super.type = '',
    super.tracks = const [],
    super.releaseDate,
  }) : super(thumbnails: isarThumbnails);

  factory IsarAlbum.fromMap(Map<String, dynamic> map) {
    final thumbnailsMap = map.whereKey('thumbnails');
    final tracksListMap = map.whereKey('tracks');
    final artistsListMap = map.whereKey('artists');
    return IsarAlbum(
      id: map.whereKey('id'),
      artists: artistsListMap is List
          ? artistsListMap.map((e) => IsarArtist.fromMap(e)).toList()
          : [],
      browseId: map.whereKey('browseId'),
      category: map.whereKey('category'),
      duration: map.whereKey('duration'),
      isarThumbnails: thumbnailsMap is Map<String, dynamic>
          ? IsarThumbnailsSet.fromMap(thumbnailsMap)
          : const IsarThumbnailsSet(),
      tracks: tracksListMap is List
          ? tracksListMap.map((e) => IsarTrack.fromMap(e)).toList()
          : [],
      title: map.whereKey('title'),
      type: map.whereKey('type'),
      isExplicit: map.whereKey('isExplicit'),
      releaseDate: map.whereKey('releaseDate') != null
          ? DateTime.tryParse(map.whereKey('releaseDate'))
          : null,
    );
  }

  static IsarAlbum? tryFromMap(Map<String, dynamic>? map) {
    if (map != null) return IsarAlbum.fromMap(map);
    return null;
  }

  IsarAlbum copyWith({
    Id? isarId,
    String? albumArtistId,
    String? id,
    String? browseId,
    List<String>? featuredArtistsIds,
    List<String>? tracksIds,
    IsarThumbnailsSet? thumbnails,
    List<IsarArtist>? artists,
    List<IsarTrack>? tracks,
  }) {
    return IsarAlbum(
      isarId: isarId ?? this.isarId,
      id: id ?? this.id,
      browseId: browseId ?? this.browseId,
      albumArtistId: albumArtistId ?? this.albumArtistId,
      featuredArtistsIds: featuredArtistsIds ?? this.featuredArtistsIds,
      tracksIds:
          tracksIds ?? tracks?.map((e) => e.id).toList() ?? this.tracksIds,
      isarThumbnails: thumbnails ?? this.isarThumbnails,
      artists: artists ?? this.artists,
      tracks: tracks ?? this.tracks,
      duration: duration,
      title: title,
      releaseDate: releaseDate,
      category: category,
      isExplicit: isExplicit,
      type: type,
    );
  }

  IsarAlbum setIdIfNull() {
    return copyWith(id: id ?? browseId ?? shortHash(title));
  }
}
