import 'package:dune/domain/audio/base_models/base_artist.dart';
import 'package:dune/domain/audio/base_models/thumbnails_set.dart';
import 'package:dune/support/enums/music_source.dart';

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
    required super.musicSource,
  });

  @override
  Set<Type> get derived => {BaseArtist};

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
    MusicSource? musicSource,
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
      musicSource: musicSource ?? this.musicSource,
    );
  }
}
