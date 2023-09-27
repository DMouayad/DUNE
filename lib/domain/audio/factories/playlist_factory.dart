import 'package:dune/domain/audio/base_models/base_playlist.dart';
import 'package:dune/domain/audio/base_models/base_track.dart';
import 'package:dune/domain/audio/base_models/thumbnails_set.dart';
import 'package:dune/domain/audio/factories/thumbnail_set_factory.dart';
import 'package:dune/support/enums/music_source.dart';
import 'package:faker/faker.dart';

import '../../base_model_factory.dart';
import 'track_factory.dart';

final class PlaylistFactory extends BaseModelFactory<BasePlaylist> {
  late final String? _id;
  late final PlaylistAuthor? _author;
  late final String? _description;
  late final String? _duration;
  late final int? _durationSeconds;
  late final ThumbnailsSet? _thumbnails;
  late final String? _title;
  late final List<BaseTrack>? _tracks;
  late final DateTime? _createdAt;
  late final MusicSource? _source;

  PlaylistFactory() {
    _author = _description = _duration = _thumbnails =
        _durationSeconds = _title = _tracks = _createdAt = _id = _source = null;
  }

  @override
  BasePlaylist create() {
    return BasePlaylist(
      id: _id ?? faker.randomGenerator.string(10),
      author: _author ?? PlaylistAuthor(name: faker.person.name()),
      description: _description ?? faker.lorem.sentence(),
      duration: _duration,
      durationSeconds: _durationSeconds ?? faker.randomGenerator.integer(400),
      thumbnails: _thumbnails ?? ThumbnailsSetFactory().create(),
      title: _title ?? faker.lorem.sentence(),
      tracks: _tracks ?? [],
      createdAt: _createdAt ?? faker.date.dateTime(),
      musicSource: _source ??
          faker.randomGenerator.element(MusicSource.valuesWithoutUnknown),
    );
  }

  PlaylistFactory setMusicSource(MusicSource? source) {
    return _copyWith(source: source);
  }

  PlaylistFactory setTracksCount(int count) {
    return _copyWith(
      // generate a list of [BasePlaylist] each from a fake factory with
      // [MusicSource] set to the current [_source]
      tracks: List.generate(
          count, (index) => TrackFactory().setMusicSource(_source).create()),
    );
  }

  PlaylistFactory _copyWith({
    String? id,
    PlaylistAuthor? author,
    String? description,
    String? duration,
    int? durationSeconds,
    ThumbnailsSet? thumbnails,
    String? title,
    List<BaseTrack>? tracks,
    DateTime? createdAt,
    MusicSource? source,
  }) {
    return PlaylistFactory._(
      id: id ?? _id,
      author: author ?? _author,
      description: description ?? _description,
      duration: duration ?? _duration,
      durationSeconds: durationSeconds ?? _durationSeconds,
      thumbnails: thumbnails ?? _thumbnails,
      title: title ?? _title,
      tracks: tracks ?? _tracks,
      createdAt: createdAt ?? _createdAt,
      source: source ?? _source,
    );
  }

  PlaylistFactory._({
    String? id,
    PlaylistAuthor? author,
    String? description,
    String? duration,
    int? durationSeconds,
    ThumbnailsSet? thumbnails,
    String? title,
    List<BaseTrack>? tracks,
    DateTime? createdAt,
    MusicSource? source,
  })  : _id = id,
        _author = author,
        _description = description,
        _duration = duration,
        _durationSeconds = durationSeconds,
        _thumbnails = thumbnails,
        _title = title,
        _tracks = tracks,
        _createdAt = createdAt,
        _source = source;
}
