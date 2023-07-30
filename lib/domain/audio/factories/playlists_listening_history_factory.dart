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

  PlaylistsListeningHistoryFactory() {
    _date = _playlists = null;
  }

  @override
  FakePlaylistsListeningHistory create() {
    return FakePlaylistsListeningHistory(
      date: _date ?? faker.date.dateTime().onlyDate,
      playlists: [],
    );
  }

  PlaylistsListeningHistoryFactory setDate(DateTime date) {
    return _copyWith(date: date);
  }

  PlaylistsListeningHistoryFactory setPlaylistsCount(
    int count, {
    PlaylistFactory Function(PlaylistFactory)? factory,
  }) {
    return _copyWith(
      playlists: List.generate(count, (index) {
        return (factory != null
                ? factory(PlaylistFactory())
                : PlaylistFactory())
            .create();
      }),
    );
  }

  PlaylistsListeningHistoryFactory._({
    required DateTime? date,
    required List<FakePlaylist>? playlists,
  })  : _date = date,
        _playlists = playlists;

  PlaylistsListeningHistoryFactory _copyWith({
    DateTime? date,
    List<FakePlaylist>? playlists,
  }) {
    return PlaylistsListeningHistoryFactory._(
      date: date ?? _date,
      playlists: playlists ?? _playlists,
    );
  }
}
