import 'package:dune/domain/audio/base_models/listening_history_collection.dart';
import 'package:dune/domain/audio/factories/base_model_factory.dart';
import 'package:dune/support/extensions/extensions.dart';
import 'package:faker/faker.dart';

import '../fake_models/fake_playlists_listening_history.dart';
import '../fake_models/fake_track.dart';
import '../fake_models/fake_track_listening_history.dart';
import 'track_listening_history_factory.dart';

final class FakeDateListeningHistory extends DateListeningHistory {
  FakeDateListeningHistory({
    required super.date,
    required super.tracks,
    super.playlists,
  });
}

final class DateListeningHistoryFactory
    extends BaseModelFactory<FakeDateListeningHistory> {
  late final DateTime? _date;

  /// The listening histories of all tracks
  /// which were listened-to on the specified [date]
  late final List<FakeTrackListeningHistory>? _tracksListeningHistory;
  late final FakePlaylistsListeningHistory? _playlists;

  DateListeningHistoryFactory() {
    _date = _tracksListeningHistory = _playlists = null;
  }

  @override
  FakeDateListeningHistory create() {
    return FakeDateListeningHistory(
      date: _date ?? faker.date.dateTime().onlyDate,
      tracks: _tracksListeningHistory ?? [],
      playlists: _playlists,
    );
  }

  DateListeningHistoryFactory setTracksListeningHistoryCount(int count) {
    return _copyWith(
      tracks: List.generate(
        count,
        (index) => TrackListeningHistoryFactory().create(),
      ),
    );
  }

  DateListeningHistoryFactory createListeningHistoriesForTracks(
    List<FakeTrack> tracks,
  ) {
    return _copyWith(
      tracks: tracks
          .map((track) =>
              TrackListeningHistoryFactory().setTrack(track).create())
          .toList(),
    );
  }

  DateListeningHistoryFactory._({
    required DateTime? date,
    required List<FakeTrackListeningHistory>? tracks,
    required FakePlaylistsListeningHistory? playlists,
  })  : _date = date,
        _tracksListeningHistory = tracks,
        _playlists = playlists;

  DateListeningHistoryFactory _copyWith({
    DateTime? date,
    List<FakeTrackListeningHistory>? tracks,
    FakePlaylistsListeningHistory? playlists,
  }) {
    return DateListeningHistoryFactory._(
      date: date ?? _date,
      tracks: tracks ?? _tracksListeningHistory,
      playlists: playlists ?? _playlists,
    );
  }
}
