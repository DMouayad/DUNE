import 'dart:convert';

import 'package:dune/domain/audio/base_models/thumbnails_set.dart';
import 'package:dune/support/enums/music_source.dart';
import 'package:equatable/equatable.dart';

import 'base_track.dart';

class BaseExploreMusicItem extends Equatable {
  final ExploreMusicItemType type;
  final String title;
  final String sourceId;
  final ThumbnailsSet? thumbnails;
  final String? count;
  final String? description;
  final MusicSource source;

  /// if [type.isVideoOrAudio] then a track instance should be present for this item.
  final BaseTrack? track;

  const BaseExploreMusicItem({
    required this.type,
    required this.title,
    required this.sourceId,
    required this.thumbnails,
    required this.count,
    required this.description,
    required this.track,
    required this.source,
  });

  Map<String, dynamic> toMap() {
    return {
      'type': type.name,
      'title': title,
      'sourceId': sourceId,
      'thumbnails': thumbnails?.toMap(),
      'count': count,
      'description': description,
      'source': source.name,
      'track': track?.toMap(),
    };
  }

  @override
  List<Object?> get props => [
        type,
        title,
        sourceId,
        thumbnails,
        count,
        description,
        track,
        source,
      ];

  String toJson() {
    return jsonEncode(toMap());
  }

  BaseExploreMusicItem copyWith({
    ExploreMusicItemType? type,
    String? title,
    String? sourceId,
    ThumbnailsSet? thumbnails,
    String? count,
    String? description,
    MusicSource? source,
    BaseTrack? track,
  }) {
    return BaseExploreMusicItem(
      type: type ?? this.type,
      title: title ?? this.title,
      sourceId: sourceId ?? this.sourceId,
      thumbnails: thumbnails ?? this.thumbnails,
      count: count ?? this.count,
      description: description ?? this.description,
      source: source ?? this.source,
      track: track ?? this.track,
    );
  }
}

enum ExploreMusicItemType {
  video,
  playlist,
  chart,
  audio,
  unknown;

  bool get isVideo => this == video;

  bool get isPlaylist => this == playlist;

  bool get isVideoOrAudio => (this == ExploreMusicItemType.video ||
      this == ExploreMusicItemType.audio);
}
