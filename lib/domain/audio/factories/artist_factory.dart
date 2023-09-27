import 'package:dune/domain/audio/base_models/base_album.dart';
import 'package:dune/domain/audio/base_models/base_artist.dart';
import 'package:dune/domain/audio/base_models/base_track.dart';
import 'package:dune/domain/audio/base_models/thumbnails_set.dart';
import 'package:dune/support/enums/music_source.dart';
import 'package:faker/faker.dart';

import '../../base_model_factory.dart';
import 'thumbnail_set_factory.dart';

final class ArtistFactory extends BaseModelFactory<BaseArtist> {
  late final String? _id;
  late final String? _name;
  late final String? _description;
  late final String? _browseId;
  late final String? _radioId;
  late final String? _shuffleId;
  late final String? _category;
  late final ThumbnailsSet? _thumbnails;
  late final List<BaseTrack>? _tracks;
  late final List<BaseAlbum>? _albums;
  late final MusicSource? _musicSource;

  ArtistFactory() {
    _id = _name = _description = _browseId = _musicSource = _radioId =
        _shuffleId = _category = _thumbnails = _tracks = _albums = null;
  }

  @override
  BaseArtist create() {
    return BaseArtist(
      id: _id ?? faker.randomGenerator.string(20, min: 6) + faker.date.time(),
      musicSource: _musicSource ??
          faker.randomGenerator.element(MusicSource.valuesWithoutUnknown),
      browseId:
          _browseId ?? faker.randomGenerator.string(10) + faker.lorem.word(),
      radioId: _radioId ?? faker.randomGenerator.string(10),
      shuffleId: _shuffleId ?? faker.lorem.word(),
      category: _category ?? faker.food.dish(),
      name: _name ?? faker.person.name() + faker.color.color(),
      description: _description ?? faker.lorem.sentence(),
      thumbnails: _thumbnails ?? ThumbnailsSetFactory().create(),
      tracks: _tracks ?? [],
      albums: _albums ?? [],
    );
  }

  ArtistFactory _copyWith({
    String? id,
    String? name,
    String? description,
    String? browseId,
    String? radioId,
    String? shuffleId,
    String? category,
    ThumbnailsSet? thumbnails,
    List<BaseTrack>? tracks,
    List<BaseAlbum>? albums,
    MusicSource? musicSource,
  }) {
    return ArtistFactory._(
      id: id ?? _id,
      name: name ?? _name,
      description: description ?? _description,
      browseId: browseId ?? _browseId,
      radioId: radioId ?? _radioId,
      shuffleId: shuffleId ?? _shuffleId,
      category: category ?? _category,
      thumbnails: thumbnails ?? _thumbnails,
      musicSource: musicSource ?? _musicSource,
      tracks: tracks ?? _tracks,
      albums: albums ?? _albums,
    );
  }

  ArtistFactory setTracks(List<BaseTrack> tracks) {
    return _copyWith(tracks: tracks);
  }

  ArtistFactory setAlbums(List<BaseAlbum> albums) {
    return _copyWith(albums: albums);
  }

  ArtistFactory setMusicSource(MusicSource? musicSource) {
    return _copyWith(musicSource: musicSource);
  }

  ArtistFactory._({
    required String? id,
    required String? name,
    required String? description,
    required String? browseId,
    required String? radioId,
    required String? shuffleId,
    required String? category,
    required ThumbnailsSet? thumbnails,
    required List<BaseTrack>? tracks,
    required List<BaseAlbum>? albums,
    required MusicSource? musicSource,
  })  : _id = id,
        _name = name,
        _description = description,
        _browseId = browseId,
        _radioId = radioId,
        _shuffleId = shuffleId,
        _category = category,
        _thumbnails = thumbnails,
        _tracks = tracks,
        _musicSource = musicSource,
        _albums = albums;
}
