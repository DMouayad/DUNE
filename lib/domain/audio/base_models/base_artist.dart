import 'package:dune/domain/audio/base_models/thumbnails_set.dart';
import 'package:dune/domain/audio/base_models/base_track.dart';
import 'package:dune/domain/audio/base_models/base_album.dart';
import 'package:dune/support/enums/music_source.dart';
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

  BaseArtist setIdIfNull() {
    return copyWith(id: id ?? shortHash(name));
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
    return BaseArtist(
      id: map['id'] as String,
      name: map['name'] as String,
      description: map['description'] as String,
      browseId: map['browseId'] as String,
      radioId: map['radioId'] as String,
      shuffleId: map['shuffleId'] as String,
      category: map['category'] as String,
      thumbnails: map['thumbnails'] as ThumbnailsSet,
      tracks: map['tracks'] as List<BaseTrack>,
      albums: map['albums'] as List<BaseAlbum>,
      musicSource: map['musicSource'] as MusicSource,
    );
  }
}
