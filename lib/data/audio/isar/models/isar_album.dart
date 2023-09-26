import 'package:dune/data/audio/isar/models/isar_artist.dart';
import 'package:dune/domain/audio/base_models/base_album.dart';
import 'package:dune/domain/audio/base_models/base_artist.dart';
import 'package:dune/domain/audio/base_models/base_track.dart';
import 'package:dune/domain/audio/base_models/thumbnails_set.dart';
import 'package:dune/support/enums/music_source.dart';
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
  'albumArtist',
  'stringify'
})
class IsarAlbum extends BaseAlbum {
  Id? isarId;
  @Index()
  final String? albumArtistId;
  final List<String> featuredArtistsIds;
  final List<String> tracksIds;

  @override
  Set<Type> get derived => {BaseAlbum};

  @override
  @enumerated
  @Index()
  MusicSource get musicSource => super.musicSource;

  final IsarThumbnailsSet isarThumbnails;

  @override
  @Index(
      unique: true, replace: true, composite: [CompositeIndex('musicSource')])
  String? get id => super.id;

  IsarAlbum({
    super.id = '',
    this.isarId,
    String? albumArtistId,
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
    super.musicSource = MusicSource.unknown,
    super.albumArtist,
  })  : albumArtistId = albumArtist?.id ?? albumArtistId,
        super(thumbnails: isarThumbnails);

  factory IsarAlbum.fromMap(Map<String, dynamic> map) {
    final thumbnailsMap = map.whereKey('thumbnails');
    final tracksListMap = map.whereKey('tracks');
    final artistsListMap = map.whereKey('artists');
    return IsarAlbum(
      id: map.whereKey('id'),
      musicSource: MusicSource.byNameOrUnknown(map.whereKey('musicSource')),
      artists: artistsListMap is List
          ? artistsListMap.map((e) => IsarArtist.fromMap(e)).toList()
          : [],
      albumArtist: IsarArtist.tryFromMap(map.whereKey('albumArtist')),
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

  @override
  IsarAlbum setIdIfNull() {
    return copyWith(id: id ?? shortHash(title));
  }

  @override
  IsarAlbum copyWith({
    Id? isarId,
    String? id,
    String? browseId,
    String? category,
    String? duration,
    bool? isExplicit,
    String? title,
    String? type,
    DateTime? releaseDate,
    ThumbnailsSet? thumbnails,
    BaseArtist? albumArtist,
    List<BaseArtist>? artists,
    List<BaseTrack<BaseAlbum, BaseArtist>>? tracks,
    MusicSource? musicSource,
    String? albumArtistId,
    List<String>? featuredArtistsIds,
    List<String>? tracksIds,
  }) {
    return IsarAlbum(
      isarId: isarId ?? this.isarId,
      id: id ?? this.id,
      browseId: browseId ?? this.browseId,
      albumArtist: albumArtist ?? this.albumArtist,
      albumArtistId: albumArtistId ?? this.albumArtistId,
      featuredArtistsIds: featuredArtistsIds ?? this.featuredArtistsIds,
      tracksIds:
          tracksIds ?? tracks?.map((e) => e.id).toList() ?? this.tracksIds,
      isarThumbnails: thumbnails != null
          ? IsarThumbnailsSet.fromMap(thumbnails.toMap())
          : isarThumbnails,
      artists: artists ?? this.artists,
      tracks: tracks ?? this.tracks,
      musicSource: musicSource ?? this.musicSource,
      duration: duration ?? this.duration,
      title: title ?? this.title,
      releaseDate: releaseDate ?? this.releaseDate,
      category: category ?? this.category,
      isExplicit: isExplicit ?? this.isExplicit,
      type: type ?? this.type,
    );
  }
}
