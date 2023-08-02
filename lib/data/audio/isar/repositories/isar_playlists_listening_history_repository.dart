import 'package:dune/data/audio/isar/data_sources/isar_playlists_listening_history_data_source.dart';
import 'package:dune/data/audio/isar/helpers/isar_models_relation_helper.dart';
import 'package:dune/data/audio/isar/models/isar_playlist.dart';
import 'package:dune/data/audio/isar/models/isar_playlists_listening_history.dart';
import 'package:dune/domain/audio/repositories/playlists_listening_history_repository.dart';
import 'package:dune/support/utils/result/result.dart';
import 'package:flutter/material.dart';

final class IsarPlaylistsListeningHistoryRepository
    extends BasePlaylistsListeningHistoryRepository<
        IsarPlaylistsListeningHistory, IsarPlaylist> {
  final IsarModelsRelationHelper _relationsHelper;

  IsarPlaylistsListeningHistoryRepository(
    IsarPlaylistsListeningHistoryDataSource dataSource,
    this._relationsHelper,
  ) : super(dataSource);

  @override
  IsarPlaylistsListeningHistory addPlaylistToExistentHistory(
    IsarPlaylist playlist,
    IsarPlaylistsListeningHistory history,
  ) {
    return history.copyWithAddedPlaylist(playlist);
  }

  @override
  IsarPlaylistsListeningHistory getHistoryInstance(
      IsarPlaylist playlist, DateTime date) {
    return IsarPlaylistsListeningHistory(
      date: date,
      items: [playlist],
      isarPlaylistsIds: [playlist.isarId!],
    );
  }

  @override
  FutureOrResult<List<IsarPlaylistsListeningHistory>> getByDates(
      List<DateTime> dates) async {
    return (await super.getByDates(dates)).flatMapSuccessAsync(
      (value) async => await _relationsHelper
          .loadRelationsForPlaylistsListeningHistories(value),
    );
  }

  @override
  FutureOrResult<List<IsarPlaylistsListeningHistory>> getByRange(
      DateTimeRange range) async {
    return (await super.getByRange(range)).flatMapSuccessAsync(
      (value) async => await _relationsHelper
          .loadRelationsForPlaylistsListeningHistories(value),
    );
  }
}
