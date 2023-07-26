import 'package:dune/domain/audio/base_models/base_listening_history_month_summary.dart';
import 'package:dune/domain/audio/base_models/base_playlists_listening_history.dart';
import 'package:dune/domain/audio/base_models/base_track_listening_history.dart';
import 'package:dune/domain/audio/base_models/listening_history.dart';
import 'package:dune/domain/audio/base_models/base_playlist.dart';
import 'package:dune/domain/audio/base_models/base_track.dart';
import 'package:dune/domain/use_cases/listening_history_month_summary_use_cases.dart';
import 'package:dune/support/extensions/extensions.dart';
import 'package:dune/support/utils/error/app_error.dart';
import 'package:dune/support/utils/result/result.dart';
import 'package:flutter/material.dart';

import 'listening_history_month_summary_repository.dart';
import 'playlist_repository.dart';
import 'playlists_listening_history_repository.dart';
import 'track_repository.dart';
import 'tracks_listening_history_repository.dart';

final class ListeningHistoryRepository
    with
        ListeningHistoryMonthSummaryUseCases,
        ListeningHistoryCollectionCacheHelper {
  final SavablePlaylistRepository _playlistRepository;
  final SavableTrackRepository _trackRepository;
  final BaseTracksListeningHistoryRepository _tracksListeningHistoryRepository;
  final BasePlaylistsListeningHistoryRepository
      _playlistListeningHistoryRepository;
  final ListeningHistoryMonthSummaryRepository
      _listeningHistoryMonthSummaryRepository;

  ListeningHistoryRepository(
    this._playlistRepository,
    this._trackRepository,
    this._tracksListeningHistoryRepository,
    this._playlistListeningHistoryRepository,
    this._listeningHistoryMonthSummaryRepository,
  );

  FutureResult<BasePlaylist> _savePlaylistIfNotPresent(
      BasePlaylist playlist) async {
    return (await _playlistRepository.getById(playlist.id!))
        .flatMapSuccessAsync((existingPlaylist) async {
      if (existingPlaylist == null) {
        // if it doesn't exists => save it and return the saving result.
        return await _playlistRepository.save(playlist);
      }
      return existingPlaylist.asResult;
    });
  }

  FutureResult<ListeningHistoryCollection> addPlaylist(
    BasePlaylist playlist,
    DateTime date,
  ) async {
    // first check if [playlist] exists in DB or else store it.
    final fetchingPlaylistResult = await _savePlaylistIfNotPresent(playlist);
    if (fetchingPlaylistResult.isFailure) {
      return fetchingPlaylistResult.mapFailure((error) => error);
    }
    final savedPlaylist = fetchingPlaylistResult.requireValue;
    // then let the repository handle the process of adding [savedPlaylist]
    // to the playlists listening history for [date].
    final playlistsHistoryResult = await _playlistListeningHistoryRepository
        .addToHistory(savedPlaylist, date.onlyDate);

    // on success, return the cached [ListeningHistoryCollection] with
    // the updated playlists listening history.
    return playlistsHistoryResult
        .mapSuccessTo((value) => _cachePlaylistHistory(value));
  }

  FutureOrResult<ListeningHistoryCollection>
      incrementTrackCompletedListensCount(
    BaseTrack track,
    DateTime date,
  ) async {
    return await _handleTrackListeningHistoryActions(
      track,
      date,
      incrementCompleteListensCount: true,
    );
  }

  FutureOrResult<ListeningHistoryCollection>
      _handleTrackListeningHistoryActions(
    BaseTrack track,
    DateTime date, {
    Duration? uncompletedListensTotalDuration,
    bool incrementCompleteListensCount = false,
  }) async {
    // first check if [track] exists in DB or else store it.
    final fetchingTrackResult = await _saveTrackIfNotPresent(track);
    if (fetchingTrackResult.isFailure) {
      return fetchingTrackResult.mapFailure((error) => error);
    }
    final savedTrack = fetchingTrackResult.requireValue;
    // then let the repository handle the process
    // of adding [savedTrack] to the tracks-listening-history for [date].
    final trackHistoryResult =
        await _tracksListeningHistoryRepository.addToHistory(
      savedTrack,
      date.onlyDate,
      uncompletedListensTotalDuration: uncompletedListensTotalDuration,
      incrementCompleteListensCount: incrementCompleteListensCount,
    );

    // on success, return the cached [ListeningHistoryCollection] with
    // the updated track listening history.
    return trackHistoryResult
        .mapSuccessTo((value) => _getCollectionWithTrackHistoryAdded(value));
  }

  FutureResult<BaseTrack> _saveTrackIfNotPresent(BaseTrack track) async {
    return (await _trackRepository.getById(track.id))
        .flatMapSuccessAsync((existingTrack) async {
      if (existingTrack == null) {
        // if it doesn't exists => save it and on success return a void [SuccessResult].
        return await _trackRepository.save(track);
      }
      return existingTrack.asResult;
    });
  }

  Result<ListeningHistoryCollection, AppError>
      _getCollectionWithTrackHistoryAdded(
    BaseTrackListeningHistory? trackHistory,
  ) {
    return Result.from(() {
      if (trackHistory?.date != null) {
        /// The listening history of the [trackHistory] date.
        /// which will be updated with the [trackHistory]
        final DateListeningHistory newListeningHistory;
        if (_listeningHistoryCollection
            .historyExistsForDay(trackHistory!.date!)) {
          newListeningHistory = _listeningHistoryCollection
              .getWhereDate(trackHistory.date!)!
              .copyWithTrackListeningHistoryAdded(trackHistory);
        } else {
          newListeningHistory = DateListeningHistory(
            date: trackHistory.date!,
            tracksListeningHistory: [trackHistory],
          );
        }
        _listeningHistoryCollection.replaceHistory(newListeningHistory);
      }
      return _listeningHistoryCollection;
    });
  }

  FutureOrResult<ListeningHistoryCollection>
      addToTrackUncompletedListensDuration(
    BaseTrack track,
    DateTime date,
    Duration duration,
  ) async {
    return await _handleTrackListeningHistoryActions(
      track,
      date,
      uncompletedListensTotalDuration: duration,
    );
  }

  FutureOrResult<ListeningHistoryCollection> getByDates(
      List<DateTime> dates) async {
    List<BaseTrackListeningHistory> tracksHistories = [];
    List<BasePlaylistsListeningHistory> playlistsHistories = [];

    await _tracksListeningHistoryRepository.getByDates(dates).foldThen(
          onFailure: (error) {},
          onSuccess: (value) => tracksHistories = value,
        );
    await _playlistListeningHistoryRepository.getByDates(dates).foldThen(
          onFailure: (error) {},
          onSuccess: (value) => playlistsHistories = value,
        );
    return _cacheAndReturnHistories(tracksHistories, playlistsHistories);
  }

  FutureOrResult<ListeningHistoryCollection> getByRange(
      DateTimeRange range) async {
    List<BaseTrackListeningHistory> tracksHistories = [];
    List<BasePlaylistsListeningHistory> playlistsHistories = [];

    await _tracksListeningHistoryRepository.getByRange(range).foldThen(
          onFailure: (error) {},
          onSuccess: (value) => tracksHistories = value,
        );
    await _playlistListeningHistoryRepository.getByRange(range).foldThen(
          onFailure: (error) {},
          onSuccess: (value) => playlistsHistories = value,
        );
    return _cacheAndReturnHistories(tracksHistories, playlistsHistories);
  }

  FutureOrResult<ListeningHistoryCollection> searchFor(String text) {
    // TODO: implement searchFor
    throw UnimplementedError();
  }

  @override
  FutureResult<BaseListeningHistoryMonthSummary?> getMonthSummary({
    required int month,
    required int year,
  }) async {
    return await _listeningHistoryMonthSummaryRepository.getMonthSummary(
        month: month, year: year);
  }

  FutureResult<List<BaseTrackListeningHistory>> getDetailedHistoryForTrack(
    String trackId,
  ) async {
    return await _tracksListeningHistoryRepository.getAllForTrack(trackId);
  }
}

