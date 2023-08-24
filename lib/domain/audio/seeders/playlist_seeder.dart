import 'package:dune/domain/audio/base_models/base_playlist.dart';
import 'package:dune/domain/audio/factories/playlist_factory.dart';
import 'package:dune/domain/audio/repositories/playlist_repository.dart';

final class PlaylistSeeder {
  final SavablePlaylistRepository _repository;

  const PlaylistSeeder(this._repository);

  Future<BasePlaylist?> seedOne({
    int? tracksCount,
    PlaylistFactory? factory,
  }) async {
    final playlistToSeed =
        (factory ?? PlaylistFactory().setTracksCount(tracksCount ?? 0))
            .create();
    return (await _repository.save(playlistToSeed)).mapTo(
      onSuccess: (value) => value,
      onFailure: (_) => null,
    );
  }

  Future<List<BasePlaylist>> seedCount(
    int count, {
    int tracksCount = 1,
    PlaylistFactory? factory,
  }) async {
    final playlistsToSeed =
        (factory ?? PlaylistFactory().setTracksCount(tracksCount))
            .createCount(count);
    return (await _repository.saveAll(playlistsToSeed)).mapTo(
      onSuccess: (value) => value,
      onFailure: (_) => [],
    );
  }
}
