import 'package:dune/data/audio/isar/models/isar_track_listening_history.dart';
import 'package:dune/domain/audio/base_data_sources/base_track_listening_history_data_source.dart';
import 'package:dune/support/extensions/extensions.dart';
import 'package:dune/support/utils/result/result.dart';
import 'package:flutter/material.dart';
import 'package:isar/isar.dart';

class IsarTrackListeningHistoryDataSource
    extends BaseTrackListeningHistoryDataSource<IsarTrackListeningHistory> {
  final Isar _isar;

  IsarTrackListeningHistoryDataSource(this._isar);

  @override
  FutureOrResult<List<IsarTrackListeningHistory>> getByDates(
      List<DateTime> dates) async {
    return await Result.fromAsync(() async {
      final result = await _isar.isarTrackListeningHistorys
          .where()
          .anyOf(dates, (q, date) => q.dateEqualTo(date.onlyDate))
          .sortByDateDesc()
          .findAll();
      return result;
    });
  }

  @override
  FutureOrResult<List<IsarTrackListeningHistory>> searchFor(String query) {
    // TODO: implement searchFor
    throw UnimplementedError();
  }

  @override
  FutureOrResult<List<IsarTrackListeningHistory>> getByRange(
      DateTimeRange range) async {
    return await Result.fromAsync(() async {
      return await _isar.isarTrackListeningHistorys
          .where()
          .dateBetween(range.start.onlyDate, range.end.onlyDate)
          .findAll();
    });
  }

  @override
  FutureOrResult<IsarTrackListeningHistory> save(
      IsarTrackListeningHistory instance) async {
    return await Result.fromAsync(() async {
      final id = await _isar.writeTxn(
          () async => await _isar.isarTrackListeningHistorys.put(instance));
      return instance.copyWith(id: id);
    });
  }

  @override
  FutureOrResult<IsarTrackListeningHistory?> getByDate(DateTime date) async {
    return await Result.fromAsync(() async => await _isar
        .isarTrackListeningHistorys
        .where()
        .dateEqualTo(date.onlyDate)
        .findFirst());
  }

  @override
  FutureResult<IsarTrackListeningHistory?> findByTrackId(
    String trackId,
    DateTime date,
  ) async {
    return await Result.fromAsync(() async {
      return await _isar.isarTrackListeningHistorys
          .where()
          .trackIdEqualTo(trackId)
          .findFirst();
    });
  }

  @override
  FutureOrResult<List<IsarTrackListeningHistory>> findAllByTrackId(
      String trackId) async {
    return await Result.fromAsync(() async {
      return await _isar.isarTrackListeningHistorys
          .where()
          .trackIdEqualTo(trackId)
          .findAll();
    });
  }

  @override
  FutureOrResult<bool> hasAnyHistoriesInDateRange(DateTimeRange range) async {
    return await Result.fromAsync(() async {
      return await _isar.isarTrackListeningHistorys
          .where()
          .dateBetween(range.start.onlyDate, range.end.onlyDate)
          .isNotEmpty();
    });
  }
}
