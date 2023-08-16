import 'package:dune/data/audio/isar/models/isar_album.dart';
import 'package:dune/data/audio/isar/models/isar_artist.dart';
import 'package:dune/domain/audio/base_models/audio_info_set.dart';
import 'package:dune/domain/audio/base_models/base_track.dart';
import 'package:dune/domain/audio/base_models/thumbnails_set.dart';
import 'package:dune/support/enums/music_source.dart';
import 'package:dune/support/extensions/extensions.dart';
import 'package:flutter/foundation.dart';
import 'package:isar/isar.dart';

import 'isar_audio_info_set.dart';
import 'isar_duration.dart';
import 'isar_thumbnails_set.dart';
import 'isar_track_audio_info.dart';
part 'isar_track.g.dart';

@Collection(ignore: {
  'artists',
  'album',
  'duration',
  'props',
  'derived',
  'artistsNames',
  'audioInfoSet',
  'stringify',
  'thumbnails',
  'hashCode',
  'extractArtists'
})
class IsarTrack extends BaseTrack<IsarAlbum, IsarArtist> {
  Id? isarId;

  @override
  Set<Type> get derived => {BaseTrack};

  final IsarThumbnailsSet isarThumbnails;
  final IsarAudioInfoSet? isarAudioInfoSet;
  final String? albumId;
  final List<String> artistsIds;

  @override
  IsarAudioInfoSet? get audioInfoSet => isarAudioInfoSet;

  @override
  @enumerated
  @Index()
  MusicSource get source => super.source;

  @override
  @Index(unique: true, replace: true, composite: [CompositeIndex('source')])
  String get id => super.id;

  final IsarDuration isarDuration;

  IsarTrack({
    this.isarAudioInfoSet,
    this.isarDuration = const IsarDuration(),
    this.isarId,
    this.albumId,
    this.artistsIds = const [],
    super.id = '',
    this.isarThumbnails = const IsarThumbnailsSet(),
    super.title = '',
    super.year = '',
    super.views = 0,
    super.isExplicit = false,
    super.album,
    super.category,
    super.source = MusicSource.youtube,
    super.artists = const [],
  }) : super(
          thumbnails: isarThumbnails,
          duration: Duration(seconds: isarDuration.inSeconds),
          audioInfoSet: isarAudioInfoSet,
        );

  factory IsarTrack.fromMap(Map<String, dynamic> map) {
    final artistsMap = map['artists'];
    final albumMap = map['album'];

    return IsarTrack(
      id: map.whereKey('id'),
      album:
          albumMap is Map<String, dynamic> ? IsarAlbum.fromMap(albumMap) : null,
      artists: artistsMap is List
          ? artistsMap.map((e) => IsarArtist.fromMap(e)).toList()
          : [],
      isarAudioInfoSet: map.whereKey('audioInfoSet') is Map<String, dynamic>
          ? IsarAudioInfoSet.fromMap(map.whereKey('audioInfoSet'))
          : null,
      title: map.whereKey('title'),
      year: map.whereKey('year'),
      views: map.whereKey('views'),
      category: map.whereKey('category'),
      isExplicit: map.whereKey('isExplicit'),
      source: map.whereKey('source') != null
          ? MusicSource.values.byName(map.whereKey('source'))
          : MusicSource.unknown,
      isarThumbnails: IsarThumbnailsSet.fromMap(map.whereKey('thumbnails')),
    );
  }

