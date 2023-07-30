import 'package:dune/domain/audio/base_models/audio_info_set.dart';
import 'package:dune/domain/audio/base_models/base_track.dart';
import 'package:dune/domain/audio/base_models/thumbnails_set.dart';
import 'package:dune/support/enums/music_source.dart';
import 'fake_album.dart';
import 'fake_artist.dart';

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
  Set<Type> get derived => {BaseTrack};

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
