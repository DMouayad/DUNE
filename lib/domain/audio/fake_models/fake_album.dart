import 'package:dune/domain/audio/base_models/base_album.dart';

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
