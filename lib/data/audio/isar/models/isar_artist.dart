import 'package:dune/domain/audio/base_models/base_artist.dart';
import 'package:dune/support/enums/music_source.dart';
import 'package:dune/support/extensions/extensions.dart';
import 'package:flutter/foundation.dart';
import 'package:isar/isar.dart';

import 'isar_album.dart';
import 'isar_thumbnails_set.dart';
import 'isar_track.dart';

part 'isar_artist.g.dart';

@Collection(ignore: {
  'albums',
  'tracks',
  'props',
  'derived',
  'hashCode',
  'stringify',
  'thumbnails'
})
class IsarArtist extends BaseArtist {
  Id? isarId;

  @override
  Set<Type> get derived => {BaseArtist};

  final IsarThumbnailsSet isarThumbnails;

  @override
  @enumerated
  @Index()
  MusicSource get musicSource => super.musicSource;

  @override
  @Index(
      unique: true, replace: true, composite: [CompositeIndex('musicSource')])
  String? get id => super.id;

  final List<String> tracksIds;
  final List<String> albumsIds;

  IsarArtist({
    super.id = '',
    super.name = '',
    super.description = '',
    this.isarThumbnails = const IsarThumbnailsSet(),
    super.tracks = const [],
    super.albums = const [],
    this.tracksIds = const [],
    this.albumsIds = const [],
    super.browseId = '',
    super.radioId = '',
    super.shuffleId = '',
    super.category = '',
    super.musicSource = MusicSource.unknown,
    this.isarId,
  }) : super(thumbnails: isarThumbnails);

  factory IsarArtist.fromMap(Map<String, dynamic> map) {
    final thumbnailsMap = map.whereKey('thumbnails');
    final tracksListMap = map.whereKey('tracks');
    final albumsListMap = map.whereKey('albums');
    return IsarArtist(
      musicSource: MusicSource.byNameOrUnknown(map.whereKey('musicSource')),
      id: map.whereKey('id'),
      name: map.whereKey('name'),
      description: map.whereKey('description'),
      isarThumbnails: thumbnailsMap is Map<String, dynamic>
          ? IsarThumbnailsSet.fromMap(thumbnailsMap)
          : const IsarThumbnailsSet(),
      tracks: tracksListMap is List
          ? tracksListMap.map((e) => IsarTrack.fromMap(e)).toList()
          : [],
      albums: albumsListMap is List
          ? albumsListMap.map((e) => IsarAlbum.fromMap(e)).toList()
          : [],
      browseId: map.whereKey('browseId'),
      radioId: map.whereKey('radioId'),
      shuffleId: map.whereKey('shuffleId'),
      category: map.whereKey('category'),
    );
  }

  IsarArtist setIdIfNull() {
    return copyWith(id: id ?? browseId ?? shortHash(name));
  }

  IsarArtist copyWith({
    String? id,
    String? name,
    String? description,
    String? browseId,
    String? radioId,
    String? shuffleId,
    String? category,
    IsarThumbnailsSet? thumbnails,
    List<IsarTrack>? tracks,
    List<IsarAlbum>? albums,
    Id? isarId,
    List<String>? tracksIds,
    List<String>? albumsIds,
    MusicSource? musicSource,
  }) {
    return IsarArtist(
      id: id ?? this.id,
      isarId: isarId ?? this.isarId,
      name: name ?? this.name,
      description: description ?? this.description,
      browseId: browseId ?? this.browseId,
      radioId: radioId ?? this.radioId,
      shuffleId: shuffleId ?? this.shuffleId,
      category: category ?? this.category,
      isarThumbnails: thumbnails ?? isarThumbnails,
      musicSource: musicSource ?? this.musicSource,
      tracks: tracks ?? this.tracks,
      albums: albums ?? this.albums,
      tracksIds:
          tracksIds ?? tracks?.map((e) => e.id).toList() ?? this.tracksIds,
      albumsIds:
          albumsIds ?? albums?.map((e) => e.id!).toList() ?? this.albumsIds,
    );
  }
}
