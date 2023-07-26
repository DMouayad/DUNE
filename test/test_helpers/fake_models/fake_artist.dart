import 'package:dune/domain/audio/base_models/base_artist.dart';
import 'package:dune/domain/audio/base_models/thumbnails_set.dart';
import 'package:faker/faker.dart';

import '../base_model_factory.dart';
import '../factories/thumbnail_set_factory.dart';
import 'fake_album.dart';
import 'fake_track.dart';

final class FakeArtist extends BaseArtist {
  const FakeArtist({
    required super.id,
    required super.browseId,
    required super.radioId,
    required super.shuffleId,
    required super.category,
    required super.name,
    required super.description,
    required super.thumbnails,
    required super.tracks,
    required super.albums,
  });

  FakeArtist copyWith({
    String? id,
    String? name,
    String? description,
    String? browseId,
    String? radioId,
    String? shuffleId,
    String? category,
    ThumbnailsSet? thumbnails,
    List<FakeTrack>? tracks,
    List<FakeAlbum>? albums,
  }) {
    return FakeArtist(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      browseId: browseId ?? this.browseId,
      radioId: radioId ?? this.radioId,
      shuffleId: shuffleId ?? this.shuffleId,
      category: category ?? this.category,
      thumbnails: thumbnails ?? this.thumbnails,
      tracks: tracks ?? this.tracks,
      albums: albums ?? this.albums,
    );
  }
}

final class FakeArtistFactory extends BaseModelFactory<FakeArtist> {
  late final String? _id;
  late final String? _name;
  late final String? _description;
  late final String? _browseId;
  late final String? _radioId;
  late final String? _shuffleId;
  late final String? _category;
  late final ThumbnailsSet? _thumbnails;
  late final List<FakeTrack>? _tracks;
  late final List<FakeAlbum>? _albums;

  @override
  FakeArtist create() {
    return FakeArtist(
      id: _id ??
          faker.randomGenerator.string(20) +
              faker.randomGenerator.numberOfLength(20),
      browseId:
          _browseId ?? faker.randomGenerator.string(30) + faker.lorem.word(),
      radioId: _radioId,
      shuffleId: _shuffleId ?? faker.lorem.word(),
      category: _category ?? faker.food.dish(),
      name: _name ?? faker.person.name() + faker.color.color(),
      description: _description ?? faker.lorem.sentence(),
      thumbnails: _thumbnails ?? ThumbnailsSetFactory().create(),
      tracks: _tracks ?? [],
      albums: _albums ?? [],
    );
  }

  FakeArtistFactory() {
    _id = _name = _description = _browseId = _radioId =
        _shuffleId = _category = _thumbnails = _tracks = _albums = null;
  }

  FakeArtistFactory._({
    required String? id,
    required String? name,
    required String? description,
    required String? browseId,
    required String? radioId,
    required String? shuffleId,
    required String? category,
    required ThumbnailsSet? thumbnails,
    required List<FakeTrack>? tracks,
    required List<FakeAlbum>? albums,
  })  : _id = id,
        _name = name,
        _description = description,
        _browseId = browseId,
        _radioId = radioId,
        _shuffleId = shuffleId,
        _category = category,
        _thumbnails = thumbnails,
        _tracks = tracks,
        _albums = albums;

  FakeArtistFactory _copyWith({
    String? id,
    String? name,
    String? description,
    String? browseId,
    String? radioId,
    String? shuffleId,
    String? category,
    ThumbnailsSet? thumbnails,
    List<FakeTrack>? tracks,
    List<FakeAlbum>? albums,
  }) {
    return FakeArtistFactory._(
      id: id ?? _id,
      name: name ?? _name,
      description: description ?? _description,
      browseId: browseId ?? _browseId,
      radioId: radioId ?? _radioId,
      shuffleId: shuffleId ?? _shuffleId,
      category: category ?? _category,
      thumbnails: thumbnails ?? _thumbnails,
      tracks: tracks ?? _tracks,
      albums: albums ?? _albums,
    );
  }

  FakeArtistFactory setTracks(List<FakeTrack> tracks) {
    return _copyWith(tracks: tracks);
  }

  FakeArtistFactory setAlbums(List<FakeAlbum> albums) {
    return _copyWith(albums: albums);
  }
}
