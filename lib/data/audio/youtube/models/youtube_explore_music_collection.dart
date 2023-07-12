import 'package:dune/domain/audio/base_models/base_explore_music_collection.dart';
import 'package:dune/support/enums/music_source.dart';
import 'package:dune/support/extensions/extensions.dart';

import 'youtube_explore_music_item.dart';

class YoutubeExploreMusicCollection
    extends BaseExploreMusicCollection<YoutubeExploreMusicItem> {
  const YoutubeExploreMusicCollection({
    required super.isTrending,
    required super.title,
    required super.items,
  }) : super(source: MusicSource.youtube);

  @override
  Set<Type> get derived => {BaseExploreMusicCollection};

  factory YoutubeExploreMusicCollection.fromMap(Map<String, dynamic> map) {
    final itemsMap = map['items'];
    return YoutubeExploreMusicCollection(
      isTrending: map.whereKey('isTrending') ?? false,
      title: map['title'] as String,
      items: itemsMap is Iterable
          ? (itemsMap)
              .map((e) => YoutubeExploreMusicItem.fromApiResponseMap(e))
              .toList()
          : [],
    );
  }
}
