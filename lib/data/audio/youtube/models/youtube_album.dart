import 'package:dune/domain/audio/base_models/base_album.dart';
import 'package:dune/domain/audio/base_models/base_artist.dart';
import 'package:dune/domain/audio/base_models/base_track.dart';
import 'package:dune/domain/audio/base_models/thumbnails_set.dart';
import 'package:dune/support/enums/music_source.dart';
import 'package:dune/support/extensions/extensions.dart';

import 'youtube_artist.dart';

class YoutubeAlbum extends BaseAlbum {
  @override
  Set<Type> get derived => {BaseAlbum};

  const YoutubeAlbum({
    required super.id,
    required super.title,
    super.artists = const [],
    super.browseId,
    super.category,
    super.duration,
    super.isExplicit = false,
    super.thumbnails = const ThumbnailsSet(),
    super.type,
    super.tracks = const [],
    super.releaseDate,
  }) : super(musicSource: MusicSource.youtube);

  factory YoutubeAlbum.fromMap(Map<String, dynamic> map) {
    return YoutubeAlbum(
      id: map.whereKey('id'),
      title: map.whereKey('title') ?? map.whereKey('name') ?? '',
      artists: map.whereKey('artists') != null
          ? List<YoutubeArtist>.from(
              map["artists"].map((x) => YoutubeArtist.fromMap(x)),
            )
          : [],
      browseId: map.whereKey("browseId"),
      category: map.whereKey("category"),
      duration: map.whereKey("duration"),
      isExplicit: map.whereKey("isExplicit") ?? false,
      thumbnails: map.whereKey('thumbnails') != null
          ? ThumbnailsSet.fromThumbnailsListWithUnknownQuality(
              (map['thumbnails'] as List)
                  .map((e) => BaseThumbnail.fromMap(e, isNetwork: true))
                  .toList())
          : const ThumbnailsSet(),
      type: map.whereKey("type"),
      releaseDate: map.whereKey("year") != null &&
              (int.tryParse(map.whereKey("year")!) != null)
          ? DateTime(int.tryParse(map.whereKey("year"))!)
          : null,
    );
  }

  @override
  BaseAlbum copyWith({
    String? id,
    String? browseId,
    String? category,
    String? duration,
    bool? isExplicit,
    String? title,
    String? type,
    DateTime? releaseDate,
    ThumbnailsSet? thumbnails,
    List<BaseArtist>? artists,
    List<BaseTrack<BaseAlbum, BaseArtist>>? tracks,
    MusicSource? musicSource,
  }) {
    return YoutubeAlbum(
      id: id ?? this.id,
      browseId: browseId ?? this.browseId,
      category: category ?? this.category,
      duration: duration ?? this.duration,
      isExplicit: isExplicit ?? this.isExplicit,
      title: title ?? this.title,
      type: type ?? this.type,
      releaseDate: releaseDate ?? this.releaseDate,
      thumbnails: thumbnails ?? this.thumbnails,
      artists: artists ?? this.artists,
      tracks: tracks ?? this.tracks,
    );
  }
}
