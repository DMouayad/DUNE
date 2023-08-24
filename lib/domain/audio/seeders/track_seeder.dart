import 'package:dune/domain/audio/base_models/base_track.dart';
import 'package:dune/domain/audio/factories/track_factory.dart';
import 'package:dune/domain/audio/repositories/track_repository.dart';

final class TrackSeeder {
  final SavableTrackRepository _repository;

  TrackSeeder(this._repository);

  Future<BaseTrack?> seedOne([TrackFactory? trackFactory]) async {
    return (await _repository.save((trackFactory ?? TrackFactory()).create()))
        .mapTo(
      onFailure: (_) => null,
      onSuccess: (savedTrack) => savedTrack,
    );
  }

  Future<List<BaseTrack>> seedCount(
    int count, [
    TrackFactory? trackFactory,
  ]) async {
    final factory = trackFactory ?? TrackFactory();
    return (await _repository.saveAll(factory.createCount(count))).mapTo(
      onFailure: (_) => [],
      onSuccess: (savedTracks) => savedTracks,
    );
  }
}
