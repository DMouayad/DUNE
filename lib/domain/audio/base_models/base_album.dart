import 'package:dune/domain/audio/base_models/thumbnails_set.dart';
import 'package:dune/domain/audio/base_models/base_artist.dart';
import 'package:dune/support/enums/music_source.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import 'base_track.dart';

class BaseAlbum extends Equatable {
  final String? id;
  final String? browseId;
  final String? category;
  final String? duration;
  final bool isExplicit;
  final String title;
  final String? type;
  final DateTime? releaseDate;
  final ThumbnailsSet thumbnails;

  /// The artist this album belongs to.
  final BaseArtist? albumArtist;
  final List<BaseArtist> artists;
  final List<BaseTrack> tracks;
  final MusicSource musicSource;

  const BaseAlbum({
    required this.id,
    required this.artists,
    required this.browseId,
    required this.category,
    required this.duration,
    required this.isExplicit,
    required this.thumbnails,
    required this.title,
    required this.type,
    required this.tracks,
    required this.releaseDate,
    required this.musicSource,
    required this.albumArtist,
  });

  Map<String, dynamic> toMap() {
    return {
      'artists': artists.map((e) => e.toMap()).toList(),
      'browseId': browseId,
      'category': category,
      'duration': duration,
      'isExplicit': isExplicit,
      'thumbnails': thumbnails.toMap(),
      'albumArtist': albumArtist?.toMap(),
      'title': title,
      'type': type,
      'id': id,
      'musicSource': musicSource.name,
      'tracks': tracks.map((e) => e.toMap()).toList(),
      'releaseDate': releaseDate?.toIso8601String(),
    };
  }

  @override
  List<Object?> get props => [
        id,
        artists,
        browseId,
        category,
        duration,
        isExplicit,
        title,
        type,
        tracks,
        releaseDate,
        albumArtist,
        musicSource
      ];

  BaseAlbum setIdIfNull({bool useBrowseId = false}) {
    return copyWith(
      id: id ?? (useBrowseId && browseId != null ? browseId : _generateId),
    );
  }

  String get _generateId => shortHash(title);

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
    BaseArtist? albumArtist,
    List<BaseArtist>? artists,
    List<BaseTrack>? tracks,
    MusicSource? musicSource,
  }) {
    return BaseAlbum(
      id: id ?? this.id,
      browseId: browseId ?? this.browseId,
      category: category ?? this.category,
      duration: duration ?? this.duration,
      albumArtist: albumArtist ?? this.albumArtist,
      isExplicit: isExplicit ?? this.isExplicit,
      title: title ?? this.title,
      type: type ?? this.type,
      releaseDate: releaseDate ?? this.releaseDate,
      thumbnails: thumbnails ?? this.thumbnails,
      artists: artists ?? this.artists,
      tracks: tracks ?? this.tracks,
      musicSource: musicSource ?? this.musicSource,
    );
  }
}
