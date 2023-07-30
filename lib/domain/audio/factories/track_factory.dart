import 'package:dune/domain/audio/base_models/audio_info_set.dart';
import 'package:dune/domain/audio/base_models/thumbnails_set.dart';
import 'package:dune/domain/audio/base_models/track_audio_info.dart';
import 'package:dune/domain/audio/fake_models/fake_album.dart';
import 'package:dune/domain/audio/fake_models/fake_artist.dart';
import 'package:dune/domain/audio/fake_models/fake_track.dart';
import 'package:dune/support/enums/music_source.dart';
import 'package:faker/faker.dart';

import 'audio_info_set_factory.dart';
import 'album_factory.dart';
import 'artist_factory.dart';
import 'base_model_factory.dart';
import 'thumbnail_set_factory.dart';

final class TrackFactory extends BaseModelFactory<FakeTrack> {
  late final String? _id;
  late final AudioInfoSet? _audioInfoSet;
  late final FakeAlbum? _album;
  late final List<FakeArtist>? _artists;
  late final Duration? _duration;
  late final String? _title;
  late final String? _year;
  late final int? _views;
  late final String? _category;
  late final bool? _isExplicit;
  late final ThumbnailsSet? _thumbnails;
  late final MusicSource? _source;
  late final int _artistsToCreateCount;
  late final bool _shouldCreateAlbum;
  late final bool _shouldCreateAudioInfoSet;

  ArtistFactory get _artistFactory => ArtistFactory();

  AlbumFactory get _albumFactory => AlbumFactory();

  TrackFactory() {
    _id = _audioInfoSet = _album = _artists = _duration = _title =
        _year = _views = _category = _isExplicit = _thumbnails = _source = null;
    _artistsToCreateCount = 1;
    _shouldCreateAudioInfoSet = _shouldCreateAlbum = true;
  }

  @override
  FakeTrack create() {
    final source = _source ??
        faker.randomGenerator.element(MusicSource.valuesWithoutUnknown);
    return FakeTrack(
      id: _id ??
          faker.lorem.random.string(20, min: 6) +
              faker.randomGenerator.numberOfLength(3),
      audioInfoSet: _audioInfoSet ??
          (source!.isLocal || _shouldCreateAudioInfoSet
              ? AudioInfoSetFactory().setItems(4, source).create()
              : null),
      duration:
          _duration ?? Duration(seconds: faker.randomGenerator.integer(400)),
      title: _title ?? faker.lorem.sentence(),
      year: _year ?? faker.date.year(),
      views: _views ?? faker.randomGenerator.integer(9999),
      category: _category,
      isExplicit: _isExplicit ?? faker.randomGenerator.boolean(),
      thumbnails: _thumbnails ?? ThumbnailsSetFactory().create(),
      artists: _artists ?? _artistFactory.createCount(_artistsToCreateCount),
      album: _album ?? (_shouldCreateAlbum ? _albumFactory.create() : null),
      source: source!,
    );
  }

  TrackFactory withAlbum({FakeAlbum? album}) {
    return _copyWith(shouldCreateAlbum: true, album: album);
  }

  TrackFactory withArtists({
    List<FakeArtist>? artists,
    int count = 1,
  }) {
    return _copyWith(artistsToCreateCount: count, artists: artists);
  }

  TrackFactory _copyWith({
    String? id,
    AudioInfoSet? audioInfoSet,
    FakeAlbum? album,
    List<FakeArtist>? artists,
    Duration? duration,
    String? title,
    String? year,
    int? views,
    String? category,
    bool? isExplicit,
    ThumbnailsSet? thumbnails,
    MusicSource? source,
    int? artistsToCreateCount,
    bool? shouldCreateAlbum,
    bool? shouldCreateAudioInfoSet,
  }) {
    return TrackFactory._(
      id: id ?? _id,
      audioInfoSet: audioInfoSet ?? _audioInfoSet,
      album: album ?? _album,
      artists: artists ?? _artists,
      duration: duration ?? _duration,
      title: title ?? _title,
      year: year ?? _year,
      views: views ?? _views,
      category: category ?? _category,
      isExplicit: isExplicit ?? _isExplicit,
      thumbnails: thumbnails ?? _thumbnails,
      source: source ?? _source,
      artistsToCreateCount: artistsToCreateCount ?? _artistsToCreateCount,
      shouldCreateAudioInfoSet:
          shouldCreateAudioInfoSet ?? _shouldCreateAudioInfoSet,
      shouldCreateAlbum: shouldCreateAlbum ?? _shouldCreateAlbum,
    );
  }

  TrackFactory setMusicSource(MusicSource? source) {
    return _copyWith(source: source);
  }

  TrackFactory withAudioInfo([
    List<TrackAudioInfo>? trackAudioInfo,
  ]) {
    return _copyWith(
      shouldCreateAudioInfoSet: true,
      audioInfoSet:
          trackAudioInfo != null ? AudioInfoSet(items: trackAudioInfo) : null,
    );
  }

  TrackFactory withoutAudioInfo() {
    return _copyWith(
      // we specify the source as either (youtube or spotify) so
      // no AudioInfoSet will be set for track in case of "randomly" giving it
      // a source of [MusicSource.local]
      source: faker.randomGenerator
          .element([MusicSource.youtube, MusicSource.spotify]),
      shouldCreateAudioInfoSet: false,
    );
  }

  TrackFactory._({
    required String? id,
    required AudioInfoSet? audioInfoSet,
    required FakeAlbum? album,
    required List<FakeArtist>? artists,
    required Duration? duration,
    required String? title,
    required String? year,
    required int? views,
    required String? category,
    required bool? isExplicit,
    required ThumbnailsSet? thumbnails,
    required MusicSource? source,
    int artistsToCreateCount = 0,
    bool shouldCreateAlbum = true,
    bool shouldCreateAudioInfoSet = true,
  })  : _id = id,
        _audioInfoSet = audioInfoSet,
        _album = album,
        _artists = artists,
        _duration = duration,
        _title = title,
        _year = year,
        _views = views,
        _category = category,
        _isExplicit = isExplicit,
        _thumbnails = thumbnails,
        _source = source,
        _artistsToCreateCount = artistsToCreateCount,
        _shouldCreateAlbum = shouldCreateAlbum,
        _shouldCreateAudioInfoSet = shouldCreateAudioInfoSet;
}
