import 'package:collection/collection.dart';
import 'package:dune/domain/audio/base_models/base_album.dart';
import 'package:dune/domain/audio/base_models/base_artist.dart';
import 'package:dune/domain/audio/base_models/base_track.dart';
import 'package:dune/domain/audio/base_models/music_library.dart';
import 'package:dune/domain/audio/repositories/local_music_library_repository.dart';
import 'package:dune/support/enums/music_source.dart';
import 'package:dune/support/enums/sort_type.dart';
import 'package:dune/support/models/query_options.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../../utils/equality_helper.dart';
import '../../../utils/isar_testing_utils.dart';
import '../../../utils/test_with_datasets.dart';

void main() {
  late LocalMusicLibraryRepository repo;

  setUpAll(() async => await IsarTestingUtils.initIsarForTesting());
  setUp(() async {
    await IsarTestingUtils.refreshDatabase();
    repo = IsarTestingUtils.isarMusicRepo.localMusicLibrary;
  });
  group('loading library', () {
    test('it returns an empty [MusicLibrary] when no data exists', () async {
      const queryOptions = QueryOptions();
      final fetchedLibrary =
          (await repo.loadLibrary(queryOptions)).requireValue;
      expectLater(fetchedLibrary, _getEmptyMusicLibraryFor(queryOptions));
    });
    test('it returns a [MusicLibrary] containing available local tracks',
        () async {
      // setup
      final seededTracks =
          await IsarTestingUtils.seedTracks(4, MusicSource.local);
      // act
      const queryOptions = QueryOptions();
      final fetchedLibrary =
          (await repo.loadLibrary(queryOptions)).requireValue;
      // expect
      expectLater(
        EqualityHelper.trackListsHaveSameIds(
            fetchedLibrary.getTracks(queryOptions) ?? [], seededTracks),
        true,
      );
    });
    test('it returns a [MusicLibrary] containing available local albums',
        () async {
      // setup
      final seededAlbums =
          await IsarTestingUtils.seedAlbums(4, MusicSource.local, 5);
      // act
      const queryOptions = QueryOptions();
      final fetchedLibrary =
          (await repo.loadLibrary(queryOptions)).requireValue;
      // expect
      expectLater(
        EqualityHelper.albumListsHaveSameIds(
            fetchedLibrary.getAlbums(queryOptions) ?? [], seededAlbums),
        true,
      );
    });
    test('it returns a [MusicLibrary] containing available local playlists',
        () async {
      // setup
      final seededPlaylists =
          await IsarTestingUtils.seedPlaylists(4, MusicSource.local, 5);
      // act
      const queryOptions = QueryOptions();
      final fetchedLibrary =
          (await repo.loadLibrary(queryOptions)).requireValue;
      // expect
      expectLater(
        EqualityHelper.playlistListsHaveSameIds(
            fetchedLibrary.getPlaylists(queryOptions) ?? [], seededPlaylists),
        true,
      );
    });
    test(
      'it returns a [MusicLibrary] containing available local artists',
      () async {
        // setup
        final seededArtists =
            await IsarTestingUtils.seedArtists(4, MusicSource.local);
        // act
        const queryOptions = QueryOptions();
        final fetchedLibrary =
            (await repo.loadLibrary(queryOptions)).requireValue;
        // expect
        expectLater(
          EqualityHelper.artistListsHaveSameIds(
              fetchedLibrary.getArtists(queryOptions) ?? [], seededArtists),
          true,
        );
      },
    );
  });
  group('fetching local tracks', () {
    test('it returns all tracks with [MusicSource.local] source', () async {
      // setup
      final localTracks =
          await IsarTestingUtils.seedTracks(10, MusicSource.local);
      // seed some tracks with different music sources
      await IsarTestingUtils.seedTracks(10, MusicSource.youtube);
      await IsarTestingUtils.seedTracks(10, MusicSource.spotify);
      // act
      final fetchedTracks =
          (await repo.getTracks(QueryOptions.defaultOptions())).requireValue;
      expect(
        EqualityHelper.trackListsHaveSameIds(fetchedTracks, localTracks),
        true,
      );
    });
    test(
        'it returns a list of [BaseTrack] with length matching the specified [QueryOptions.limit]',
        () async {
      // setup
      await IsarTestingUtils.seedTracks(5, MusicSource.local);
      const queryOptions = QueryOptions(limit: 2);
      // act
      final fetchedTracks = (await repo.getTracks(queryOptions)).requireValue;
      // assert
      expectLater(fetchedTracks.length, queryOptions.limit);
    });

    testWithDatasets<QueryOptions>(
      'it returns a list of [BaseTrack] sorted by the specified [QueryOptions]',
      datasets: const [
        QueryOptions(limit: 2, sortBy: SortType.releaseDate),
        QueryOptions(
            limit: 2, sortBy: SortType.releaseDate, sortDescending: true),
        QueryOptions(limit: 2, sortBy: SortType.alphabetically),
        QueryOptions(
            limit: 2, sortBy: SortType.alphabetically, sortDescending: true),
      ],
      testBody: (queryOptions) async {
        final seededTracks =
            await IsarTestingUtils.seedTracks(5, MusicSource.local);

        final fetchedTracks = (await repo.getTracks(queryOptions)).requireValue;

        sortItems<BaseTrack>(
          seededTracks,
          queryOptions,
          alphabeticallyComparison: (a, b) => a.title.compareTo(b.title),
          releaseDateComparison: (a, b) =>
              a.releaseDate!.compareTo(b.releaseDate!),
        );
        final expectedTracks = seededTracks.sublist(0, queryOptions.limit);
        expect(
          EqualityHelper.trackListsHaveSameIds(fetchedTracks, expectedTracks),
          true,
        );
      },
    );
  });
  group(
    'fetching local albums',
    () {
      test('it returns all albums with [MusicSource.local] source', () async {
        // setup
        final seededLocalAlbums =
            await IsarTestingUtils.seedAlbums(3, MusicSource.local);
        // seed some albums with other [MusicSource]s
        await IsarTestingUtils.seedAlbums(3, MusicSource.youtube);
        await IsarTestingUtils.seedAlbums(3, MusicSource.spotify);

        // act
        final fetchedAlbums =
            (await repo.getAlbums(QueryOptions.defaultOptions())).requireValue;
        expect(
          EqualityHelper.albumListsHaveSameIds(
              fetchedAlbums, seededLocalAlbums),
          true,
        );
      });
      testWithDatasets<({int limit, int seedingCount})>(
        'it returns a list of [BaseAlbum] with length matching the specified [QueryOptions.limit]',
        datasets: [
          (limit: 2, seedingCount: 4),
          (limit: 10, seedingCount: 6),
          (limit: 10, seedingCount: 20),
          (limit: 50, seedingCount: 50),
        ],
        testBody: (dataset) async {
          // setup
          await IsarTestingUtils.seedAlbums(
              dataset.seedingCount, MusicSource.local, 5);
          final queryOptions = QueryOptions(limit: dataset.limit);
          // act
          final fetchedAlbums =
              (await repo.getAlbums(queryOptions)).requireValue;
          // assert
          if (dataset.seedingCount < dataset.limit) {
            expectLater(fetchedAlbums.length, dataset.seedingCount);
          } else {
            expectLater(fetchedAlbums.length, dataset.limit);
          }
        },
      );

      testWithDatasets<QueryOptions>(
        'it returns a list of [BaseAlbum] sorted by the specified [SortType])',
        datasets: [
          const QueryOptions(limit: 2, sortBy: SortType.releaseDate),
          const QueryOptions(
              limit: 2, sortBy: SortType.releaseDate, sortDescending: true),
          const QueryOptions(limit: 2, sortBy: SortType.alphabetically),
          const QueryOptions(
              limit: 2, sortBy: SortType.alphabetically, sortDescending: true),
        ],
        testBody: (queryOptions) async {
          final seededAlbums =
              await IsarTestingUtils.seedAlbums(5, MusicSource.local);
          final fetchedAlbums =
              (await repo.getAlbums(queryOptions)).requireValue;

          sortItems<BaseAlbum>(
            seededAlbums,
            queryOptions,
            alphabeticallyComparison: (a, b) => a.title.compareTo(b.title),
            releaseDateComparison: (a, b) =>
                a.releaseDate!.compareTo(b.releaseDate!),
          );
          final expectedAlbums = seededAlbums.sublist(0, queryOptions.limit);
          expect(
            EqualityHelper.albumListsHaveSameIds(fetchedAlbums, expectedAlbums),
            true,
          );
        },
      );
    },
  );
  group('fetching local artists', () {
    test('it returns all artists with [MusicSource.local] source', () async {
      // setup
      final seededArtists =
          await IsarTestingUtils.seedArtists(3, MusicSource.local);
      // seed some artists with other [MusicSource]s
      await IsarTestingUtils.seedArtists(3, MusicSource.youtube);
      await IsarTestingUtils.seedArtists(3, MusicSource.spotify);

      // act
      final fetchedArtists =
          (await repo.getArtists(QueryOptions.defaultOptions())).requireValue;
      expect(
        EqualityHelper.artistListsHaveSameIds(fetchedArtists, seededArtists),
        true,
      );
    });
    test(
        'it returns a list of [BaseArtist] with length matching the specified [QueryOptions.limit]',
        () async {
      // setup
      await IsarTestingUtils.seedArtists(5, MusicSource.local);
      const queryOptions = QueryOptions(limit: 2);
      // act
      final fetchedArtists = (await repo.getArtists(queryOptions)).requireValue;
      // assert
      expectLater(fetchedArtists.length, queryOptions.limit);
    });
    testWithDatasets<QueryOptions>(
      'it returns a list of [BaseArtist] sorted by the specified [SortType]',
      datasets: [
        const QueryOptions(limit: 2, sortBy: SortType.alphabetically),
        const QueryOptions(
            limit: 2, sortBy: SortType.alphabetically, sortDescending: true),
      ],
      testBody: (queryOptions) async {
        final seededArtists =
            await IsarTestingUtils.seedArtists(5, MusicSource.local);

        final fetchedArtists =
            (await repo.getArtists(queryOptions)).requireValue;

        sortItems<BaseArtist>(
          seededArtists,
          queryOptions,
          alphabeticallyComparison: (a, b) => a.name!.compareTo(b.name!),
        );
        final expectedArtists = seededArtists.sublist(0, queryOptions.limit);
        expectLater(
          EqualityHelper.artistListsHaveSameIds(
              fetchedArtists, expectedArtists),
          true,
        );
      },
    );
  });
}

