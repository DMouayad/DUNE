import 'package:dune/domain/audio/base_models/base_explore_music_item.dart';
import 'package:dune/support/enums/music_source.dart';
import 'package:equatable/equatable.dart';

abstract class BaseExploreMusicCollection<T extends BaseExploreMusicItem>
    extends Equatable {
  final bool isTrending;
  final String title;
  final List<T> items;
  final MusicSource source;

  @override
  List<Object?> get props => [
        isTrending,
        title,
        items,
        source,
      ];

  const BaseExploreMusicCollection({
    required this.isTrending,
    required this.title,
    required this.items,
    required this.source,
  });

  Map<String, dynamic> toMap() {
    return {
      'isTrending': isTrending,
      'title': title,
      'items': items.map((e) => e.toMap()).toList(),
      'source': source.name,
    };
  }
}
