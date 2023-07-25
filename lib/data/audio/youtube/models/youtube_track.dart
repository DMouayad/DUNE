import 'package:dune/domain/audio/base_models/base_track.dart';
import 'package:dune/domain/audio/base_models/thumbnails_set.dart';
import 'package:dune/support/enums/music_source.dart';
import 'package:dune/support/extensions/extensions.dart';

import 'youtube_album.dart';
import 'youtube_artist.dart';

class YoutubeTrack extends BaseTrack {
  const YoutubeTrack({
    required super.id,
    required super.duration,
    required super.thumbnails,
    required super.title,
    super.views,
    super.category,
    super.year,
    super.album,
    super.artists = const [],
    super.isExplicit = false,
    super.audioInfoSet,
  }) : super(source: MusicSource.youtube);

  @override
  Set<Type> get derived => {BaseTrack};

  factory YoutubeTrack.fromMap(Map<String, dynamic> map) {
    final artistsList = map.whereKey('artists');
    return YoutubeTrack(
      id: map.whereKey('videoId'),
      album: map.whereKey('album') is Map<String, dynamic>
          ? YoutubeAlbum.fromMap(map.whereKey('album'))
          : null,
      artists: artistsList is Iterable
          ? artistsList.map((e) => YoutubeArtist.fromMap(e)).toList()
          : [],
      duration: _getDuration(map.whereKey('duration')),
      thumbnails: ThumbnailsSet.fromThumbnailsListWithUnknownQuality(
        (map.whereKey('thumbnails') as List)
            .map((e) => BaseThumbnail.fromMap(e, isNetwork: true))
            .toList(),
      ),
      title: map.whereKey('title'),
      year: map.whereKey('year'),
      views: map.whereKey('views'),
      category: map.whereKey('category'),
    );
  }

  static Duration _getDuration(String? durationString) {
    if (durationString == null) return Duration.zero;
    if (int.tryParse(durationString) != null) {
      return Duration(seconds: int.parse(durationString));
    }
    if (durationString.contains(':')) {
      final digits = durationString.split(':');

      final seconds = int.parse(digits[1]);
      final minutes = int.tryParse(digits[0]);
      return Duration(seconds: seconds, minutes: minutes ?? 0);
    }
    return Duration.zero;
  }
}
