import 'package:dune/domain/audio/base_models/listening_history.dart';
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
    required super.tracksListeningHistory,
    super.playlistsListeningHistory,
  });
}

final class DateListeningHistoryFactory
    extends BaseModelFactory<FakeDateListeningHistory> {
  late final DateTime? _date;

  /// The listening histories of all tracks
  /// which were listened-to on the specified [date]
  late final List<FakeTrackListeningHistory>? _tracksListeningHistory;
  late final FakePlaylistsListeningHistory? _playlistsListeningHistory;

  DateListeningHistoryFactory() {
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

  DateListeningHistoryFactory setTracksListeningHistoryCount(int count) {
    return _copyWith(
      tracksListeningHistory: List.generate(
        count,
        (index) => TrackListeningHistoryFactory().create(),
      ),
    );
  }

  DateListeningHistoryFactory createListeningHistoriesForTracks(
    List<FakeTrack> tracks,
  ) {
    return _copyWith(
      tracksListeningHistory: tracks
          .map((track) =>
              TrackListeningHistoryFactory().setTrack(track).create())
          .toList(),
    );
  }

  DateListeningHistoryFactory._({
    required DateTime? date,
    required List<FakeTrackListeningHistory>? tracksListeningHistory,
    required FakePlaylistsListeningHistory? playlistsListeningHistory,
  })  : _date = date,
        _tracksListeningHistory = tracksListeningHistory,
        _playlistsListeningHistory = playlistsListeningHistory;

  DateListeningHistoryFactory _copyWith({
    DateTime? date,
    List<FakeTrackListeningHistory>? tracksListeningHistory,
    FakePlaylistsListeningHistory? playlistsListeningHistory,
  }) {
    return DateListeningHistoryFactory._(
      date: date ?? _date,
      tracksListeningHistory: tracksListeningHistory ?? _tracksListeningHistory,
      playlistsListeningHistory:
          playlistsListeningHistory ?? _playlistsListeningHistory,
    );
  }
}
