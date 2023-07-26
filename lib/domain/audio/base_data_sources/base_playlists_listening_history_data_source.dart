import 'package:dune/domain/audio/base_models/base_playlists_listening_history.dart';
import 'package:dune/support/utils/result/result.dart';
import 'package:flutter/material.dart';

abstract class BasePlaylistsListeningHistoryDataSource<
    T extends BasePlaylistsListeningHistory> {
  FutureOrResult<VoidValue> save(T instance);

  FutureOrResult<T?> getByDate(DateTime date);

  FutureOrResult<List<T>> getByDates(List<DateTime> dates);

  FutureOrResult<List<T>> getByRange(DateTimeRange range);

  FutureOrResult<List<T>> searchFor(String query);
}
