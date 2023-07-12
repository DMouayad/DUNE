import 'package:dune/domain/audio/base_models/base_track.dart';
import 'package:dune/domain/audio/base_models/base_user_playlist.dart';
import 'package:dune/support/utils/result/result.dart';

abstract class BaseUserPlaylistDataSource {
  FutureOrResult<List<BaseUserPlaylist>> getAll();

  FutureOrResult<VoidValue> deletePlaylist(String playlistId);

  FutureOrResult<BaseUserPlaylist> createPlaylist(List<BaseTrack> tracks);
}
