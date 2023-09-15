import 'package:dune/domain/audio/base_models/base_playlist.dart';
import 'package:dune/domain/audio/base_models/thumbnails_set.dart';
import 'package:dune/support/enums/music_source.dart';
import 'package:isar/isar.dart';

import 'isar_thumbnails_set.dart';
import 'isar_track.dart';

part 'isar_playlist.g.dart';

@Collection(ignore: {
  'tracks',
  'thumbnails',
  'props',
  'derived',
  'hashCode',
  'stringify'
})
class IsarPlaylist extends BasePlaylist<IsarTrack> {
  Id? isarId;
  final List<String> tracksIds;

  @override
  Set<Type> get derived => {BasePlaylist};

  @override
  final IsarPlaylistAuthor? author;
  final IsarThumbnailsSet isarThumbnails;

  @override
  @enumerated
  @Index()
  MusicSource get musicSource => super.musicSource;

  @override
  @Index(
      unique: true, replace: true, composite: [CompositeIndex('musicSource')])
  String? get id => super.id;

  IsarPlaylist({
    super.id,
    this.author,
    this.isarId,
    this.isarThumbnails = const IsarThumbnailsSet(),
    this.tracksIds = const [],
    super.description = '',
    super.duration = '',
    super.durationSeconds = 0,
    super.title = '',
    super.tracks = const [],
    super.createdAt,
    super.musicSource = MusicSource.youtube,
  }) : super(author: author, thumbnails: isarThumbnails);

  @override
  String toString() {
    return '${super.toString()} tracksIds:$tracksIds';
  }

  @override
  IsarPlaylist copyWith({
    Id? isarId,
    PlaylistAuthor? author,
    ThumbnailsSet? thumbnails,
    List<IsarTrack>? tracks,
    String? title,
    String? id,
    String? description,
    String? duration,
    int? durationSeconds,
    MusicSource? musicSource,
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
      musicSource: musicSource ?? this.musicSource,
      description: description ?? this.description,
      tracks: tracks ?? this.tracks,
      isarThumbnails: thumbnails != null
          ? IsarThumbnailsSet.fromMap(thumbnails.toMap())
          : isarThumbnails,
      author: author != null
          ? IsarPlaylistAuthor(id: author.id, name: author.name)
          : this.author,
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
