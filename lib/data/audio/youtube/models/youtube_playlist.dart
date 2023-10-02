import 'package:dune/domain/audio/base_models/base_playlist.dart';
import 'package:dune/domain/audio/base_models/thumbnails_set.dart';
import 'package:dune/support/enums/music_source.dart';
import 'package:dune/support/extensions/extensions.dart';

import 'youtube_track.dart';

class YoutubePlaylist extends BasePlaylist {
  const YoutubePlaylist({
    required super.id,
    required super.author,
    required super.description,
    required super.duration,
    required super.durationSeconds,
    required super.thumbnails,
    required super.title,
    required super.tracks,
    super.createdAt,
  }) : super(musicSource: MusicSource.youtube);

  @override
  Set<Type> get derived => {BasePlaylist};

  factory YoutubePlaylist.fromMap(Map<String?, dynamic> map) {
    final tracksDataList = map.whereKey('tracks');
    final authorData = map.whereKey('author');

    return YoutubePlaylist(
      author: authorData is String
          ? PlaylistAuthor(name: authorData)
          : authorData is Map<String, dynamic>
              ? PlaylistAuthor.fromMap(authorData)
              : null,
      description: map.whereKey("description") ?? '',
      duration: map.whereKey("duration"),
      durationSeconds: map.whereKey("duration_seconds"),
      id: map.whereKey("id") ??
          map.whereKey("playlistId") ??
          map.whereKey("browseId"),
      thumbnails: ThumbnailsSet.fromThumbnailsListWithUnknownQuality(
              (map['thumbnails'] as List)
                  .map((e) => BaseThumbnail.fromMap(e))
                  .toList())
          .setIsNetwork(true),
      title: map["title"],
      tracks:
          tracksDataList is Iterable ? _getPlaylistTracks(tracksDataList) : [],
      createdAt: () {
        if (map.whereKey("year") != null) {
          final year = int.tryParse(map["year"]);
          if (year is int) return DateTime(year);
        }
      }(),
    );
  }

  static List<YoutubeTrack> _getPlaylistTracks(Iterable tracksDataList) {
    final List<YoutubeTrack> tracks = [];
    for (var trackMap in tracksDataList) {
      if (trackMap is Map<String, dynamic> &&
          trackMap.whereKey('videoId') != null) {
        tracks.add(YoutubeTrack.fromMap(trackMap));
      }
    }
    return tracks;
  }
}
