import 'package:dune/data/audio/isar/data_sources/isar_play_history_data_source.dart';
import 'package:dune/data/audio/isar/helpers/isar_models_relation_helper.dart';
import 'package:dune/data/audio/isar/models/isar_play_history.dart';
import 'package:dune/data/audio/isar/models/isar_playlist.dart';
import 'package:dune/data/audio/isar/models/isar_track.dart';
import 'package:dune/data/audio/isar/models/isar_track_record.dart';
import 'package:dune/data/audio/isar/repositories/isar_playlist_repository.dart';
import 'package:dune/domain/audio/base_models/base_play_history.dart';
import 'package:dune/domain/audio/base_models/base_playlist.dart';
import 'package:dune/domain/audio/base_models/base_track.dart';
import 'package:dune/domain/audio/base_models/base_track_record.dart';
import 'package:dune/domain/audio/repositories/base_user_listening_history_repository.dart';
import 'package:dune/support/logger_service.dart';
import 'package:dune/support/extensions/extensions.dart';
import 'package:dune/support/utils/result/result.dart';

import 'isar_track_repository.dart';

final class IsarUserListeningHistoryRepository
    implements BaseUserListeningHistoryRepository {
  final IsarListeningHistoryDataSource _listeningHistoryDataSource;
  final IsarModelsRelationHelper _modelsRelationHelper;
  final IsarPlaylistRepository _playlistRepository;
  final IsarTrackRepository _trackRepository;

  IsarUserListeningHistoryRepository(
    this._listeningHistoryDataSource,
    this._modelsRelationHelper,
    this._trackRepository,
    this._playlistRepository,
  );

  final List<IsarListeningHistory> _playHistories = [];

  @override
  FutureOrResult<BaseListeningHistory<BaseTrackRecord, BasePlaylist>>
      addPlaylist(
    BasePlaylist playlist,
    DateTime date,
  ) async {
    // first check if [playlist] exists in DB or else store it.
    final fetchingIsarPlaylistResult = await _getPlaylistFromBase(playlist);
    if (fetchingIsarPlaylistResult.isFailure) {
      return fetchingIsarPlaylistResult.mapFailure((error) => error);
    }
    final isarPlaylist = fetchingIsarPlaylistResult.requireValue;
    // second, check if an [IsarListeningHistory] exists for this [date]
    final historyResult =
        await _listeningHistoryDataSource.getByDate(date.onlyDate);
    if (historyResult.isFailure) {
      return historyResult.mapFailure((error) => error);
    }
    final existingHistory = historyResult.requireValue;
    // if no history saved for this date, store a new one and return with
    // playlist added
    if (existingHistory == null) {
      final history = IsarListeningHistory(
        date: date.onlyDate,
        playlists: [isarPlaylist],
        isarPlaylistsIds: [isarPlaylist.isarId!],
      );
      return (await _listeningHistoryDataSource.save(history))
          .mapSuccess((_) => history);
    } else {
      IsarListeningHistory newHistory;
      if (existingHistory.isarPlaylistsIds.contains(isarPlaylist.isarId)) {
        newHistory = existingHistory;
      } else {
        newHistory = existingHistory.copyWith(
            isarPlaylistsIds: {
          ...existingHistory.isarPlaylistsIds,
          isarPlaylist.isarId!
        }.toList());
        await _listeningHistoryDataSource.save(newHistory);
      }

      final cachedHistory = _playHistories
          .firstWhereOrNull((h) => h.id == historyResult.requireValue?.id);
      if (cachedHistory != null) {
        final playlistExistsInHistory = cachedHistory.playlists
                .firstWhereOrNull((e) => e.id == isarPlaylist.id) !=
            null;
        if (playlistExistsInHistory) {
        } else {
          newHistory = newHistory.copyWith(
            playlists: [...cachedHistory.playlists, isarPlaylist],
            isarPlaylistsIds: {
              ...cachedHistory.isarPlaylistsIds,
              isarPlaylist.isarId!
            }.toList(),
          );

          _playHistories.remove(cachedHistory);
          _playHistories.add(newHistory);
        }

        return newHistory.asResult;
      } else {
        newHistory = newHistory.copyWithAddedPlaylist(isarPlaylist);
        _playHistories.add(newHistory);
        return await _modelsRelationHelper.loadRelationsForListeningHistory(
          newHistory,
          ignoredPlaylistsIds: [isarPlaylist.isarId!],
        );
      }
    }
  }

  FutureResult<IsarPlaylist> _getPlaylistFromBase(
    BasePlaylist basePlaylist,
  ) async {
    return (await _playlistRepository.getById(basePlaylist.id!))
        .flatMapSuccessAsync((value) async {
      if (value != null) return value.asResult;
      return await _playlistRepository.save(basePlaylist);
    });
  }

  @override
  FutureOrResult<List<BaseListeningHistory<BaseTrackRecord, BasePlaylist>>>
      getByDates(
    List<DateTime> dates,
  ) async {
    return (await _listeningHistoryDataSource.getByDates(dates))
        .flatMapSuccessAsync((value) async {
      return await _modelsRelationHelper.loadRelationsForPlayHistories(value);
    });
  }

  @override
  FutureOrResult<List<BaseListeningHistory<BaseTrackRecord, BasePlaylist>>>
      getByRange(DateTime startDate, DateTime endDate) {
    // TODO: implement getByRange
    throw UnimplementedError();
  }

  @override
  FutureOrResult<List<BaseListeningHistory<BaseTrackRecord, BasePlaylist>>>
      searchFor(String text) {
    // TODO: implement searchFor
    throw UnimplementedError();
  }

  FutureResult<IsarTrackRecord> _getOrCreateTrackRecord(
    BaseTrack track,
    DateTime date, {
    Duration? uncompletedListensTotalDuration,
    bool incrementCompleteListensCount = false,
  }) async {
    Log.i(
        "_getOrCreateTrackRecord: {track: $track, date: $date, duration: $uncompletedListensTotalDuration, shouldIncrementCompleteListensCount: $incrementCompleteListensCount}");
    return (await _trackRepository.getById(track.id))
        .flatMapSuccessAsync((value) async {
      late IsarTrack isarTrack;
      if (value != null) {
        isarTrack = value;
      } else {
        final savingTrackResult = await _trackRepository.save(track);
        if (savingTrackResult.isFailure) {
          return savingTrackResult.mapFailure((error) => error);
        }
        isarTrack = savingTrackResult.requireValue;
      }
      return (await _listeningHistoryDataSource
              .getTrackRecordByTrackId(isarTrack.id))
          .flatMapSuccessAsync((value) async {
        if (value != null) {
          Log.i(
              "TrackRecord exists for the track: ${track.title}, ${isarTrack.isarId}");
          IsarTrackRecord recordWithTrackAdded = value.copyWith(
            track: isarTrack,
            trackId: isarTrack.id,
          );
          if (uncompletedListensTotalDuration != null) {
            recordWithTrackAdded = recordWithTrackAdded
                .withAddedUncompletedListensTotalDurationOnDate(
                    date.onlyDate, uncompletedListensTotalDuration);
            Log.i(
                "add uncompletedListensTotalDuration: ${recordWithTrackAdded.listeningHistory.firstWhereOrNull((element) => element.date?.onlyDate == date.onlyDate)}");
          }
          if (incrementCompleteListensCount) {
            recordWithTrackAdded = recordWithTrackAdded
                .withCompletedListensCountIncrementedByOneOnDate(date.onlyDate);
            Log.i(
                "incremented complete listens count: ${recordWithTrackAdded.listeningHistory.firstWhereOrNull((e) => e.date == date.onlyDate)}");
          }
          return recordWithTrackAdded.asResult;
        }
        Log.i("TrackRecord doesnt exists for the track: ${track.title}");

        return await _listeningHistoryDataSource.createTrackRecordForTrack(
          isarTrack,
          uncompletedListensTotalDuration: uncompletedListensTotalDuration,
          incrementCompleteListensCount: incrementCompleteListensCount,
        );
      });
    });
  }

  FutureOrResult<BaseListeningHistory<BaseTrackRecord<BaseTrack>, BasePlaylist>>
      _storeTrackListeningHistory(
    BaseTrack track,
    DateTime date, {
    Duration? uncompletedListensTotalDuration,
    bool incrementCompleteListensCount = false,
  }) async {
    // first check if an [IsarTrackRecord] exists for this [track] in the
    // DB or else create one for it.
    final fetchingTrackRecordResult = await _getOrCreateTrackRecord(
      track,
      date,
      uncompletedListensTotalDuration: uncompletedListensTotalDuration,
      incrementCompleteListensCount: incrementCompleteListensCount,
    );
    if (fetchingTrackRecordResult.isFailure) {
      return fetchingTrackRecordResult.mapFailure((error) => error);
    }
    final isarTrackRecord = fetchingTrackRecordResult.requireValue;

    // second, check if an [IsarListeningHistory] exists for this [date]
    final historyResult =
        await _listeningHistoryDataSource.getByDate(date.onlyDate);
    if (historyResult.isFailure) {
      return historyResult.mapFailure((error) => error);
    }
    final existingHistory = historyResult.requireValue;
    // if no history saved for this date, store a new one and return with
    // track added
    if (existingHistory == null) {
      Log.i("NO existing history found in DB for date $date");

      final history = IsarListeningHistory(
        date: date.onlyDate,
        tracks: [isarTrackRecord],
        isarTrackRecordsIds: [isarTrackRecord.id!],
      );
      return (await _listeningHistoryDataSource.save(history))
          .mapSuccess((_) => history);
    } else {
      Log.i(
          "existing history found for date $date, with ${existingHistory.isarTrackRecordsIds.length} tracks");
      Log.i('isar tracks ids (${existingHistory.isarTrackRecordsIds})');

      IsarListeningHistory newHistory = existingHistory.copyWith(
        isarTrackRecordsIds: {
          ...existingHistory.isarTrackRecordsIds,
          isarTrackRecord.id!
        }.toList(),
      );
      Log.i(
          "new history tracks records ids: ${newHistory.isarTrackRecordsIds}");

      await _listeningHistoryDataSource.save(newHistory);

      final cachedHistory = _playHistories
          .firstWhereOrNull((h) => h.id == historyResult.requireValue?.id);

      if (cachedHistory != null) {
        Log.i(
          "Found an In-Memory-Cached history for this date, with ${cachedHistory.tracks.length} tracks",
        );
        _playHistories.remove(cachedHistory);
        final cachedInMemoryTrackRecord = cachedHistory.tracks
            .firstWhereOrNull((e) => e.trackId == isarTrackRecord.trackId);
        if (cachedInMemoryTrackRecord != null) {
          cachedHistory.tracks.remove(cachedInMemoryTrackRecord);
          newHistory = newHistory.copyWith(tracks: [
            ...cachedHistory.tracks,
            cachedInMemoryTrackRecord.copyWith(
                listeningHistory: isarTrackRecord.listeningHistory),
          ]);
        } else {
          newHistory = newHistory.copyWith(
            tracks: [...cachedHistory.tracks, isarTrackRecord],
          );
        }
        _playHistories.add(newHistory);
        Log.i('new play history track names');
        for (IsarTrackRecord track in newHistory.tracks) {
          print(track.track?.title);
        }
        Log.i('END Of new play history track names');

        return newHistory.asResult;
      } else {
        Log.i(
          "No In-Memory-Cached history was found for this date",
        );
        return (await _modelsRelationHelper.loadRelationsForListeningHistory(
                newHistory.copyWithAddedTrack(isarTrackRecord)))
            .fold(ifSuccess: (value) {
          Log.i('new play history track names');
          for (IsarTrackRecord trackRecord in value.tracks) {
            print(trackRecord.track?.title);
          }
          Log.i('END Of new play history track names');
          _playHistories.add(value);
        });
      }
    }
  }

  @override
  FutureOrResult<BaseListeningHistory<BaseTrackRecord<BaseTrack>, BasePlaylist>>
      addToTrackUncompletedListensDuration(
    BaseTrack track,
    DateTime date,
    Duration duration,
  ) async {
    return await _storeTrackListeningHistory(
      track,
      date,
      uncompletedListensTotalDuration: duration,
    );
  }

  @override
  FutureOrResult<BaseListeningHistory<BaseTrackRecord<BaseTrack>, BasePlaylist>>
      incrementTrackCompletedListensCount(
    BaseTrack track,
    DateTime date,
  ) async {
    return await _storeTrackListeningHistory(
      track,
      date,
      incrementCompleteListensCount: true,
    );
  }
}
