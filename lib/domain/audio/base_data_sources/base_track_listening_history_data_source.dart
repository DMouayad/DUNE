import 'package:dune/domain/audio/base_models/base_track_listening_history.dart';
import 'package:dune/support/utils/result/result.dart';
import 'package:flutter/material.dart' show DateTimeRange;

abstract class BaseTrackListeningHistoryDataSource<
    T extends BaseTrackListeningHistory> {
  FutureOrResult<T> save(T instance);

  FutureOrResult<T?> findByTrackId(String trackId, DateTime date);

  FutureOrResult<List<T>> findAllByTrackId(String trackId);

  FutureOrResult<T?> getByDate(DateTime date);

  FutureOrResult<List<T>> getByDates(List<DateTime> dates);

  FutureOrResult<List<T>> getByRange(DateTimeRange range);

  FutureOrResult<List<T>> searchFor(String query);

  FutureOrResult<bool> hasAnyHistoriesInDateRange(DateTimeRange range);
}
