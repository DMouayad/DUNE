import 'package:dune/domain/audio/base_models/base_playlist.dart';
import 'package:dune/domain/audio/factories/playlist_factory.dart';
import 'package:dune/domain/audio/factories/track_factory.dart';
import 'package:dune/support/extensions/extensions.dart';
import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../utils/isar_testing_utils.dart';
import '../../../../utils/equality_helper.dart';

void main() {
  setUpAll(() async => await IsarTestingUtils.initIsarForTesting());
  setUp(() async => await IsarTestingUtils.refreshDatabase());
  group("adding playlist to playlists listening history", () {
    test(
      'it saves playlist in local storage when it does not exists',
      () async {
        final playlist = PlaylistFactory().create();
        final fetchingPlaylistBefore = await IsarTestingUtils
            .isarMusicRepo.playlists
            .getById(playlist.id!);
        expectLater(fetchingPlaylistBefore.requireValue, null);

        await IsarTestingUtils.isarMusicRepo.listeningHistory
            .addPlaylist(playlist, DateTime.now());
        final fetchingPlaylistAfter = await IsarTestingUtils
            .isarMusicRepo.playlists
            .getById(playlist.id!);
        expectLater(fetchingPlaylistAfter.requireValue, playlist);
      },
    );
    test(
      'it adds the playlist to the specified date when it already exists in'
      'local storage',
      () async {
        final playlist = PlaylistFactory().create();
        final savingPlaylistResult =
            await IsarTestingUtils.isarMusicRepo.playlists.save(playlist);
        expectLater(savingPlaylistResult.isSuccess, true);

        final addingToListeningHistory = await IsarTestingUtils
            .isarMusicRepo.listeningHistory
            .addPlaylist(playlist, DateTime.now());
        expectLater(addingToListeningHistory.isSuccess, true);
      },
    );
    test(
        'it adds the provided playlist when it does not exists in the specified'
        ' date playlists listening history', () async {
      final date = DateTime.now().onlyDate;
      final playlist = PlaylistFactory().create();
      final datePlaylistsListeningHistory = (await IsarTestingUtils
              .isarMusicRepo.listeningHistory
              .addPlaylist(playlist, date))
          .requireValue
          .playlistsListeningHistory
          .whereKey(date.onlyDate);

      expectLater(
          datePlaylistsListeningHistory!.items.contains(playlist), true);
    });
    test(
        'it does not add it twice if already exists in the '
        '[date] playlists listening history', () async {
      final playlist = PlaylistFactory().setTracksCount(20).create();
      // add the first time
      await IsarTestingUtils.isarMusicRepo.listeningHistory
          .addPlaylist(playlist, date);
      // assert it was added to the [date] playlists listening history
      final datePlaylistsListeningHistory = (await IsarTestingUtils
              .isarMusicRepo.listeningHistory
              .getByDates([date]))
          .requireValue
          .playlistsListeningHistory;
      // assert a listening history was returned for the [date]
      expectLater(datePlaylistsListeningHistory.whereKey(date) != null, true);
      // asset it has only one playlist for this date which is the one we
      // previously added.
      expectLater(
        EqualityHelper.playlistsHasSameProps(
            datePlaylistsListeningHistory.whereKey(date)!.items.single,
            playlist),
        true,
      );

      // add it again for the date
      final secondTimeResult = await IsarTestingUtils
          .isarMusicRepo.listeningHistory
          .addPlaylist(playlist, date);
      // assert it was added successfully
      expectLater(secondTimeResult.isSuccess, true);
      // assert it returns only one playlist (the same playlist)
      // after adding it for the second time
      final playlistAfterSecondTime = (await IsarTestingUtils
              .isarMusicRepo.listeningHistory
              .getByDates([date]))
          .requireValue
          .playlistsListeningHistory
          .whereKey(date)!
          .items
          .single;
      expectLater(
        EqualityHelper.playlistsHasSameProps(playlistAfterSecondTime, playlist),
        true,
      );
    });
    test(
        'it adds the provided playlist when it does not exists in the specified'
        ' date playlists listening history which will be containing other playlists',
        () async {
      final playlists = await _addRandomPlaylistsToListeningHistory(date);
      final playlist = PlaylistFactory().create();
      final addingToListeningHistory = await IsarTestingUtils
          .isarMusicRepo.listeningHistory
          .addPlaylist(playlist, date);
      final datePlaylistsListeningHistory = addingToListeningHistory
          .requireValue.playlistsListeningHistory
          .whereKey(date.onlyDate);
      // assert the returned playlist listening history for this date
      // contains all the before-added ones plus the added [playlist]
      expectLater(
        datePlaylistsListeningHistory?.items.length,
        playlists.length + 1,
      );
      expectLater(
          datePlaylistsListeningHistory!.items.contains(playlist), true);
      expect(datePlaylistsListeningHistory.date, date);
    });
  });

  group('incrementing completed listen for a track listening history', () {
    test(
        'it increments completed listens count by one with no history for track',
        () async {
      final track = TrackFactory().create();
      final trackListeningHistoryBefore = (await IsarTestingUtils
              .isarMusicRepo.listeningHistory
              .getDetailedHistoryForTrack(track.id))
          .requireValue;
      // first, assert the [track] has no previous listening history
      expectLater(trackListeningHistoryBefore.isEmpty, true);

      final incrementResult = await IsarTestingUtils
          .isarMusicRepo.listeningHistory
          .incrementTrackCompletedListensCount(track, date);
      final trackListeningHistory = incrementResult
          .requireValue.tracksListeningHistory
          .whereKey(date)
          ?.single;
      expectLater(trackListeningHistory?.track?.id, track.id);
      expectLater(trackListeningHistory?.completedListensCount, 1);
    });
    test(
        'if track has previous listening history for date, it should increment '
        'completed listens count without creating new listening history',
        () async {
      final track = TrackFactory().create();
      await IsarTestingUtils.trackListeningHistorySeeder.seedOne(track, date);
      final trackListeningHistoryBefore = (await IsarTestingUtils
              .isarMusicRepo.listeningHistory
              .getDetailedHistoryForTrack(track.id))
          .requireValue;
      // first, assert the [track] has a previous listening history on [date]
      expectLater(trackListeningHistoryBefore.length, 1);

      final incrementResult = await IsarTestingUtils
          .isarMusicRepo.listeningHistory
          .incrementTrackCompletedListensCount(track, date);
      final trackListeningHistory = incrementResult
          .requireValue.tracksListeningHistory
          .whereKey(date)
          ?.single;
      expectLater(trackListeningHistory?.track?.id, track.id);
      expectLater(trackListeningHistory?.completedListensCount,
          trackListeningHistoryBefore.single.completedListensCount! + 1);
    });
  });
  group('adding uncompleted listen duration for a track listening history', () {
    test(
        'it sets the uncompleted listens total duration by for track with no previous history',
        () async {
      final track = TrackFactory().create();
      final trackListeningHistoryBefore = (await IsarTestingUtils
              .isarMusicRepo.listeningHistory
              .getDetailedHistoryForTrack(track.id))
          .requireValue;
      // first, assert the [track] has no previous listening history
      expectLater(trackListeningHistoryBefore.isEmpty, true);

      final duration = Duration(seconds: faker.randomGenerator.integer(100));
      final trackListeningHistory = (await IsarTestingUtils
              .isarMusicRepo.listeningHistory
              .addToTrackUncompletedListensDuration(track, date, duration))
          .requireValue
          .tracksListeningHistory
          .whereKey(date)
          ?.single;
      expectLater(trackListeningHistory?.track?.id, track.id);
      expectLater(
          trackListeningHistory?.uncompletedListensTotalDuration, duration);
    });
    test(
        'if track has previous listening history for date, it should adds to'
        ' the uncompleted listens duration without creating new listening history',
        () async {
      final track = TrackFactory().create();
      await IsarTestingUtils.trackListeningHistorySeeder.seedOne(track, date);
      final trackListeningHistoryBefore = (await IsarTestingUtils
              .isarMusicRepo.listeningHistory
              .getDetailedHistoryForTrack(track.id))
          .requireValue;
      // first, assert the [track] has a previous listening history on [date]
      expectLater(trackListeningHistoryBefore.length, 1);

      final duration = Duration(seconds: faker.randomGenerator.integer(100));
      final result = await IsarTestingUtils.isarMusicRepo.listeningHistory
          .addToTrackUncompletedListensDuration(track, date, duration);
      final trackListeningHistory =
          result.requireValue.tracksListeningHistory.whereKey(date)?.single;
      expectLater(trackListeningHistory?.track?.id, track.id);
      expectLater(
        trackListeningHistory?.uncompletedListensTotalDuration,
        trackListeningHistoryBefore.single.uncompletedListensTotalDuration! +
            duration,
      );
    });
    group('returned [ListeningHistoryCollection] tests', () {
      test(
        'it should return tracksListeningHistories grouped by date',
        () async {
          final seededTracksHistories = await IsarTestingUtils
              .trackListeningHistorySeeder
              .seedRandomCount(date);
          final tracksListeningHistories = (await IsarTestingUtils
                  .isarMusicRepo.listeningHistory
                  .getByDates([date]))
              .requireValue
              .tracksListeningHistory;
          expect(
            tracksListeningHistories.entries.every(
              (entry) {
                final historiesFromCache = entry.value;

                final addedHistories = seededTracksHistories
                    .where((h) => h.date == entry.key)
                    .toList();
                return historiesFromCache.length == addedHistories.length;
              },
            ),
            true,
          );
          // assert that all the passed [seededTracksHistories] were returned
          expect(
            tracksListeningHistories.values.expand((element) => element).length,
            seededTracksHistories.length,
          );
        },
      );
    });
  });
}

DateTime get date => DateTime.now().onlyDate;

DateTimeRange get currentMonth {
  final now = DateTime.now();

  return DateTimeRange(
    start: DateTime(now.year, now.month),
    end: DateTime(now.year, now.month, 31),
  );
}

Future<List<BasePlaylist>> _addRandomPlaylistsToListeningHistory(
  DateTime date,
) async {
  final playlists = PlaylistFactory().setTracksCount(10).createCount(2);
  for (var playlist in playlists) {
    await IsarTestingUtils.isarMusicRepo.listeningHistory
        .addPlaylist(playlist, date);
  }
  await Future.delayed(const Duration(seconds: 1));
  final playlistsListeningHistory =
      (await IsarTestingUtils.isarMusicRepo.listeningHistory.getByDates([date]))
          .requireValue
          .playlistsListeningHistory
          .whereKey(date.onlyDate);
  for (int i = 0; i < playlists.length; i++) {
    final isEqual = EqualityHelper.playlistsHasSameProps(
        playlists[i], playlistsListeningHistory!.items[i]);
    expectLater(isEqual, true);
  }
  return playlists;
}
