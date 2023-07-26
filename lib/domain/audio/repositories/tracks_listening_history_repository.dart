import 'package:dune/domain/audio/base_data_sources/base_track_listening_history_data_source.dart';
import 'package:dune/domain/audio/base_models/base_track.dart';
import 'package:dune/domain/audio/base_models/base_track_listening_history.dart';
import 'package:dune/support/extensions/extensions.dart';
import 'package:dune/support/utils/result/result.dart';
import 'package:flutter/material.dart';

abstract base class BaseTracksListeningHistoryRepository<
    T extends BaseTrackListeningHistory, Track extends BaseTrack> {
  final BaseTrackListeningHistoryDataSource<T> _dataSource;

  const BaseTracksListeningHistoryRepository(this._dataSource);

  /// Returns a new [BaseTrackListeningHistory] instance for the passed
  /// arguments.
  T getHistoryInstance(
    Track track,
    DateTime date,
    Duration? uncompletedListensTotalDuration,
    bool incrementCompleteListensCount,
  );

  /// Returns an Updated listening history from the passed [history].
  T updateExistentHistory(
    T history,
    Duration? uncompletedListensTotalDuration,
    bool incrementCompleteListensCount,
  );

  FutureOrResult<BaseTrackListeningHistory> addToHistory(
    Track track,
    DateTime date, {
    Duration? uncompletedListensTotalDuration,
    bool incrementCompleteListensCount = false,
  }) async {
    /// First check if an existing [BaseTrackListeningHistory] was created
    /// for this date.
    final fetchingExistingHistory = await _dataSource.getByDate(date.onlyDate);
    return await fetchingExistingHistory
        .mapSuccessAsync((existingHistory) async {
      // if no matching history was found, save a new instance in the DB
      // Or else, update the [existentHistory] data then save it

      final history = existingHistory == null
          ? getHistoryInstance(
              track,
              date.onlyDate,
              uncompletedListensTotalDuration,
              incrementCompleteListensCount,
            )
          : updateExistentHistory(
              existingHistory.copyWith(track: track),
              uncompletedListensTotalDuration,
              incrementCompleteListensCount,
            );

      return (await _dataSource.save(history)).mapSuccessTo((value) => history);
    });
  }

  FutureOrResult<List<T>> getByDates(List<DateTime> dates) async {
    return await _dataSource.getByDates(dates);
  }

  FutureOrResult<List<T>> getByRange(DateTimeRange range) async {
    return await _dataSource.getByRange(range);
  }

  FutureOrResult<List<T>> getAllForTrack(String trackId) async {
    return await _dataSource.findAllByTrackId(trackId);
  }
}
