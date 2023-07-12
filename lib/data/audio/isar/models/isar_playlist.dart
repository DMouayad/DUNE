import 'package:dune/domain/audio/base_models/base_playlist.dart';
import 'package:dune/support/enums/music_source.dart';
import 'package:isar/isar.dart';

import 'isar_thumbnails_set.dart';
import 'isar_track.dart';

part 'isar_playlist.g.dart';

@Collection(ignore: {'tracks', 'props', 'derived', 'hashCode', 'stringify'})
class IsarPlaylist extends BasePlaylist<IsarTrack> {
  Id? isarId;
  final List<String> tracksIds;

  @override
  Set<Type> get derived => {BasePlaylist};
  @override
  final IsarPlaylistAuthor? author;
  @override
  final IsarThumbnailsSet thumbnails;

  @override
  @enumerated
  MusicSource get source => super.source;

  @override
  @Index(unique: true, replace: true)
  String? get id => super.id;

  IsarPlaylist({
    super.id,
    this.author,
    this.isarId,
    this.thumbnails = const IsarThumbnailsSet(),
    this.tracksIds = const [],
    super.description = '',
    super.duration = '',
    super.durationSeconds = 0,
    super.title = '',
    super.tracks = const [],
    super.createdAt,
    super.source = MusicSource.youtube,
  }) : super(author: author, thumbnails: thumbnails);

  @override
  String toString() {
    return '${super.toString()} tracksIds:$tracksIds';
  }

  IsarPlaylist copyWith({
    Id? isarId,
    IsarPlaylistAuthor? author,
    IsarThumbnailsSet? thumbnails,
    List<IsarTrack>? tracks,
    String? title,
    String? id,
    String? description,
    String? duration,
    int? durationSeconds,
    MusicSource? source,
    DateTime? createdAt,
    List<String>? tracksIds,
  }) {
    return IsarPlaylist(
      id: id ?? this.id,
      isarId: isarId ?? this.isarId,
      title: title ?? this.title,
      duration: duration ?? this.duration,
      durationSeconds: durationSeconds ?? this.durationSeconds,
      createdAt: createdAt ?? this.createdAt,
      source: source ?? this.source,
      description: description ?? this.description,
      tracks: tracks ?? this.tracks,
      thumbnails: thumbnails ?? this.thumbnails,
      author: author ?? this.author,
      tracksIds: tracksIds ?? this.tracksIds,
    );
  }
}

@Embedded(ignore: {'props', 'derived', 'hashCode', 'stringify'})
class IsarPlaylistAuthor extends PlaylistAuthor {
  @override
  Set<Type> get derived => {PlaylistAuthor};

  IsarPlaylistAuthor({super.id, super.name = ''});
}
