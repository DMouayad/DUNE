import 'package:dune/domain/audio/base_models/listening_history.dart';
import 'package:dune/support/extensions/extensions.dart';
import 'package:faker/faker.dart';

import '../base_model_factory.dart';
import 'fake_playlists_listening_history.dart';
import 'fake_track.dart';
import 'fake_track_listening_history.dart';

final class FakeDateListeningHistory extends DateListeningHistory {
  FakeDateListeningHistory({
    required super.date,
    required super.tracksListeningHistory,
    super.playlistsListeningHistory,
  });
}

final class FakeDateListeningHistoryFactory
    extends BaseModelFactory<FakeDateListeningHistory> {
  late final DateTime? _date;

  /// The listening histories of all tracks
  /// which were listened-to on the specified [date]
  late final List<FakeTrackListeningHistory>? _tracksListeningHistory;
  late final FakePlaylistsListeningHistory? _playlistsListeningHistory;

  FakeDateListeningHistoryFactory() {
    _date = _tracksListeningHistory = _playlistsListeningHistory = null;
  }

  @override
  FakeDateListeningHistory create() {
    return FakeDateListeningHistory(
      date: _date ?? faker.date.dateTime().onlyDate,
      tracksListeningHistory: _tracksListeningHistory ?? [],
      playlistsListeningHistory: _playlistsListeningHistory,
    );
  }

  FakeDateListeningHistoryFactory setTracksListeningHistoryCount(int count) {
    return _copyWith(
      tracksListeningHistory: List.generate(
        count,
        (index) => FakeTrackListeningHistoryFactory().create(),
      ),
    );
  }

  FakeDateListeningHistoryFactory createListeningHistoriesForTracks(
    List<FakeTrack> tracks,
  ) {
    return _copyWith(
      tracksListeningHistory: tracks
          .map((track) =>
              FakeTrackListeningHistoryFactory().setTrack(track).create())
          .toList(),
    );
  }

  FakeDateListeningHistoryFactory._({
    required DateTime? date,
    required List<FakeTrackListeningHistory>? tracksListeningHistory,
    required FakePlaylistsListeningHistory? playlistsListeningHistory,
  })  : _date = date,
        _tracksListeningHistory = tracksListeningHistory,
        _playlistsListeningHistory = playlistsListeningHistory;

  FakeDateListeningHistoryFactory _copyWith({
    DateTime? date,
    List<FakeTrackListeningHistory>? tracksListeningHistory,
    FakePlaylistsListeningHistory? playlistsListeningHistory,
  }) {
    return FakeDateListeningHistoryFactory._(
      date: date ?? _date,
      tracksListeningHistory: tracksListeningHistory ?? _tracksListeningHistory,
      playlistsListeningHistory:
          playlistsListeningHistory ?? _playlistsListeningHistory,
    );
  }
}
