import 'package:collection/collection.dart';
import 'package:dune/support/enums/music_source.dart';
import 'package:equatable/equatable.dart';

import 'thumbnails_set.dart';
import 'base_track.dart';

abstract class BasePlaylist<T extends BaseTrack> extends Equatable {
  const BasePlaylist({
    required this.author,
    required this.description,
    required this.duration,
    required this.durationSeconds,
    required this.thumbnails,
    required this.title,
    required this.tracks,
    required this.createdAt,
    required this.id,
    required this.source,
  });

  @override
  List<Object?> get props => [
        author,
        thumbnails,
        title,
        tracks,
        createdAt,
        id,
        source,
        description,
        duration,
        durationSeconds
      ];

  @override
  String toString() {
    return '$runtimeType{id: $id, source: $source, author: $author, description: $description, duration: $duration, durationSeconds: $durationSeconds, thumbnails: $thumbnails, title: $title, tracks:[${tracks.map((e) => '${e.runtimeType}(${e.id})')}], createdAt: $createdAt}';
  }

  final String? id;
  final PlaylistAuthor? author;
  final String description;
  final String? duration;
  final int? durationSeconds;
  final ThumbnailsSet thumbnails;
  final String? title;
  final List<T> tracks;
  final DateTime? createdAt;
  final MusicSource source;

  Map<String?, dynamic> toMap() {
    return {
      "id": id,
      "author": author?.toMap(),
      "description": description,
      "duration": duration,
      "durationSeconds": durationSeconds,
      "thumbnails": thumbnails.toMap(),
      "title": title,
      "tracks": List.from(tracks.map((x) => x.toMap())),
      "createdAt": createdAt?.toIso8601String(),
      'source': source.name,
    };
  }

  bool hasSameTracksAsOther(BasePlaylist? other) {
    final firstTracksIds = tracks.map((e) => (e.id, e.album?.id)).toList();
    final secondTracksIds =
        other?.tracks.map((e) => (e.id, e.album?.id)).toList();
    return const ListEquality().equals(firstTracksIds, secondTracksIds);
  }
}

class PlaylistAuthor extends Equatable {
  const PlaylistAuthor({this.id, required this.name});

  final String? id;
  final String? name;

  factory PlaylistAuthor.fromJson(Map<String?, dynamic> json) {
    return PlaylistAuthor(id: json["id"], name: json["name"]);
  }

  Map<String?, dynamic> toMap() => {"id": id, "name": name};

  @override
  List<Object?> get props => [id, name];
}