MusicLibrary _getEmptyMusicLibraryFor(QueryOptions queryOptions) {
  return MusicLibrary()
    ..setArtists([], queryOptions)
    ..setAlbums([], queryOptions)
    ..setTracks([], queryOptions)
    ..setPlaylists([], queryOptions);
}

void sortItems<T>(
  List<T> items,
  QueryOptions queryOptions, {
  int Function(T a, T b)? alphabeticallyComparison,
  int Function(T a, T b)? releaseDateComparison,
  int Function(T a, T b)? dateAddedComparison,
}) {
  switch (queryOptions.sortBy) {
    case SortType.alphabetically:
      if (alphabeticallyComparison != null) {
        insertionSort(
          items,
          compare: (a, b) => queryOptions.sortDescending
              ? -alphabeticallyComparison(a, b)
              : alphabeticallyComparison(a, b),
        );
      }
    case SortType.releaseDate:
      if (releaseDateComparison != null) {
        insertionSort(
          items,
          compare: (a, b) => queryOptions.sortDescending
              ? -releaseDateComparison(a, b)
              : releaseDateComparison(a, b),
        );
      }
    case SortType.dateAdded:
      if (dateAddedComparison != null) {
        insertionSort(
          items,
          compare: (a, b) => queryOptions.sortDescending
              ? -dateAddedComparison(a, b)
              : dateAddedComparison(a, b),
        );
      }
  }
}
