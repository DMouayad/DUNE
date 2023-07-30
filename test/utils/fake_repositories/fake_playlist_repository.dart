import 'package:dune/domain/audio/base_data_sources/base_playlist_data_source.dart';
import 'package:dune/domain/audio/fake_models/fake_playlist.dart';
import 'package:dune/domain/audio/repositories/playlist_repository.dart';
import 'package:dune/support/utils/result/result.dart';

final class FakePlaylistRepository extends PlaylistRepository {
  FakePlaylistRepository({
    required FutureOrResult<FakePlaylist?> findPlaylistResult,
    required FutureOrResult<List<FakePlaylist>?> getCategoryPlaylistsResult,
  }) : super(
          FakePlaylistDataSource(
              findPlaylistResult, getCategoryPlaylistsResult),
        );
}

final class FakePlaylistDataSource
    extends BasePlaylistDataSource<FakePlaylist> {
  const FakePlaylistDataSource(
    this.findPlaylistResult,
    this.getCategoryPlaylistsResult,
  );

  final FutureOrResult<FakePlaylist?> findPlaylistResult;
  final FutureOrResult<List<FakePlaylist>?> getCategoryPlaylistsResult;

  @override
  FutureOrResult<FakePlaylist?> find(String playlistId) async {
    return await findPlaylistResult;
  }

  @override
  FutureOrResult<List<FakePlaylist>?> getCategoryPlaylists(
      String categoryId) async {
    return await getCategoryPlaylistsResult;
  }
}
