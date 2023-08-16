import 'package:dune/domain/audio/base_models/thumbnails_set.dart';
import 'package:dune/domain/audio/base_models/base_track.dart';
import 'package:dune/domain/audio/base_models/base_album.dart';
import 'package:dune/support/enums/music_source.dart';
import 'package:equatable/equatable.dart';

abstract class BaseArtist extends Equatable {
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
}
