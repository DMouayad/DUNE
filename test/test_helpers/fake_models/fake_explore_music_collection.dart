import 'package:dune/domain/audio/base_models/base_explore_music_collection.dart';
import 'package:dune/support/enums/music_source.dart';
import 'package:faker/faker.dart';

import '../base_model_factory.dart';
import 'fake_explore_music_item.dart';

final class FakeExploreMusicCollection
    extends BaseExploreMusicCollection<FakeExploreMusicItem> {
  const FakeExploreMusicCollection({
    required super.isTrending,
    required super.title,
    required super.items,
    required super.source,
  });
}

final class FakeExploreMusicCollectionFactory
    extends BaseModelFactory<FakeExploreMusicCollection> {
  FakeExploreMusicCollectionFactory() {
    _isTrending = _title = _source = _items = null;
  }

  late final bool? _isTrending;
  late final String? _title;
  late final List<FakeExploreMusicItem>? _items;
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

  FakeExploreMusicCollectionFactory setMusicSource(MusicSource source) {
    return _copyWith(source: source);
  }

  FakeExploreMusicCollectionFactory setYoutubeAsSource() {
    return _copyWith(source: MusicSource.youtube);
  }

  FakeExploreMusicCollectionFactory setIsTrending(bool trending) {
    return _copyWith(isTrending: trending);
  }

  FakeExploreMusicCollectionFactory setItemsCount(int count) {
    return _copyWith(
      items: FakeExploreMusicItemFactory()
          .withSource(_source)
          .createCount(faker.randomGenerator.integer(count)),
    );
  }

  FakeExploreMusicCollectionFactory _copyWith({
    bool? isTrending,
    String? title,
    List<FakeExploreMusicItem>? items,
    MusicSource? source,
  }) {
    return FakeExploreMusicCollectionFactory._(
      isTrending: isTrending ?? _isTrending,
      title: title ?? _title,
      items: items ?? _items,
      source: source ?? _source,
    );
  }

  FakeExploreMusicCollectionFactory._({
    required bool? isTrending,
    required String? title,
    required List<FakeExploreMusicItem>? items,
    required MusicSource? source,
  })  : _isTrending = isTrending,
        _title = title,
        _items = items,
        _source = source;
}
