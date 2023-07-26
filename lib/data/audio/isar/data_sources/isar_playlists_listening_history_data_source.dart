import 'package:dune/data/audio/isar/models/isar_playlists_listening_history.dart';
import 'package:dune/domain/audio/base_data_sources/base_playlists_listening_history_data_source.dart';
import 'package:dune/support/extensions/extensions.dart';
import 'package:dune/support/utils/result/result.dart';
import 'package:flutter/material.dart';
import 'package:isar/isar.dart';

final class IsarPlaylistsListeningHistoryDataSource
    extends BasePlaylistsListeningHistoryDataSource<
        IsarPlaylistsListeningHistory> {
  final Isar _isar;

  IsarPlaylistsListeningHistoryDataSource(this._isar);

  @override
  FutureOrResult<List<IsarPlaylistsListeningHistory>> getByDates(
      List<DateTime> dates) async {
    return await Result.fromAsync(() async {
      final result = await _isar.isarPlaylistsListeningHistorys
          .where()
          .anyOf(dates, (q, date) => q.dateEqualTo(date.onlyDate))
          .sortByDateDesc()
          .findAll();
      return result;
    });
  }

  @override
  FutureOrResult<List<IsarPlaylistsListeningHistory>> searchFor(String query) {
    // TODO: implement searchFor
    throw UnimplementedError();
  }

  @override
  FutureOrResult<List<IsarPlaylistsListeningHistory>> getByRange(
      DateTimeRange range) async {
    return await Result.fromAsync(() async {
      return await _isar.isarPlaylistsListeningHistorys
          .where()
          .dateBetween(range.start.onlyDate, range.end.onlyDate)
          .findAll();
    });
  }

  @override
  FutureOrResult<VoidValue> save(IsarPlaylistsListeningHistory instance) async {
    return await Result.fromAnother(() async {
      await _isar.writeTxn(
          () async => await _isar.isarPlaylistsListeningHistorys.put(instance));
      return SuccessResult.voidResult();
    });
  }

  @override
  FutureOrResult<IsarPlaylistsListeningHistory?> getByDate(
      DateTime date) async {
    return await Result.fromAsync(() async => await _isar
        .isarPlaylistsListeningHistorys
        .where()
        .dateEqualTo(date.onlyDate)
        .findFirst());
  }
}
