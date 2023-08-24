import 'package:dune/domain/audio/base_models/base_artist.dart';
import 'package:dune/domain/audio/factories/artist_factory.dart';
import 'package:dune/domain/audio/repositories/artist_repository.dart';

final class ArtistSeeder {
  final SavableArtistRepository _repository;

  ArtistSeeder(this._repository);

  Future<BaseArtist?> seedOne([ArtistFactory? artistFactory]) async {
    return (await _repository.save((artistFactory ?? ArtistFactory()).create()))
        .mapTo(
      onFailure: (_) => null,
      onSuccess: (savedArtist) => savedArtist,
    );
  }

  Future<List<BaseArtist>> seedCount(
    int count, [
    ArtistFactory? artistFactory,
  ]) async {
    final factory = artistFactory ?? ArtistFactory();
    return (await _repository.saveAll(factory.createCount(count))).mapTo(
      onFailure: (_) => [],
      onSuccess: (savedArtists) => savedArtists,
    );
  }
}