mixin ListeningHistoryCollectionCacheHelper {
  /// A Cached in-memory list of [DateListeningHistory].
  ListeningHistoryCollection _listeningHistoryCollection =
      ListeningHistoryCollection([]);

  /// Updates the cached [ListeningHistoryCollection] with the provided track
  /// and playlist listening histories and returns it
  Result<ListeningHistoryCollection, AppError> _cacheAndReturnHistories(
    List<BaseTrackListeningHistory> tracksHistories,
    List<BasePlaylistsListeningHistory> playlistsHistories,
  ) {
    return Result.from(() {
      final newCollection = ListeningHistoryCollection([]);
      for (var item in tracksHistories) {
        final DateListeningHistory dateListeningHistory;

        /// If the history for a the [item] date already exists in the collection,
        /// then adds the new track history to that day's listening histories
        if (newCollection.historyExistsForDay(item.date!)) {
          dateListeningHistory = newCollection
              .getWhereDate(item.date!)!
              .copyWithTrackListeningHistoryAdded(item);
        } else {
          /// else creates a new [DateListeningHistory] for the item date
          /// and adds the track history to it
          dateListeningHistory = DateListeningHistory(
            date: item.date!,
            tracksListeningHistory: [item],
          );
        }

        /// Finally it's important to update the [DateListeningHistory] for the
        /// item date in the new collection.
        newCollection.replaceHistory(dateListeningHistory);
      }
      for (var item in playlistsHistories) {
        final DateListeningHistory dateListeningHistory;
        if (newCollection.historyExistsForDay(item.date)) {
          dateListeningHistory = newCollection
              .getWhereDate(item.date)!
              .copyWith(playlistsListeningHistory: item);
        } else {
          dateListeningHistory = DateListeningHistory(
            date: item.date,
            tracksListeningHistory: [],
            playlistsListeningHistory: item,
          );
        }

        newCollection.replaceHistory(dateListeningHistory);
      }
      _listeningHistoryCollection = newCollection;
      return newCollection;
    });
  }

  Result<ListeningHistoryCollection, AppError> _cachePlaylistHistory(
    BasePlaylistsListeningHistory? history,
  ) {
    return Result.from(() {
      if (history?.date != null) {
        /// The listening history of the [history] date.
        /// which will be updated with the [history]
        final DateListeningHistory newListeningHistory;
        if (_listeningHistoryCollection.historyExistsForDay(history!.date)) {
          newListeningHistory = _listeningHistoryCollection
              .getWhereDate(history.date)!
              .copyWithPlaylistHistoryAdded(history);
        } else {
          newListeningHistory = DateListeningHistory(
            date: history.date,
            tracksListeningHistory: [],
            playlistsListeningHistory: history,
          );
        }
        _listeningHistoryCollection.replaceHistory(newListeningHistory);
      }
      return _listeningHistoryCollection;
    });
  }
}
