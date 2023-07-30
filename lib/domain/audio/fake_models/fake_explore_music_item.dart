import 'package:dune/domain/audio/base_models/base_explore_music_item.dart';
import 'package:dune/domain/audio/base_models/thumbnails_set.dart';
import 'package:dune/support/enums/music_source.dart';

final class FakeExploreMusicItem extends BaseExploreMusicItem {
  const FakeExploreMusicItem({
    required super.type,
    required super.title,
    required super.sourceId,
    required super.thumbnails,
    required super.count,
    required super.description,
    required super.track,
    required super.source,
  });

  FakeExploreMusicItem copyWith({
    ExploreMusicItemType? type,
    String? title,
    String? sourceId,
    ThumbnailsSet? thumbnails,
    String? count,
    String? description,
    MusicSource? source,
    // BaseTrack? track,
  }) {
    return FakeExploreMusicItem(
      type: type ?? this.type,
      title: title ?? this.title,
      sourceId: sourceId ?? this.sourceId,
      thumbnails: thumbnails ?? this.thumbnails,
      count: count ?? this.count,
      description: description ?? this.description,
      source: source ?? this.source,
      track: track,
    );
  }
}
