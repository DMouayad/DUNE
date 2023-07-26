import 'package:dune/domain/audio/base_data_sources/base_playlists_listening_history_data_source.dart';
import 'package:dune/domain/audio/base_models/base_playlist.dart';
import 'package:dune/support/extensions/extensions.dart';
import 'package:dune/support/utils/result/result.dart';
import 'package:flutter/material.dart';

import '../base_models/base_playlists_listening_history.dart';

abstract base class BasePlaylistsListeningHistoryRepository<
    T extends BasePlaylistsListeningHistory, P extends BasePlaylist> {
  final BasePlaylistsListeningHistoryDataSource<T> _dataSource;

  const BasePlaylistsListeningHistoryRepository(this._dataSource);

  /// Returns a new [BasePlaylistsListeningHistory] instance for the passed
  /// arguments.
  T getHistoryInstance(P playlist, DateTime date);

  /// Updates the [history] by adding the [playlist] to it.
  T addPlaylistToExistentHistory(P playlist, T history);

  FutureOrResult<T> addToHistory(
    P playlist,
    DateTime date,
  ) async {
    /// First check if an existing [BasePlaylistsListeningHistory] was created
    /// for this date.
    final fetchingExistingHistory = await _dataSource.getByDate(date.onlyDate);
    return await fetchingExistingHistory
        .mapSuccessAsync((existingHistory) async {
      // if no matching history was found, save a new instance in the DB
      // Or else, update the [existentHistory] data then save it
      final history = existingHistory == null
          ? getHistoryInstance(playlist, date)
          : addPlaylistToExistentHistory(playlist, existingHistory);

      return (await _dataSource.save(history)).mapSuccessTo((value) => history);
    });
  }

  FutureOrResult<List<T>> getByDates(List<DateTime> dates) async {
    return await _dataSource.getByDates(dates);
  }

  FutureOrResult<List<T>> getByRange(DateTimeRange range) async {
    return await _dataSource.getByRange(range);
  }
}
