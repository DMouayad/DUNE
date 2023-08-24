import 'package:dune/domain/audio/base_models/base_album.dart';
import 'package:dune/domain/audio/base_models/base_artist.dart';
import 'package:dune/domain/audio/base_models/base_track.dart';
import 'package:dune/domain/audio/base_models/thumbnails_set.dart';
import 'package:dune/support/enums/music_source.dart';

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
    required super.musicSource,
  });

  @override
  BaseAlbum copyWith({
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
    List<BaseTrack<BaseAlbum, BaseArtist>>? tracks,
    MusicSource? musicSource,
  }) {
    return FakeAlbum(
      id: id ?? this.id,
      browseId: browseId ?? this.browseId,
      category: category ?? this.category,
      duration: duration ?? this.duration,
      isExplicit: isExplicit ?? this.isExplicit,
      title: title ?? this.title,
      type: type ?? this.type,
      releaseDate: releaseDate ?? this.releaseDate,
      thumbnails: thumbnails ?? this.thumbnails,
      artists: artists ?? this.artists,
      tracks: tracks ?? this.tracks,
      musicSource: musicSource ?? this.musicSource,
    );
  }
}
