import 'package:dune/data/audio/isar/models/isar_track.dart';
import 'package:dune/domain/audio/base_data_sources/base_track_data_source.dart';
import 'package:dune/support/utils/result/result.dart';
import 'package:isar/isar.dart';

class IsarTrackDataSource implements BaseSavableTrackDataSource<IsarTrack> {
  IsarTrackDataSource(this._isar);

  final Isar _isar;

  @override
  FutureOrResult<IsarTrack?> find(String trackId) async {
    return await Result.fromAsync(
      () async => await _isar.isarTracks.where().idEqualTo(trackId).findFirst(),
    );
  }

  @override
  FutureOrResult<IsarTrack> save(IsarTrack track) async {
    return await Result.fromAsync(() async {
      final id =
          await _isar.writeTxn(() async => await _isar.isarTracks.put(track));
      return track.copyWith(isarId: id);
    });
  }

  FutureOrResult<List<IsarTrack>> saveAll(List<IsarTrack> tracks) async {
    return await Result.fromAsync(() async {
      await _isar.writeTxn(() async {
        await _isar.isarTracks.putAll(tracks);
      });
      return tracks;
    });
  }

  @override
  FutureOrResult<List<IsarTrack>> getWhereIds(List<String> ids) async {
    return await Result.fromAsync(() async {
      return await _isar.isarTracks
          .where()
          .anyOf(ids, (q, id) => q.idEqualTo(id))
          .findAll();
    });
  }

  @override
  FutureOrResult<bool> existsWhereId(String id) async {
    return await Result.fromAsync(
        () async => await _isar.isarTracks.where().idEqualTo(id).isNotEmpty());
  }
}