  IsarTrack copyWithIsar({
    Id? isarId,
    String? id,
    String? title,
    String? year,
    IsarAudioInfoSet? isarAudioInfoSet,
    String? category,
    bool? isExplicit,
    int? views,
    IsarAlbum? album,
    IsarThumbnailsSet? thumbnails,
    List<IsarArtist>? artists,
    IsarDuration? isarDuration,
    MusicSource? source,
    String? albumId,
    List<String>? artistsIds,
  }) {
    return IsarTrack(
      isarId: isarId ?? this.isarId,
      id: id ?? this.id,
      title: title ?? this.title,
      album: album ?? this.album,
      isarDuration: isarDuration ?? this.isarDuration,
      artistsIds:
          artistsIds ?? artists?.map((e) => e.id!).toList() ?? this.artistsIds,
      albumId: albumId ?? album?.id ?? this.albumId,
      artists: artists ?? this.artists,
      views: views ?? this.views,
      isarThumbnails: thumbnails ?? isarThumbnails,
      year: year ?? this.year,
      source: source ?? this.source,
      isarAudioInfoSet: isarAudioInfoSet ?? this.isarAudioInfoSet,
      isExplicit: isExplicit ?? this.isExplicit,
      category: category ?? this.category,
    );
  }

  @override
  T copyWith<T extends BaseTrack>({
    String? id,
    AudioInfoSet? audioInfoSet,
    IsarAlbum? album,
    List<IsarArtist>? artists,
    Duration? duration,
    String? title,
    String? year,
    int? views,
    String? category,
    bool? isExplicit,
    ThumbnailsSet? thumbnails,
    MusicSource? source,
  }) {
    return copyWithIsar(
      isarId: isarId,
      id: id ?? this.id,
      title: title ?? this.title,
      album: album ?? this.album,
      isarDuration: isarDuration,
      artistsIds: artistsIds,
      albumId: album?.id ?? albumId,
      artists: artists ?? this.artists,
      views: views ?? this.views,
      thumbnails: isarThumbnails,
      year: year ?? this.year,
      source: source ?? this.source,
      isarAudioInfoSet: isarAudioInfoSet,
      isExplicit: isExplicit ?? this.isExplicit,
      category: category ?? this.category,
    ) as T;
  }

  factory IsarTrack.fromBase(BaseTrack baseTrack) {
    final isarTrack = IsarTrack(
      id: baseTrack.id,
      title: baseTrack.title,
      isExplicit: baseTrack.isExplicit,
      source: baseTrack.source,
      isarThumbnails: IsarThumbnailsSet.fromMap(baseTrack.thumbnails.toMap()),
      views: baseTrack.views,
      isarDuration: IsarDuration(inSeconds: baseTrack.duration.inSeconds),
      category: baseTrack.category,
      year: baseTrack.year,
      isarAudioInfoSet: IsarAudioInfoSet.from(baseTrack.audioInfoSet),
    );
    final extractedArtists = isarTrack.extractArtistsFromTrack(baseTrack);
    final albumArtistsIds = List<String>.from(extractedArtists.artistsIds);
    final albumArtistId =
        albumArtistsIds.isNotEmpty ? albumArtistsIds.removeAt(0) : null;
    final album = IsarAlbum.tryFromMap(baseTrack.album?.toMap())?.copyWith(
      albumArtistId: albumArtistId,
      featuredArtistsIds: albumArtistsIds,
      tracksIds: [baseTrack.id],
      tracks: [isarTrack],
    ).setIdIfNull();
    return isarTrack.copyWithIsar(
      album: album,
      albumId: album?.id,
      artistsIds: extractedArtists.artistsIds,
      artists: extractedArtists.artists,
    );
  }

  ({List<IsarArtist> artists, List<String> artistsIds}) extractArtistsFromTrack(
    BaseTrack track,
  ) {
    final artistsIds = <String>[];
    final extractedArtists = track.artists.map((e) {
      final String id;
      if (e.id != null) {
        id = e.id!;
        artistsIds.add(e.id!);
      } else {
        id = e.browseId ?? shortHash(e.name);
      }
      return IsarArtist.fromMap(e.toMap())
          .copyWith(
            albumsIds: track.album?.id != null ? [track.album!.id!] : [],
            tracksIds: [track.id],
            id: id,
          )
          .setIdIfNull();
    }).toList();
    return (artists: extractedArtists, artistsIds: artistsIds);
  }
}
