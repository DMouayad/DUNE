import 'package:dune/data/audio/isar/data_sources/isar_track_listening_history_data_source.dart';
import 'package:dune/data/audio/isar/helpers/isar_models_relation_helper.dart';
import 'package:dune/data/audio/isar/models/isar_track.dart';
import 'package:dune/data/audio/isar/models/isar_track_listening_history.dart';
import 'package:dune/domain/audio/repositories/tracks_listening_history_repository.dart';
import 'package:dune/support/utils/result/result.dart';
import 'package:flutter/material.dart';

final class IsarTracksListeningHistoryRepository
    extends BaseTracksListeningHistoryRepository<IsarTrackListeningHistory,
        IsarTrack> {
  final IsarModelsRelationHelper _relationsHelper;

  IsarTracksListeningHistoryRepository(
      IsarTrackListeningHistoryDataSource dataSource, this._relationsHelper)
      : super(dataSource);

  @override
  IsarTrackListeningHistory getHistoryInstance(
    IsarTrack track,
    DateTime date,
    Duration? uncompletedListensTotalDuration,
    bool incrementCompleteListensCount,
  ) {
    return IsarTrackListeningHistory(
      track: track,
      trackId: track.id,
      date: date,
      uncompletedListensTotalDurationInSeconds:
          uncompletedListensTotalDuration?.inSeconds ?? 0,
      completedListensCount: incrementCompleteListensCount ? 1 : 0,
    );
  }

  @override
  IsarTrackListeningHistory updateExistentHistory(
    IsarTrackListeningHistory history,
    Duration? uncompletedListensTotalDuration,
    bool incrementCompleteListensCount,
  ) {
    IsarTrackListeningHistory newHistory = history.copyWith();
    if (uncompletedListensTotalDuration != null) {
      newHistory = newHistory.copyWithAddedUncompletedListensTotalDuration(
          uncompletedListensTotalDuration);
    }
    if (incrementCompleteListensCount) {
      newHistory = newHistory.copyWithCompletedListensCountIncrementedByOne();
    }
    return newHistory;
  }

  @override
  FutureOrResult<List<IsarTrackListeningHistory>> getByDates(
      List<DateTime> dates) async {
    return (await super.getByDates(dates)).flatMapSuccessAsync(
      (value) async =>
          await _relationsHelper.loadRelationsForTrackListeningHistories(value),
    );
  }

  @override
  FutureOrResult<List<IsarTrackListeningHistory>> getByRange(
      DateTimeRange range) async {
    return (await super.getByRange(range)).flatMapSuccessAsync(
      (value) async =>
          await _relationsHelper.loadRelationsForTrackListeningHistories(value),
    );
  }

  @override
  FutureOrResult<List<IsarTrackListeningHistory>> getAllForTrack(
      String trackId) async {
    return (await super.getAllForTrack(trackId)).flatMapSuccessAsync(
      (value) async =>
          await _relationsHelper.loadRelationsForTrackListeningHistories(value),
    );
  }
}
