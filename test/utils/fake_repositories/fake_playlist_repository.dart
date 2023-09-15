import 'package:dune/domain/audio/base_data_sources/base_playlist_data_source.dart';
import 'package:dune/domain/audio/base_models/base_playlist.dart';
import 'package:dune/domain/audio/repositories/playlist_repository.dart';
import 'package:dune/support/utils/result/result.dart';

final class FakePlaylistRepository extends PlaylistRepository {
  FakePlaylistRepository({
    required FutureOrResult<BasePlaylist?> findPlaylistResult,
    required FutureOrResult<List<BasePlaylist>?> getCategoryPlaylistsResult,
  }) : super(
          FakePlaylistDataSource(
              findPlaylistResult, getCategoryPlaylistsResult),
        );
}

final class FakePlaylistDataSource
    extends BasePlaylistDataSource<BasePlaylist> {
  const FakePlaylistDataSource(
    this.findPlaylistResult,
    this.getCategoryPlaylistsResult,
  );

  final FutureOrResult<BasePlaylist?> findPlaylistResult;
  final FutureOrResult<List<BasePlaylist>?> getCategoryPlaylistsResult;

  @override
  FutureOrResult<BasePlaylist?> find(String playlistId) async {
    return await findPlaylistResult;
  }

  @override
  FutureOrResult<List<BasePlaylist>?> getCategoryPlaylists(
      String categoryId) async {
    return await getCategoryPlaylistsResult;
  }
}
