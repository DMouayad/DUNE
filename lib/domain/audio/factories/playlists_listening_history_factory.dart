import 'package:dune/domain/audio/factories/base_model_factory.dart';
import 'package:dune/domain/audio/fake_models/fake_playlist.dart';
import 'package:dune/domain/audio/fake_models/fake_playlists_listening_history.dart';
import 'package:dune/support/extensions/extensions.dart';
import 'package:faker/faker.dart';

import 'playlist_factory.dart';

final class PlaylistsListeningHistoryFactory
    extends BaseModelFactory<FakePlaylistsListeningHistory> {
  /// The date the [playlists] were listened to on.
  late final DateTime? _date;

  /// List of playlists which were played on the specified [date]
  late final List<FakePlaylist>? _playlists;
  late final int _playlistsCount;

  PlaylistsListeningHistoryFactory() {
    _date = _playlists = null;
    _playlistsCount = 0;
  }

  @override
  FakePlaylistsListeningHistory create() {
    return FakePlaylistsListeningHistory(
      date: _date ?? faker.randomDateFromCurrentMonth,
      items: _playlists ?? PlaylistFactory().createCount(_playlistsCount),
    );
  }

  PlaylistsListeningHistoryFactory setDate(DateTime date) {
    return _copyWith(date: date);
  }

  PlaylistsListeningHistoryFactory setPlaylistsCount(int count) {
    return _copyWith(playlistsCount: count);
  }

  PlaylistsListeningHistoryFactory._({
    required DateTime? date,
    required List<FakePlaylist>? playlists,
    required int? playlistsCount,
  })  : _date = date,
        _playlists = playlists,
        _playlistsCount = playlistsCount ?? 0;

  PlaylistsListeningHistoryFactory _copyWith({
    DateTime? date,
    List<FakePlaylist>? playlists,
    int? playlistsCount,
  }) {
    return PlaylistsListeningHistoryFactory._(
      date: date ?? _date,
      playlists: playlists ?? _playlists,
      playlistsCount: playlistsCount ?? _playlistsCount,
    );
  }
}
