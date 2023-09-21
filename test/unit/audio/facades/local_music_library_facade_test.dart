import 'dart:io';

import 'package:collection/collection.dart';
import 'package:dune/data/audio/local/services/taggy_track_from_file_extractor.dart';
import 'package:dune/domain/audio/base_models/base_album.dart';
import 'package:dune/domain/audio/base_models/base_artist.dart';
import 'package:dune/domain/audio/base_models/base_track.dart';
import 'package:dune/domain/audio/base_models/music_library.dart';
import 'package:dune/domain/audio/facades/music_facade.dart';
import 'package:dune/domain/audio/factories/album_factory.dart';
import 'package:dune/domain/audio/factories/artist_factory.dart';
import 'package:dune/domain/audio/factories/track_factory.dart';
import 'package:dune/domain/audio/services/audio_library_scanner.dart';
import 'package:dune/support/enums/music_source.dart';
import 'package:dune/support/enums/sort_type.dart';
import 'package:dune/support/models/query_options.dart';
import 'package:flutter_taggy/flutter_taggy.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../../utils/constants.dart';
import '../../../utils/equality_helper.dart';
import '../../../utils/isar_testing_utils.dart';
import '../../../utils/test_with_datasets.dart';

void main() {
  late LocalMusicLibraryFacade facade;
  final imagesDir = Directory('${Directory.current.path}\\test\\images');

  setUpAll(() async {
    Taggy.initialize();
    await IsarTestingUtils.initIsarForTesting();
    facade = LocalMusicLibraryFacade(
      IsarTestingUtils.isarMusicRepo.tracks,
      IsarTestingUtils.isarMusicRepo.albums,
      IsarTestingUtils.isarMusicRepo.artists,
      AudioLibraryScanner(
        trackExtractor: TaggyTrackFromFileExtractor(),
        directoryToSaveExtractedImages: imagesDir.path,
      ),
    );
  });

  setUp(() async {
    await IsarTestingUtils.refreshDatabase();
    facade = LocalMusicLibraryFacade(
      IsarTestingUtils.isarMusicRepo.tracks,
      IsarTestingUtils.isarMusicRepo.albums,
      IsarTestingUtils.isarMusicRepo.artists,
      AudioLibraryScanner(
        trackExtractor: TaggyTrackFromFileExtractor(),
        directoryToSaveExtractedImages: imagesDir.path,
      ),
    );
  });

  group('adding tracks to local library', () {
    test('it adds tracks to local library', () async {
      final tracks =
          TrackFactory().setMusicSource(MusicSource.local).createCount(2);
      final createdLibrary =
          (await facade.addTracksToLibrary(tracks)).requireValue;
      expect(
        EqualityHelper.trackListsHaveSameIds(
            createdLibrary.getTracks(), tracks),
        true,
      );
    });
    test('it adds tracks albums to local library', () async {
      final tracks = _createLocalTrackWithAlbum(2);
      final createdLibrary =
          (await facade.addTracksToLibrary(tracks)).requireValue;
      expect(
          EqualityHelper.albumListsHaveSameIds(
            createdLibrary.getAlbums(),
            tracks.map((e) => e.album!).toList(),
          ),
          true);
    });
    test('it adds tracks artists to local library', () async {
      final tracks = _createLocalTrackWithArtists(2);
      final createdLibrary =
          (await facade.addTracksToLibrary(tracks)).requireValue;
      expect(
          EqualityHelper.artistListsHaveSameIds(
            createdLibrary.getArtists(),
            tracks.map((e) => e.artists).expand((element) => element).toList(),
          ),
          true);
    });
  });
  group('loading library', () {
    test('it returns an empty [MusicLibrary] when no data exists', () async {
      const queryOptions = QueryOptions();
      final fetchedLibrary =
          (await facade.getLibrary(queryOptions)).requireValue;
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
          (await facade.getLibrary(queryOptions)).requireValue;
      // expect
      expectLater(
        EqualityHelper.trackListsHaveSameIds(
            fetchedLibrary.getTracks(queryOptions), seededTracks),
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
          (await facade.getLibrary(queryOptions)).requireValue;
      // expect
      expectLater(
        EqualityHelper.albumListsHaveSameIds(
            fetchedLibrary.getAlbums(queryOptions), seededAlbums),
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
            (await facade.getLibrary(queryOptions)).requireValue;
        // expect
        expectLater(
          EqualityHelper.artistListsHaveSameIds(
              fetchedLibrary.getArtists(queryOptions), seededArtists),
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
          (await facade.getTracks(QueryOptions.defaultOptions)).requireValue;
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
      final fetchedTracks = (await facade.getTracks(queryOptions)).requireValue;
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

        final fetchedTracks =
            (await facade.getTracks(queryOptions)).requireValue;

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
  group('fetching local albums', () {
    test('it returns all albums with [MusicSource.local] source', () async {
      // setup
      final seededLocalAlbums =
          await IsarTestingUtils.seedAlbums(3, MusicSource.local);
      // seed some albums with other [MusicSource]s
      await IsarTestingUtils.seedAlbums(3, MusicSource.youtube);
      await IsarTestingUtils.seedAlbums(3, MusicSource.spotify);

      // act
      final fetchedAlbums =
          (await facade.getAlbums(QueryOptions.defaultOptions)).requireValue;
      expect(
        EqualityHelper.albumListsHaveSameIds(fetchedAlbums, seededLocalAlbums),
        true,
      );
    });
    testWithDatasets<({int limit, int seedingCount})>(
      'it returns a list of [BaseAlbum] with length matching the specified [QueryOptions.limit]',
      datasets: [
        (limit: 2, seedingCount: 4),
        (limit: 10, seedingCount: 6),
        (limit: 12, seedingCount: 20),
        (limit: 50, seedingCount: 50),
      ],
      testBody: (dataset) async {
        // setup
        await IsarTestingUtils.seedAlbums(
            dataset.seedingCount, MusicSource.local, 5);
        final queryOptions = QueryOptions(limit: dataset.limit);
        // act
        final fetchedAlbums =
            (await facade.getAlbums(queryOptions)).requireValue;
        // assert
        if (dataset.seedingCount <= dataset.limit) {
          expect(fetchedAlbums.length, dataset.seedingCount);
        } else {
          expect(fetchedAlbums.length, dataset.limit);
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
            (await facade.getAlbums(queryOptions)).requireValue;

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
  });
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
          (await facade.getArtists(QueryOptions.defaultOptions)).requireValue;
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
      final fetchedArtists =
          (await facade.getArtists(queryOptions)).requireValue;
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
            (await facade.getArtists(queryOptions)).requireValue;

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
  group('adding music folder', () {
    const QueryOptions qOptions = QueryOptions(limit: 50);

    /// The [MusicLibrary] of the directory
    late MusicLibrary createdLibrary;

    tearDownAll(() => imagesDir.delete(recursive: true));
    setUpAll(() async => await imagesDir.create());
    setUp(() async {
      // we have to re-add the directory since the [setup] function of this [main]
      // function refreshes the whole database for each test.
      // first add some directory as a music directory to be scanned.
      await facade.addMusicFolder(kPathToAnAlbumFolder);
      createdLibrary = (await facade.getLibrary(qOptions)).requireValue;
    });
    test('it saves all found tracks', () async {
      //  fetch local tracks from storage
      final fetchLocalTracks = await IsarTestingUtils.isarMusicRepo.tracks
          .findAllWhereSource(MusicSource.local, qOptions);
      // assert the library tracks have been saved
      expect(
        fetchLocalTracks.requireValue,
        createdLibrary.getTracks(qOptions),
      );
    });
    test('it saves the albums of found tracks', () async {
      // fetch local albums from storage
      final fetchLocalAlbums = await IsarTestingUtils.isarMusicRepo.albums
          .findAllWhereSource(MusicSource.local, qOptions);
      // assert the created library albums have been saved
      expect(
        fetchLocalAlbums.requireValue,
        createdLibrary.getAlbums(qOptions),
      );
    });
    test('it saves the artists of found tracks', () async {
      // fetch local artists from storage
      final fetchLocalArtists =
          await IsarTestingUtils.isarMusicRepo.artists.findAllWhereSource(
        MusicSource.local,
        qOptions,
      );
      // assert the library artists have been saved
      expect(
        fetchLocalArtists.requireValue,
        createdLibrary.getArtists(qOptions),
      );
    });
  });
}

List<BaseTrack> _createLocalTrackWithArtists(int count) {
  return TrackFactory().createCountFromCustomBuilder(
    count,
    () => TrackFactory()
        .setMusicSource(MusicSource.local)
        .withArtists(
          artists:
              ArtistFactory().setMusicSource(MusicSource.local).createCount(2),
        )
        .create(),
  );
}

List<BaseTrack> _createLocalTrackWithAlbum(int count) {
  return TrackFactory().createCountFromCustomBuilder(
    count,
    () => TrackFactory()
        .setMusicSource(MusicSource.local)
        .withAlbum(AlbumFactory().setMusicSource(MusicSource.local).create())
        .create(),
  );
}

MusicLibrary _getEmptyMusicLibraryFor(QueryOptions queryOptions) {
  return MusicLibrary()
    ..setArtists([], queryOptions)
    ..setAlbums([], queryOptions)
    ..setTracks([], queryOptions);
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
