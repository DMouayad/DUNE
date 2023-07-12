import 'package:dune/domain/audio/base_models/base_track.dart';

abstract class BaseUserPlaylist {
  final String title;
  final Duration length;
  final Set<({int trackNo, BaseTrack track})> tracks;
  final DateTime createdAt;

  BaseUserPlaylist({
    required this.title,
    required this.length,
    required this.createdAt,
    this.tracks = const {},
  });
}
