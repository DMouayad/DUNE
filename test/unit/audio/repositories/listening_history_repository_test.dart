import 'package:dune/support/extensions/extensions.dart';
import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../test_helpers/fake_models/fake_playlist.dart';
import '../../../test_helpers/fake_models/fake_track.dart';
import '../../../test_helpers/isar_test_db.dart';
import '../../../utils/equality_helper.dart';
import '../../../utils/isar_track_listening_history_helper.dart';

void main() {
  setUpAll(() async => await initIsarForTesting());
  setUp(() async => await refreshDatabase());
  group("adding playlist to playlists listening history", () {
    test('it saves playlist in local storage when it does not exists',
        () async {
      final playlist = FakePlaylistFactory().create();
      final fetchingPlaylistBefore =
          await isarMusicRepo.playlists.getById(playlist.id!);
      expectLater(fetchingPlaylistBefore.requireValue, null);

      await isarMusicRepo.listeningHistory
          .addPlaylist(playlist, DateTime.now());
      final fetchingPlaylistAfter =
          await isarMusicRepo.playlists.getById(playlist.id!);
      expectLater(fetchingPlaylistAfter.requireValue, playlist);
    });
    test(
        'it adds the playlist to the specified date when it already exists in'
        'local storage', () async {
      final playlist = FakePlaylistFactory().create();
      final savingPlaylistResult = await isarMusicRepo.playlists.save(playlist);
      expectLater(savingPlaylistResult.isSuccess, true);
      final fetchingPlaylistBefore =
          await isarMusicRepo.playlists.getById(playlist.id!);
      // assert it exists before adding is to the listening history
      expectLater(fetchingPlaylistBefore.requireValue, playlist);

      final addingToListeningHistory = await isarMusicRepo.listeningHistory
          .addPlaylist(playlist, DateTime.now());
      expectLater(addingToListeningHistory.isSuccess, true);
    });
    test(
        'it adds the provided playlist when it does not exists in the specified'
        ' date playlists listening history', () async {
      final date = DateTime.now().onlyDate;
      final playlist = FakePlaylistFactory().create();
      final addingToListeningHistory =
          await isarMusicRepo.listeningHistory.addPlaylist(playlist, date);
      final datePlaylistsListeningHistory = addingToListeningHistory
          .requireValue.playlistsListeningHistory
          .whereKey(date.onlyDate);
      expectLater(
          datePlaylistsListeningHistory!.playlists.contains(playlist), true);
      expect(datePlaylistsListeningHistory.date, date);
    });
    test(
        'it does not add it twice if already exists in the'
        '[date] playlists listening history', () async {
      final playlist = FakePlaylistFactory().setTracksCount(20).create();
      // add the first time
      await isarMusicRepo.listeningHistory.addPlaylist(playlist, date);
      // assert it was added to the [date] playlists listening history
      final datePlaylistsListeningHistory =
          (await isarMusicRepo.listeningHistory.getByDates([date]))
              .requireValue
              .playlistsListeningHistory
              .whereKey(date);
      // assert a listening history was returned for the [date]
      expectLater(datePlaylistsListeningHistory != null, true);
      // asset it has only one playlist for this date which is the one we
      // previously added.
      expectLater(
        EqualityHelper.playlistsHasSameProps(
            datePlaylistsListeningHistory!.playlists.single, playlist),
        true,
      );

      // add it again for the date
      final secondTimeResult =
          await isarMusicRepo.listeningHistory.addPlaylist(playlist, date);
      // assert it was added successfully
      expectLater(secondTimeResult.isSuccess, true);
      // assert it returns only one playlist (the same playlist)
      // after adding it for the second time
      final playlistAfterSecondTime =
          (await isarMusicRepo.listeningHistory.getByDates([date]))
              .requireValue
              .playlistsListeningHistory
              .whereKey(date)!
              .playlists
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
      final playlist = FakePlaylistFactory().create();
      final addingToListeningHistory =
          await isarMusicRepo.listeningHistory.addPlaylist(playlist, date);
      final datePlaylistsListeningHistory = addingToListeningHistory
          .requireValue.playlistsListeningHistory
          .whereKey(date.onlyDate);
      // assert the returned playlist listening history for this date
      // contains all the before-added ones plus the added [playlist]
      expectLater(
        datePlaylistsListeningHistory?.playlists.length,
        playlists.length + 1,
      );
      expectLater(
          datePlaylistsListeningHistory!.playlists.contains(playlist), true);
      expect(datePlaylistsListeningHistory.date, date);
    });
  });

  group('incrementing completed listen for a track listening history', () {
    test(
        'it increments completed listens count by one with no history for track',
        () async {
      final track = FakeTrackFactory().create();
      final trackListeningHistoryBefore = (await isarMusicRepo.listeningHistory
              .getDetailedHistoryForTrack(track.id))
          .requireValue;
      // first, assert the [track] has no previous listening history
      expectLater(trackListeningHistoryBefore.isEmpty, true);

      final incrementResult = await isarMusicRepo.listeningHistory
          .incrementTrackCompletedListensCount(track, date);
      expectLater(incrementResult.isSuccess, true);
      final trackListeningHistory = incrementResult
          .requireValue.tracksListeningHistory
          .whereKey(date)
          ?.single;
      expectLater(trackListeningHistory?.track?.id, track.id);
      expectLater(trackListeningHistory?.date, date);
      expectLater(trackListeningHistory?.completedListensCount, 1);
    });
    test(
        'if track has previous listening history for date, it should increment '
        'completed listens count without creating new listening history',
        () async {
      final track = FakeTrackFactory().create();
      await createHistoryForTrack(track, date);
      final trackListeningHistoryBefore = (await isarMusicRepo.listeningHistory
              .getDetailedHistoryForTrack(track.id))
          .requireValue;
      // first, assert the [track] has a previous listening history on [date]
      expectLater(trackListeningHistoryBefore.length, 1);

      final incrementResult = await isarMusicRepo.listeningHistory
          .incrementTrackCompletedListensCount(track, date);
      expectLater(incrementResult.isSuccess, true);
      final trackListeningHistory = incrementResult
          .requireValue.tracksListeningHistory
          .whereKey(date)
          ?.single;
      expectLater(trackListeningHistory?.track?.id, track.id);
      expectLater(trackListeningHistory?.date, date);
      expectLater(trackListeningHistory?.completedListensCount,
          trackListeningHistoryBefore.single.completedListensCount! + 1);
    });
  });
  group('adding uncompleted listen duration for a track listening history', () {
    test(
        'it sets the uncompleted listens total duration by for track with no previous history',
        () async {
      final track = FakeTrackFactory().create();
      final trackListeningHistoryBefore = (await isarMusicRepo.listeningHistory
              .getDetailedHistoryForTrack(track.id))
          .requireValue;
      // first, assert the [track] has no previous listening history
      expectLater(trackListeningHistoryBefore.isEmpty, true);

      final duration = Duration(seconds: faker.randomGenerator.integer(100));
      final result = await isarMusicRepo.listeningHistory
          .addToTrackUncompletedListensDuration(track, date, duration);
      expectLater(result.isSuccess, true);
      final trackListeningHistory =
          result.requireValue.tracksListeningHistory.whereKey(date)?.single;
      expectLater(trackListeningHistory?.track?.id, track.id);
      expectLater(trackListeningHistory?.date, date);
      expectLater(
          trackListeningHistory?.uncompletedListensTotalDuration, duration);
    });
    test(
        'if track has previous listening history for date, it should adds to'
        ' the uncompleted listens duration without creating new listening history',
        () async {
      final track = FakeTrackFactory().create();
      await createHistoryForTrack(track, date);
      final trackListeningHistoryBefore = (await isarMusicRepo.listeningHistory
              .getDetailedHistoryForTrack(track.id))
          .requireValue;
      // first, assert the [track] has a previous listening history on [date]
      expectLater(trackListeningHistoryBefore.length, 1);

      final duration = Duration(seconds: faker.randomGenerator.integer(100));
      final result = await isarMusicRepo.listeningHistory
          .addToTrackUncompletedListensDuration(track, date, duration);
      expectLater(result.isSuccess, true);
      final trackListeningHistory =
          result.requireValue.tracksListeningHistory.whereKey(date)?.single;
      expectLater(trackListeningHistory?.track?.id, track.id);
      expectLater(trackListeningHistory?.date, date);
      expectLater(
        trackListeningHistory?.uncompletedListensTotalDuration,
        trackListeningHistoryBefore.single.uncompletedListensTotalDuration! +
            duration,
      );
    });
  });
}

DateTime get date => DateTime.now().onlyDate;

Future<List<FakePlaylist>> _addRandomPlaylistsToListeningHistory(
  DateTime date,
) async {
  final playlists = FakePlaylistFactory().setTracksCount(10).createCount(10);
  for (var playlist in playlists) {
    await isarMusicRepo.listeningHistory.addPlaylist(playlist, date);
  }
  await Future.delayed(const Duration(seconds: 1));
  final playlistsListeningHistory =
      (await isarMusicRepo.listeningHistory.getByDates([date]))
          .requireValue
          .playlistsListeningHistory
          .whereKey(date.onlyDate);
  for (int i = 0; i < playlists.length; i++) {
    expectLater(
      EqualityHelper.playlistsHasSameProps(
          playlists[i], playlistsListeningHistory!.playlists[i]),
      true,
    );
  }
  return playlists;
}
