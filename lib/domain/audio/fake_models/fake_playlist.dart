import 'package:dune/domain/audio/base_models/base_playlist.dart';

final class FakePlaylist extends BasePlaylist {
  const FakePlaylist({
    required super.author,
    required super.description,
    required super.duration,
    required super.durationSeconds,
    required super.thumbnails,
    required super.title,
    required super.tracks,
    required super.createdAt,
    required super.id,
    required super.source,
  });

  @override
  Set<Type> get derived => {BasePlaylist};
}
