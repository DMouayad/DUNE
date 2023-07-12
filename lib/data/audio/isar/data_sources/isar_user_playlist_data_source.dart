import 'package:isar/isar.dart';

//
import 'package:dune/domain/audio/base_data_sources/base_user_playlist_data_source.dart';
import 'package:dune/domain/audio/base_models/base_track.dart';
import 'package:dune/support/utils/result/result.dart';

import '../models/isar_user_playlist.dart';

class IsarUserPlaylistDataSource extends BaseUserPlaylistDataSource {
  final Isar _isar;

  IsarUserPlaylistDataSource(this._isar);

  @override
  FutureOrResult<List<IsarUserPlaylist>> getAll() async {
    return await Result.fromAsync(() async {
      return _isar.isarUserPlaylists.where().anyId().findAll();
    });
  }

  @override
  FutureOrResult<VoidValue> deletePlaylist(String playlistId) {
    // TODO: implement deletePlaylist
    throw UnimplementedError();
  }

  @override
  FutureOrResult<IsarUserPlaylist> createPlaylist(List<BaseTrack> tracks) {
    // TODO: implement createPlaylist
    throw UnimplementedError();
  }
}
