import 'package:dune/domain/audio/base_models/base_album.dart';
import 'package:dune/domain/audio/factories/album_factory.dart';
import 'package:dune/domain/audio/repositories/album_repository.dart';

final class AlbumSeeder {
  final SavableAlbumRepository _repository;

  AlbumSeeder(this._repository);

  Future<BaseAlbum?> seedOne([AlbumFactory? albumFactory]) async {
    return (await _repository.save((albumFactory ?? AlbumFactory()).create()))
        .mapTo(
      onFailure: (_) => null,
      onSuccess: (savedAlbum) => savedAlbum,
    );
  }

  Future<List<BaseAlbum>> seedCount(
    int count, [
    AlbumFactory? albumFactory,
  ]) async {
    final factory = albumFactory ?? AlbumFactory();
    return (await _repository.saveAll(factory.createCount(count))).mapTo(
      onFailure: (_) => [],
      onSuccess: (savedAlbums) => savedAlbums,
    );
  }
}
