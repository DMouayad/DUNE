import 'dart:convert';

import 'package:dune/data/audio/youtube/models/youtube_track.dart';
import 'package:dune/domain/audio/base_models/base_explore_music_item.dart';
import 'package:dune/domain/audio/base_models/thumbnails_set.dart';
import 'package:dune/support/enums/music_source.dart';
import 'package:dune/support/extensions/extensions.dart';

class YoutubeExploreMusicItem extends BaseExploreMusicItem {
  /// indicates that this item is on the trending board.
  final bool isTrending;

  @override
  Set<Type> get derived => {BaseExploreMusicItem};

  const YoutubeExploreMusicItem({
    this.isTrending = false,
    required super.type,
    required super.title,
    required super.sourceId,
    super.thumbnails,
    super.count,
    super.description,
    super.track,
  })  : assert(((type == ExploreMusicItemType.video ||
                    type == ExploreMusicItemType.audio) &&
                track != null) ||
            track == null),
        super(source: MusicSource.youtube);

  factory YoutubeExploreMusicItem.fromJson(String json) {
    return YoutubeExploreMusicItem.fromMap(jsonDecode(json));
  }

  factory YoutubeExploreMusicItem.fromMap(Map<String, dynamic> map) {
    return YoutubeExploreMusicItem(
      isTrending: map.whereKey('isTrending') ?? false,
      type: map.whereKey('type') != null
          ? ExploreMusicItemType.values.byName(map.whereKey('type'))
          : ExploreMusicItemType.unknown,
      track: map.whereKey("track") is Map<String, dynamic>
          ? YoutubeTrack.fromMap(map.whereKey("track"))
          : null,
      title: map['title'] as String,
      sourceId: map['sourceId'] as String,
      thumbnails: ThumbnailsSet.tryFromMap(map.whereKey('thumbnails'))
              ?.setIsNetwork(true) ??
          const ThumbnailsSet(),
      count: map.whereKey('count'),
      description: map.whereKey('description') ?? '',
    );
  }

  factory YoutubeExploreMusicItem.fromApiResponseMap(
    Map<dynamic, dynamic> map,
  ) {
    final itemType = ExploreMusicItemType.values.byName(map['type']);
    final thumbs = _extractThumbnails(map);
    return YoutubeExploreMusicItem(
      isTrending: map.whereKey('isTrending') ?? false,
      type: itemType,
      track: itemType.isVideoOrAudio
          ? YoutubeTrack(
              id: map['sourceId'],
              thumbnails: thumbs,
              title: map['title'] as String,
              year: null,
              views: null,
              category: null,
              duration: Duration(
                seconds: int.tryParse(map.whereKey('durationInSeconds')) ?? 0,
              ),
            )
          : null,
      title: map['title'] as String,
      sourceId: map['sourceId'] as String,
      thumbnails: thumbs,
      count: map.whereKey('count'),
      description: map.whereKey('description') ?? '',
    );
  }

  static ThumbnailsSet _extractThumbnails(Map<dynamic, dynamic> map) {
    return ThumbnailsSet(
      thumbnails: [
        if (map.containsKey('imageStandard'))
          BaseThumbnail(
            isNetwork: true,
            url: map.whereKey('imageStandard'),
            quality: ThumbnailQuality.standard,
          ),
        if (map.containsKey('imageMax'))
          BaseThumbnail(
            isNetwork: true,
            url: map.whereKey('imageMax'),
            quality: ThumbnailQuality.max,
          ),
        if (map.containsKey('imageMedium'))
          BaseThumbnail(
            isNetwork: true,
            url: map.whereKey('imageMedium'),
            quality: ThumbnailQuality.medium,
          ),
      ],
    );
  }
}
