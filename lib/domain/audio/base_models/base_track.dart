import 'package:dune/domain/audio/base_models/base_album.dart';
import 'package:dune/domain/audio/base_models/base_artist.dart';
import 'package:dune/domain/audio/base_models/thumbnails_set.dart';
import 'package:dune/support/enums/music_source.dart';
import 'package:equatable/equatable.dart';

import 'audio_info_set.dart';

abstract class BaseTrack<AlbumType extends BaseAlbum,
    ArtistType extends BaseArtist> extends Equatable {
  const BaseTrack({
    required this.id,
    required this.album,
    required this.artists,
    required this.thumbnails,
    required this.title,
    required this.year,
    required this.views,
    required this.category,
    required this.duration,
    required this.isExplicit,
    required this.audioInfoSet,
    required this.source,
  }) : assert(source != MusicSource.local ||
            (source == MusicSource.local && audioInfoSet != null));

  final String id;
  final AudioInfoSet? audioInfoSet;
  final AlbumType? album;
  final List<ArtistType> artists;
  final Duration duration;
  final String title;
  final String? year;
  final int? views;
  final String? category;
  final bool isExplicit;
  final ThumbnailsSet thumbnails;
  final MusicSource source;

  String get artistsNames => artists.map((e) => e.name ?? '').join(', ');

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'album': album?.toMap(),
      'length': duration.inSeconds,
      'title': title,
      'year': year,
      'views': views,
      'audioInfoSet': audioInfoSet?.toMap(),
      'category': category,
      'isExplicit': isExplicit,
      'artists': artists.map((e) => e.toMap()).toList(),
      'thumbnails': thumbnails.toMap(),
      'source': source.name,
    };
  }

  @override
  List<Object?> get props => [
        id,
        audioInfoSet,
        album,
        artists,
        duration,
        source,
        year,
        category,
        views,
        isExplicit,
        thumbnails,
        category,
      ];
}
