import 'package:dune/domain/audio/base_models/base_explore_music_collection.dart';
import 'package:dune/domain/audio/base_models/base_explore_music_item.dart';
import 'package:dune/domain/base_model_factory.dart';
import 'package:dune/support/enums/music_source.dart';
import 'package:faker/faker.dart';

import 'explore_music_item_factory.dart';

final class FakeExploreMusicCollection
    extends BaseExploreMusicCollection<BaseExploreMusicItem> {
  const FakeExploreMusicCollection({
    required super.isTrending,
    required super.title,
    required super.items,
    required super.source,
  });
}

final class ExploreMusicCollectionFactory
    extends BaseModelFactory<FakeExploreMusicCollection> {
  ExploreMusicCollectionFactory() {
    _isTrending = _title = _source = _items = null;
  }

  late final bool? _isTrending;
  late final String? _title;
  late final List<BaseExploreMusicItem>? _items;
  late final MusicSource? _source;

  @override
  FakeExploreMusicCollection create() {
    return FakeExploreMusicCollection(
      isTrending: _isTrending ?? faker.randomGenerator.boolean(),
      title: _title ?? faker.lorem.sentence(),
      items: _items ?? const [],
      source: _source ??
          faker.randomGenerator.element(MusicSource.valuesWithoutUnknown),
    );
  }

  ExploreMusicCollectionFactory setMusicSource(MusicSource source) {
    return _copyWith(source: source);
  }

  ExploreMusicCollectionFactory setYoutubeAsSource() {
    return _copyWith(source: MusicSource.youtube);
  }

  ExploreMusicCollectionFactory setIsTrending(bool trending) {
    return _copyWith(isTrending: trending);
  }

  ExploreMusicCollectionFactory setItemsCount(int count) {
    return _copyWith(
      items: ExploreMusicItemFactory()
          .withSource(_source)
          .createCount(faker.randomGenerator.integer(count)),
    );
  }

  ExploreMusicCollectionFactory _copyWith({
    bool? isTrending,
    String? title,
    List<BaseExploreMusicItem>? items,
    MusicSource? source,
  }) {
    return ExploreMusicCollectionFactory._(
      isTrending: isTrending ?? _isTrending,
      title: title ?? _title,
      items: items ?? _items,
      source: source ?? _source,
    );
  }

  ExploreMusicCollectionFactory._({
    required bool? isTrending,
    required String? title,
    required List<BaseExploreMusicItem>? items,
    required MusicSource? source,
  })  : _isTrending = isTrending,
        _title = title,
        _items = items,
        _source = source;
}
