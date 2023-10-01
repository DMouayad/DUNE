import 'package:dune/domain/audio/base_models/base_album.dart';
import 'package:dune/domain/audio/base_models/base_artist.dart';
import 'package:dune/domain/audio/base_models/thumbnails_set.dart';
import 'package:dune/support/enums/music_source.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import 'audio_info_set.dart';

class BaseTrack<AlbumType extends BaseAlbum, ArtistType extends BaseArtist>
    extends Equatable {
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
  final Duration? duration;
  final String title;
  final String? year;
  final int? views;
  final String? category;
  final bool isExplicit;
  final ThumbnailsSet thumbnails;
  final MusicSource source;

  String get artistsNames => artists.map((e) => e.name ?? '').join(', ');

  DateTime? get releaseDate {
    return year != null && int.tryParse(year!) != null
        ? DateTime(int.parse(year!))
        : null;
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

  BaseTrack copyWith({
    String? id,
    AudioInfoSet? audioInfoSet,
    AlbumType? album,
    List<ArtistType>? artists,
    Duration? duration,
    String? title,
    String? year,
    int? views,
    String? category,
    bool? isExplicit,
    ThumbnailsSet? thumbnails,
    MusicSource? source,
  }) {
    return BaseTrack(
      id: id ?? this.id,
      audioInfoSet: audioInfoSet ?? this.audioInfoSet,
      album: album ?? this.album,
      artists: artists ?? this.artists,
      duration: duration ?? this.duration,
      title: title ?? this.title,
      year: year ?? this.year,
      views: views ?? this.views,
      category: category ?? this.category,
      isExplicit: isExplicit ?? this.isExplicit,
      thumbnails: thumbnails ?? this.thumbnails,
      source: source ?? this.source,
    );
  }

  BaseTrack assignIdIfEmpty() {
    return id.isEmpty ? copyWith(id: _generateId) : this;
  }

  String get _generateId => shortHash(title);

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'album': album?.toMap(),
      'length': duration?.inSeconds,
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

  factory BaseTrack.fromMap(Map<String, dynamic> map) {
    return BaseTrack(
      id: map['id'] as String,
      audioInfoSet: map['audioInfoSet'] as AudioInfoSet,
      album: map['album'] as AlbumType,
      artists: map['artists'] as List<ArtistType>,
      duration: map['duration'] as Duration,
      title: map['title'] as String,
      year: map['year'] as String?,
      views: map['views'] as int,
      category: map['category'] as String?,
      isExplicit: map['isExplicit'] as bool,
      thumbnails: ThumbnailsSet.fromMap(map['thumbnails']),
      source: map['source'] as MusicSource,
    );
  }
}
