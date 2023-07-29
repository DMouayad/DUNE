import 'package:dune/domain/audio/base_models/audio_info_set.dart';
import 'package:dune/domain/audio/base_models/base_track.dart';
import 'package:dune/domain/audio/base_models/thumbnails_set.dart';
import 'package:dune/domain/audio/base_models/track_audio_info.dart';
import 'package:dune/support/enums/music_source.dart';
import 'package:faker/faker.dart';

import '../base_model_factory.dart';
import '../factories/thumbnail_set_factory.dart';
import 'fake_album.dart';
import 'fake_artist.dart';
import '../factories/audio_info_set_factory.dart';

final class FakeTrack extends BaseTrack<FakeAlbum, FakeArtist> {
  const FakeTrack({
    required super.id,
    required super.album,
    required super.artists,
    required super.thumbnails,
    required super.title,
    required super.year,
    required super.views,
    required super.category,
    required super.duration,
    required super.isExplicit,
    required super.audioInfoSet,
    required super.source,
  });

  @override
  T copyWith<T extends BaseTrack>({
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
  }) {
    return FakeTrack(
      id: id ?? this.id,
      audioInfoSet: audioInfoSet ?? this.audioInfoSet,
      album: album ?? this.album,
      artists: artists ?? this.artists,
      duration: duration ?? this.duration,
      title: title ?? this.title,
      year: year ?? this.year,
      views: views ?? this.views,
      category: category ?? this.category,
      isExplicit: isExplicit ?? this.isExplicit,
      thumbnails: thumbnails ?? this.thumbnails,
      source: source ?? this.source,
    ) as T;
  }
}

final class FakeTrackFactory extends BaseModelFactory<FakeTrack> {
  late final String? _id;
  late final AudioInfoSet? _audioInfoSet;
  late final FakeAlbum? _album;
  late final List<FakeArtist>? _artists;
  late final Duration? _duration;
  late final String? _likeStatus;
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

  FakeTrackFactory() {
    _id = _audioInfoSet = _album = _artists = _duration = _likeStatus = _title =
        _year = _views = _category = _isExplicit = _thumbnails = _source = null;
    _artistsToCreateCount = 1;
    _shouldCreateAudioInfoSet = _shouldCreateAlbum = true;
  }

  @override
  FakeTrack create() {
    final source = _source ??
        faker.randomGenerator.element(MusicSource.valuesWithoutUnknown);

    final fakeTrack = FakeTrack(
      id: _id ?? faker.lorem.random.string(20),
      audioInfoSet: _audioInfoSet ??
          (source!.isLocal || _shouldCreateAudioInfoSet
              ? AudioInfoSetFactory().setItems(4, source).create()
              : null),
      album: null,
      artists: const [],
      duration:
          _duration ?? Duration(seconds: faker.randomGenerator.integer(400)),
      title: _title ?? faker.lorem.sentence(),
      year: _year ?? faker.date.year(),
      views: _views ?? faker.randomGenerator.integer(9999),
      category: _category,
      isExplicit: _isExplicit ?? faker.randomGenerator.boolean(),
      thumbnails: _thumbnails ?? ThumbnailsSetFactory().create(),
      source: source!,
    );
    List<FakeArtist> artistsFinal =
        _artists ?? FakeArtistFactory().createCount(_artistsToCreateCount);
    final album =
        _album ?? (_shouldCreateAlbum ? FakeAlbumFactory().create() : null);
    return fakeTrack.copyWith(album: album, artists: artistsFinal);
  }

  FakeTrackFactory withAlbum({FakeAlbum? album}) {
    return _copyWith(shouldCreateAlbum: true, album: album);
  }

  FakeTrackFactory withArtists({List<FakeArtist>? artists, int count = 1}) {
    return _copyWith(artistsToCreateCount: count, artists: artists);
  }

  FakeTrackFactory _copyWith({
    String? id,
    AudioInfoSet? audioInfoSet,
    FakeAlbum? album,
    List<FakeArtist>? artists,
    Duration? duration,
    String? likeStatus,
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
    return FakeTrackFactory._(
      id: id ?? _id,
      audioInfoSet: audioInfoSet ?? _audioInfoSet,
      album: album ?? _album,
      artists: artists ?? _artists,
      duration: duration ?? _duration,
      likeStatus: likeStatus ?? _likeStatus,
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

  FakeTrackFactory setMusicSource(MusicSource? source) {
    return _copyWith(source: source);
  }

  FakeTrackFactory withAudioInfo([List<TrackAudioInfo>? trackAudioInfo]) {
    return _copyWith(
      shouldCreateAudioInfoSet: true,
      audioInfoSet:
          trackAudioInfo != null ? AudioInfoSet(items: trackAudioInfo) : null,
    );
  }

  FakeTrackFactory withoutAudioInfo() {
    return _copyWith(
      // we specify the source as either (youtube or spotify) so
      // no AudioInfoSet will be set for track in case of "randomly" giving it
      // a source of [MusicSource.local]
      source: faker.randomGenerator
          .element([MusicSource.youtube, MusicSource.spotify]),
      shouldCreateAudioInfoSet: false,
    );
  }

  FakeTrackFactory._({
    required MusicSource? source,
    required String? id,
    required AudioInfoSet? audioInfoSet,
    required FakeAlbum? album,
    required List<FakeArtist>? artists,
    required Duration? duration,
    required String? likeStatus,
    required String? title,
    required String? year,
    required int? views,
    required String? category,
    required bool? isExplicit,
    required ThumbnailsSet? thumbnails,
    int artistsToCreateCount = 1,
    bool shouldCreateAlbum = true,
    bool shouldCreateAudioInfoSet = true,
  })  : _id = id,
        _audioInfoSet = audioInfoSet,
        _album = album,
        _artists = artists,
        _duration = duration,
        _likeStatus = likeStatus,
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
