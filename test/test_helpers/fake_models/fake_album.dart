import 'package:dune/domain/audio/base_models/base_album.dart';
import 'package:dune/domain/audio/base_models/thumbnails_set.dart';
import 'package:faker/faker.dart';

import '../base_model_factory.dart';
import '../factories/thumbnail_set_factory.dart';
import 'fake_artist.dart';
import 'fake_track.dart';

final class FakeAlbum extends BaseAlbum {
  const FakeAlbum({
    required super.id,
    required super.artists,
    required super.browseId,
    required super.category,
    required super.duration,
    required super.isExplicit,
    required super.thumbnails,
    required super.title,
    required super.type,
    required super.tracks,
    required super.releaseDate,
  });
}

final class FakeAlbumFactory extends BaseModelFactory<FakeAlbum> {
  late final String? _id;
  late final String? _browseId;
  late final String? _category;
  late final String? _duration;
  late final bool? _isExplicit;
  late final String? _title;
  late final String? _type;
  late final DateTime? _releaseDate;
  late final ThumbnailsSet? _thumbnails;
  late final List<FakeArtist>? _artists;
  late final List<FakeTrack>? _tracks;

  FakeAlbumFactory setTracks(List<FakeTrack> tracks) {
    return _copyWith(tracks: tracks);
  }

  @override
  FakeAlbum create() {
    return FakeAlbum(
      id: _id ?? faker.randomGenerator.string(30),
      artists: _artists ?? [],
      browseId:
          _browseId ?? faker.randomGenerator.string(20) + faker.lorem.word(),
      category: _category,
      duration: _duration ?? faker.lorem.sentence(),
      isExplicit: _isExplicit ?? faker.randomGenerator.boolean(),
      thumbnails: _thumbnails ?? ThumbnailsSetFactory().create(),
      title: _title ?? faker.lorem.sentence(),
      type: _type ?? faker.lorem.word(),
      tracks: _tracks ?? [],
      releaseDate: _releaseDate ?? faker.date.dateTime(),
    );
  }

  FakeAlbumFactory() {
    _id = _browseId = _category = _duration = _isExplicit =
        _title = _type = _releaseDate = _thumbnails = _artists = _tracks = null;
  }

  FakeAlbumFactory._({
    required String? id,
    required String? browseId,
    required String? category,
    required String? duration,
    required bool? isExplicit,
    required String? title,
    required String? type,
    required DateTime? releaseDate,
    required ThumbnailsSet? thumbnails,
    required List<FakeArtist>? artists,
    required List<FakeTrack>? tracks,
  })  : _id = id,
        _browseId = browseId,
        _category = category,
        _duration = duration,
        _isExplicit = isExplicit,
        _title = title,
        _type = type,
        _releaseDate = releaseDate,
        _thumbnails = thumbnails,
        _artists = artists,
        _tracks = tracks;

  FakeAlbumFactory _copyWith({
    String? id,
    String? browseId,
    String? category,
    String? duration,
    bool? isExplicit,
    String? title,
    String? type,
    DateTime? releaseDate,
    ThumbnailsSet? thumbnails,
    List<FakeArtist>? artists,
    List<FakeTrack>? tracks,
  }) {
    return FakeAlbumFactory._(
      id: id ?? _id,
      browseId: browseId ?? _browseId,
      category: category ?? _category,
      duration: duration ?? _duration,
      isExplicit: isExplicit ?? _isExplicit,
      title: title ?? _title,
      type: type ?? _type,
      releaseDate: releaseDate ?? _releaseDate,
      thumbnails: thumbnails ?? _thumbnails,
      artists: artists ?? _artists,
      tracks: tracks ?? _tracks,
    );
  }

  FakeAlbumFactory setArtists(List<FakeArtist> artists) {
    return _copyWith(artists: artists);
  }
}
