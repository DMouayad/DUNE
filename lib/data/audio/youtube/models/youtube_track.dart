import 'package:dune/domain/audio/base_models/audio_info_set.dart';
import 'package:dune/domain/audio/base_models/base_album.dart';
import 'package:dune/domain/audio/base_models/base_artist.dart';
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
        (map.whereKey('thumbnails') as Iterable)
            .map((e) => BaseThumbnail.fromMap(e))
            .toList(),
      ).setIsNetwork(true),
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

  @override
  YoutubeTrack copyWith({
    String? id,
    AudioInfoSet? audioInfoSet,
    BaseAlbum? album,
    List<BaseArtist>? artists,
    Duration? duration,
    String? title,
    String? year,
    int? views,
    String? category,
    bool? isExplicit,
    ThumbnailsSet? thumbnails,
    MusicSource? source,
  }) {
    return YoutubeTrack(
      id: id ?? this.id,
      audioInfoSet: audioInfoSet ?? this.audioInfoSet,
      album: album ?? this.album,
      artists: artists ?? this.artists,
      duration: duration ?? this.duration,
      title: title ?? this.title,
      year: year ?? this.year,
      views: views ?? this.views,
      category: category ?? this.category,
      isExplicit: isExplicit ?? this.isExplicit,
      thumbnails: thumbnails ?? this.thumbnails,
    );
  }
}
