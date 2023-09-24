import 'package:dune/domain/audio/base_models/music_library.dart';
import 'package:dune/domain/audio/factories/track_factory.dart';
import 'package:dune/support/models/query_options.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  // THIS ALSO APPLIES FOR albums and artists since we're using the same method
  // [whereQueryOptions()]
  group('[getTracks] and [setTracks]', () {
    test('it returns empty list when it has NO tracks', () {
      const queryOptions = QueryOptions.defaultOptions;
      final lib = MusicLibrary();
      expect(lib.getTracks(queryOptions), []);
    });
    test('it returns tracks if exists for the same [QueryOptions]', () {
      // setup
      const limit = 10;
      const queryOptions = QueryOptions(limit: limit);
      final tracks = TrackFactory().createCount(limit);
      final lib = MusicLibrary()..setTracks(tracks, queryOptions);
      // assert
      expect(lib.getTracks(queryOptions), tracks);
    });
    test(
        'it returns tracks if it has same [QueryOptions] as the passed one but with higher limit',
        () {
      const limit = 10;
      const queryOptions = QueryOptions(limit: limit);
      final tracks = TrackFactory().createCount(limit);
      final lib = MusicLibrary()..setTracks(tracks, queryOptions);

      // assert we get a list of tracks as long as the limit of our query is
      // less then the [limit]
      expect(lib.getTracks(queryOptions.copyWith(limit: 5)), hasLength(5));
    });
    test(
        'it returns empty list if it has a with different [QueryOptions] props as the passed one but with equal or higher limit',
        () {
      const limit = 10;
      const queryOptions = QueryOptions(limit: limit);
      final tracks = TrackFactory().createCount(limit);
      final lib = MusicLibrary()..setTracks(tracks, queryOptions);

      // assert we get a list of tracks as long as the limit of our query is
      // less then the [limit]
      expect(lib.getTracks(queryOptions.copyWith(page: 2, limit: 5)), isEmpty);
    });
    test(
        'it returns tracks if the query is the same as the passed one except [sortDescending]',
        () {
      const limit = 10;
      const queryOptions = QueryOptions(limit: limit, sortDescending: false);
      final tracks = TrackFactory().createCount(limit);
      final lib = MusicLibrary()..setTracks(tracks, queryOptions);
      expect(
        lib.getTracks(queryOptions.copyWith(sortDescending: true)),
        tracks.reversed.toList(),
      );
    });
  });
}
