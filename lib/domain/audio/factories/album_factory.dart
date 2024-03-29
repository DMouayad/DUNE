import 'package:faker/faker.dart';

//
import 'package:dune/domain/audio/base_models/base_album.dart';
import 'package:dune/domain/audio/base_models/base_artist.dart';
import 'package:dune/domain/audio/base_models/base_track.dart';
import 'package:dune/domain/audio/base_models/thumbnails_set.dart';
import 'package:dune/domain/audio/factories/track_factory.dart';
import 'package:dune/support/enums/music_source.dart';

import '../../base_model_factory.dart';

final class AlbumFactory extends BaseModelFactory<BaseAlbum> {
  late final String? _id;
  late final String? _browseId;
  late final String? _category;
  late final String? _duration;
  late final bool? _isExplicit;
  late final String? _title;
  late final String? _type;
  late final DateTime? _releaseDate;
  late final ThumbnailsSet? _thumbnails;
  late final List<BaseArtist>? _artists;
  late final BaseArtist? _albumArtist;
  late final List<BaseTrack>? _tracks;
  late final MusicSource? _musicSource;

  AlbumFactory() {
    _id = _browseId = _category = _duration = _isExplicit = _musicSource =
        _title = _type = _releaseDate =
            _thumbnails = _artists = _albumArtist = _tracks = null;
  }

  @override
  BaseAlbum create() {
    return BaseAlbum(
      id: _id ??
          faker.randomGenerator.string(15, min: 6) + faker.address.citySuffix(),
      musicSource: _musicSource ??
          faker.randomGenerator.element(MusicSource.valuesWithoutUnknown),
      artists: _artists ?? [],
      albumArtist: _albumArtist,
      browseId:
          _browseId ?? faker.randomGenerator.string(20) + faker.lorem.word(),
      category: _category,
      duration: _duration ?? faker.lorem.sentence(),
      isExplicit: _isExplicit ?? faker.randomGenerator.boolean(),
      thumbnails: _thumbnails ?? const ThumbnailsSet(),
      title: _title ?? faker.lorem.sentence(),
      type: _type ?? faker.lorem.word(),
      tracks: _tracks ?? [],
      releaseDate: _releaseDate ?? faker.date.dateTime(),
    );
  }

  AlbumFactory _copyWith({
    String? id,
    String? browseId,
    String? category,
    String? duration,
    bool? isExplicit,
    String? title,
    String? type,
    DateTime? releaseDate,
    ThumbnailsSet? thumbnails,
    List<BaseArtist>? artists,
    List<BaseTrack>? tracks,
    MusicSource? musicSource,
    BaseArtist? albumArtist,
  }) {
    return AlbumFactory._(
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
      musicSource: musicSource ?? _musicSource,
      albumArtist: albumArtist ?? _albumArtist,
    );
  }

  AlbumFactory setTracks(List<BaseTrack> tracks) {
    return _copyWith(tracks: tracks);
  }

  AlbumFactory setTracksCount(int? count) {
    return _copyWith(
      tracks: count == null ? [] : TrackFactory().createCount(count),
    );
  }

  AlbumFactory setMusicSource(MusicSource? source) {
    return _copyWith(musicSource: source);
  }

  AlbumFactory setArtists(List<BaseArtist> artists) {
    return _copyWith(artists: artists);
  }

  AlbumFactory._({
    required String? id,
    required String? browseId,
    required String? category,
    required String? duration,
    required bool? isExplicit,
    required String? title,
    required String? type,
    required DateTime? releaseDate,
    required ThumbnailsSet? thumbnails,
    required List<BaseArtist>? artists,
    required BaseArtist? albumArtist,
    required List<BaseTrack>? tracks,
    required MusicSource? musicSource,
  })  : _id = id,
        _browseId = browseId,
        _category = category,
        _duration = duration,
        _isExplicit = isExplicit,
        _title = title,
        _type = type,
        _albumArtist = albumArtist,
        _releaseDate = releaseDate,
        _thumbnails = thumbnails,
        _artists = artists,
        _musicSource = musicSource,
        _tracks = tracks;

  AlbumFactory setAlbumArtist(BaseArtist artist) {
    return _copyWith(albumArtist: artist);
  }
}
