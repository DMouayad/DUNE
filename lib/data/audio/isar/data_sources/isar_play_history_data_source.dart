import 'package:dune/data/audio/isar/models/isar_play_history.dart';
import 'package:dune/data/audio/isar/models/isar_playlist.dart';
import 'package:dune/data/audio/isar/models/isar_track.dart';
import 'package:dune/data/audio/isar/models/isar_track_record.dart';
import 'package:dune/domain/audio/base_data_sources/base_play_history_data_source.dart';
import 'package:dune/support/logger_service.dart';
import 'package:dune/support/extensions/extensions.dart';
import 'package:dune/support/utils/result/result.dart';
import 'package:isar/isar.dart';

class IsarListeningHistoryDataSource extends BaseListeningHistoryDataSource<
    IsarListeningHistory, IsarTrack, IsarPlaylist> {
  final Isar _isar;

  IsarListeningHistoryDataSource(this._isar);

  @override
  FutureOrResult<List<IsarListeningHistory>> getAll() async {
    return await Result.fromAsync(
      () async => await _isar.isarListeningHistorys.where().anyId().findAll(),
    );
  }

  @override
  FutureOrResult<List<IsarListeningHistory>> getByDates(
      List<DateTime> dates) async {
    return await Result.fromAsync(() async {
      final result = await _isar.isarListeningHistorys
          .filter()
          .anyOf(dates, (q, date) => q.dateEqualTo(date.onlyDate))
          .sortByDateDesc()
          .findAll();
      return result;
    });
  }

  @override
  FutureOrResult<List<IsarListeningHistory>> searchFor(String text) {
    // TODO: implement searchFor
    throw UnimplementedError();
  }

  @override
  FutureOrResult<List<IsarListeningHistory>> getByRange(
    DateTime startDate,
    DateTime endDate,
  ) async {
    return await Result.fromAsync(() async {
      return await _isar.isarListeningHistorys
          .filter()
          .dateBetween(startDate.onlyDate, endDate.onlyDate)
          .findAll();
    });
  }

  @override
  FutureOrResult<VoidValue> save(IsarListeningHistory instance) async {
    return await Result.fromAnother(() async {
      await _isar.writeTxn(
          () async => await _isar.isarListeningHistorys.put(instance));
      return SuccessResult.voidResult();
    });
  }

  @override
  FutureOrResult<IsarListeningHistory?> getByDate(DateTime date) async {
    return await Result.fromAsync(() async => await _isar.isarListeningHistorys
        .filter()
        .dateEqualTo(date.onlyDate)
        .findFirst());
  }

  FutureResult<List<IsarTrackRecord>> getTrackRecords(List<int> ids) async {
    return await Result.fromAsync(() async {
      return await _isar.isarTrackRecords
          .filter()
          .anyOf(ids, (q, id) => q.idEqualTo(id))
          .findAll();
    });
  }

  FutureResult<IsarTrackRecord> createTrackRecordForTrack(
    IsarTrack track, {
    Duration? uncompletedListensTotalDuration,
    bool incrementCompleteListensCount = false,
  }) async {
    Log.i(
        "Creating new track record for ${track.title} with uncompletedListensTotalDuration: $uncompletedListensTotalDuration, "
        " incrementCompleteListensCount: $incrementCompleteListensCount");
    return await Result.fromAsync(() async {
      final trackRecord = IsarTrackRecord(
        track: track,
        trackId: track.id,
        listeningHistory: [
          IsarListeningRecord(
            date: DateTime.now().onlyDate,
            uncompletedListensTotalDuration: uncompletedListensTotalDuration,
            completedListensCount: incrementCompleteListensCount ? 1 : 0,
          ),
        ],
      );
      final id = await _isar
          .writeTxn(() async => await _isar.isarTrackRecords.put(trackRecord));
      return trackRecord.copyWith(id: id);
    });
  }

  FutureResult<IsarTrackRecord?> findTrackRecord(int isarId) async {
    return await Result.fromAsync(() async {
      return await _isar.isarTrackRecords
          .filter()
          .idEqualTo(isarId)
          .findFirst();
    });
  }

  FutureResult<IsarTrackRecord?> getTrackRecordByTrackId(String trackId) async {
    return await Result.fromAsync(() async {
      return await _isar.isarTrackRecords
          .filter()
          .trackIdEqualTo(trackId)
          .findFirst();
    });
  }
}
