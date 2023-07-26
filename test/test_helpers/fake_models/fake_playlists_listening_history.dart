import 'package:dune/domain/audio/base_models/base_playlist.dart';
import 'package:dune/domain/audio/base_models/base_playlists_listening_history.dart';
import 'package:dune/support/extensions/extensions.dart';
import 'package:faker/faker.dart';

import '../base_model_factory.dart';
import 'fake_playlist.dart';

final class FakePlaylistsListeningHistory
    extends BasePlaylistsListeningHistory {
  FakePlaylistsListeningHistory({
    required super.date,
    required super.playlists,
  });

  @override
  BasePlaylistsListeningHistory addPlaylists(List<BasePlaylist> playlists) {
    // TODO: implement addPlaylists
    throw UnimplementedError();
  }
}

final class FakePlaylistsListeningHistoryFactory
    extends BaseModelFactory<FakePlaylistsListeningHistory> {
  /// The date the [playlists] were listened to on.
  late final DateTime? _date;

  /// List of playlists which were played on the specified [date]
  late final List<FakePlaylist>? _playlists;

  FakePlaylistsListeningHistoryFactory() {
    _date = _playlists = null;
  }

  @override
  FakePlaylistsListeningHistory create() {
    return FakePlaylistsListeningHistory(
      date: _date ?? faker.date.dateTime().onlyDate,
      playlists: [],
    );
  }

  FakePlaylistsListeningHistoryFactory setDate(DateTime date) {
    return _copyWith(date: date);
  }

  FakePlaylistsListeningHistoryFactory setPlaylistsCount(
    int count, {
    FakePlaylistFactory Function(FakePlaylistFactory)? factory,
  }) {
    return _copyWith(
      playlists: List.generate(count, (index) {
        return (factory != null
                ? factory(FakePlaylistFactory())
                : FakePlaylistFactory())
            .create();
      }),
    );
  }

  FakePlaylistsListeningHistoryFactory._({
    required DateTime? date,
    required List<FakePlaylist>? playlists,
  })  : _date = date,
        _playlists = playlists;

  FakePlaylistsListeningHistoryFactory _copyWith({
    DateTime? date,
    List<FakePlaylist>? playlists,
  }) {
    return FakePlaylistsListeningHistoryFactory._(
      date: date ?? _date,
      playlists: playlists ?? _playlists,
    );
  }
}
