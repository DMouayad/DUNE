import 'package:dune/domain/audio/base_models/base_explore_music_item.dart';
import 'package:dune/domain/audio/base_models/thumbnails_set.dart';
import 'package:dune/support/enums/music_source.dart';
import 'package:faker/faker.dart';
import '../base_model_factory.dart';
import 'fake_track.dart';

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

  FakeExploreMusicItem _copyWith({
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

final class FakeExploreMusicItemFactory
    extends BaseModelFactory<FakeExploreMusicItem> {
  FakeExploreMusicItemFactory._(
    this._type,
    this._source,
    this._title,
    this._sourceId,
    this._thumbnails,
    this._count,
    this._description,
  );

  FakeExploreMusicItemFactory withSource(MusicSource? source) {
    return _copyWith(source: source);
  }

  FakeExploreMusicItemFactory withType(ExploreMusicItemType type) {
    return _copyWith(type: type);
  }

  bool get hasTrack =>
      [ExploreMusicItemType.video, ExploreMusicItemType.audio].contains(_type);

  FakeExploreMusicItemFactory() {
    _type = _title =
        _sourceId = _thumbnails = _count = _description = _source = null;
  }

  late final ExploreMusicItemType? _type;
  late final MusicSource? _source;
  late final String? _title;
  late final String? _sourceId;
  late final ThumbnailsSet? _thumbnails;
  late final String? _count;
  late final String? _description;

  @override
  FakeExploreMusicItem create() {
    final source = _source ??
        faker.randomGenerator.element(MusicSource.valuesWithoutUnknown);
    return FakeExploreMusicItem(
      type: _type ?? faker.randomGenerator.element(ExploreMusicItemType.values),
      title: _title ?? faker.lorem.sentence(),
      sourceId: _sourceId ?? faker.lorem.word(),
      thumbnails: _thumbnails ?? const ThumbnailsSet(),
      count: _count ??
          (hasTrack ? null : faker.randomGenerator.integer(100).toString()),
      description: _description ?? faker.lorem.sentences(2).join('\n'),
      source: source!,
      track:
          hasTrack ? FakeTrackFactory().setMusicSource(source).create() : null,
    );
  }

  FakeExploreMusicItemFactory _copyWith({
    ExploreMusicItemType? type,
    MusicSource? source,
    String? title,
    String? sourceId,
    ThumbnailsSet? thumbnails,
    String? count,
    String? description,
  }) {
    return FakeExploreMusicItemFactory._(
      type ?? _type,
      source ?? _source,
      title ?? _title,
      sourceId ?? _sourceId,
      thumbnails ?? _thumbnails,
      count ?? _count,
      description ?? _description,
    );
  }
}
