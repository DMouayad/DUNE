//
import 'package:collection/collection.dart';
import 'package:dune/domain/audio/base_models/base_playlists_listening_history.dart';
import 'package:dune/domain/audio/base_models/base_track_listening_history.dart';
import 'package:dune/domain/audio/factories/playlists_listening_history_factory.dart';
import 'package:dune/domain/audio/factories/track_listening_history_factory.dart';
import 'package:dune/domain/audio/repositories/listening_history_repository.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late ListeningHistoryCollectionCacheHelper helper;
  setUp(() => helper = ListeningHistoryCollectionCacheHelper());
  group('caching tracks listening histories tests', () {
    test(
      "it should create a [DateListeningHistory] "
      "when it doesn't exists for the provided history(s) date",
      () {
        // assert no tracks histories were cached in the collection
        expect(
          helper.listeningHistoryCollection.tracksListeningHistory,
          <DateTime, BaseTrackListeningHistory>{},
        );

        final trackListeningHistory = TrackListeningHistoryFactory().create();
        final collection = helper
            .cacheAndReturnHistories([trackListeningHistory], []).requireValue;
        expect(
          collection.getWhereDate(trackListeningHistory.date!)!.tracks.single,
          trackListeningHistory,
        );
      },
    );
    test(
      "it should group tracks listening histories by their dates into a list of"
      " [DateListeningHistory]",
      () {
        // assert no tracks histories were cached in the collection
        expect(
          helper.listeningHistoryCollection.tracksListeningHistory,
          <DateTime, BaseTrackListeningHistory>{},
        );
        final trackListeningHistories =
            TrackListeningHistoryFactory().createCount(10);
        final collection = helper
            .cacheAndReturnHistories(trackListeningHistories, []).requireValue;
        // in the cached tracksListeningHistory, assert that every entry
        // has all the histories from the passed [trackListeningHistories] which
        // has same date as this entry's key
        expect(
          collection.tracksListeningHistory.entries.every(
            (entry) {
              final historiesFromCache = entry.value;

              final addedHistories = trackListeningHistories
                  .where((h) => h.date == entry.key)
                  .toList();

              return const ListEquality()
                  .equals(addedHistories, historiesFromCache);
            },
          ),
          true,
        );
        // assert that all the passed [trackListeningHistories] were returned
        expect(
          collection.tracksListeningHistory.values
              .expand((element) => element)
              .length,
          trackListeningHistories.length,
        );
      },
    );
    test(
      "it should group playlists listening histories by their dates into a list of"
      " [DateListeningHistory]",
      () {
        // assert no playlist histories were cached in the collection
        expect(
          helper.listeningHistoryCollection.playlistsListeningHistory,
          <DateTime, BasePlaylistsListeningHistory>{},
        );
        final playlistsListeningHistories = PlaylistsListeningHistoryFactory()
            .setPlaylistsCount(5)
            .createCount(10);
        final collection = helper.cacheAndReturnHistories(
            [], playlistsListeningHistories).requireValue;
        expect(
          collection.playlistsListeningHistory.entries.every(
            (entry) {
              final historiesFromCache = entry.value;
              final addedHistories = playlistsListeningHistories
                  .firstWhere((h) => h.date == entry.key);

              return addedHistories == historiesFromCache;
            },
          ),
          true,
        );
        // assert that all the passed [playlistsListeningHistories] were returned
        expect(
          collection.playlistsListeningHistory.values.length,
          playlistsListeningHistories.length,
        );
      },
    );
  });
}
