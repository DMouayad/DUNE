import 'package:collection/collection.dart';
import 'package:dune/support/enums/music_source.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import 'base_explore_music_item.dart';
import 'thumbnails_set.dart';
import 'base_track.dart';

class BasePlaylist<T extends BaseTrack> extends Equatable {
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
    required this.musicSource,
  });

  @override
  List<Object?> get props => [
        author,
        thumbnails,
        title,
        tracks,
        createdAt,
        id,
        musicSource,
        description,
        duration,
        durationSeconds
      ];

  @override
  String toString() {
    return '$runtimeType{id: $id, musicSource: $musicSource, author: $author, description: $description, duration: $duration, durationSeconds: $durationSeconds, thumbnails: $thumbnails, title: $title, tracks:[${tracks.map((e) => '${e.runtimeType}(${e.id})')}], createdAt: $createdAt}';
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
  final MusicSource musicSource;

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
      'musicSource': musicSource.name,
    };
  }

  BasePlaylist setIdIfNull() {
    return copyWith(id: id ?? shortHash(title));
  }

  bool hasSameTracksAsOther(BasePlaylist? other) {
    final firstTracksIds = tracks.map((e) => (e.id, e.album?.id)).toList();
    final secondTracksIds =
        other?.tracks.map((e) => (e.id, e.album?.id)).toList();
    return const ListEquality().equals(firstTracksIds, secondTracksIds);
  }

  BasePlaylist copyWith({
    String? id,
    PlaylistAuthor? author,
    String? description,
    String? duration,
    int? durationSeconds,
    ThumbnailsSet? thumbnails,
    String? title,
    List<T>? tracks,
    DateTime? createdAt,
    MusicSource? musicSource,
  }) {
    return BasePlaylist(
      id: id ?? this.id,
      author: author ?? this.author,
      description: description ?? this.description,
      duration: duration ?? this.duration,
      durationSeconds: durationSeconds ?? this.durationSeconds,
      thumbnails: thumbnails ?? this.thumbnails,
      title: title ?? this.title,
      tracks: tracks ?? this.tracks,
      createdAt: createdAt ?? this.createdAt,
      musicSource: musicSource ?? this.musicSource,
    );
  }

  factory BasePlaylist.fromExploreItem(BaseExploreMusicItem exploreItem) {
    return BasePlaylist(
      duration: null,
      title: exploreItem.title,
      musicSource: exploreItem.source,
      id: exploreItem.sourceId,
      thumbnails: exploreItem.thumbnails ?? const ThumbnailsSet(),
      tracks: [],
      description: exploreItem.description ?? '',
      createdAt: null,
      author: null,
      durationSeconds: null,
    );
  }
}

class PlaylistAuthor extends Equatable {
  const PlaylistAuthor({this.id, required this.name});

  final String? id;
  final String? name;

  factory PlaylistAuthor.fromMap(Map<String?, dynamic> map) {
    return PlaylistAuthor(id: map["id"], name: map["name"]);
  }

  Map<String?, dynamic> toMap() => {"id": id, "name": name};

  @override
  List<Object?> get props => [id, name];
}
