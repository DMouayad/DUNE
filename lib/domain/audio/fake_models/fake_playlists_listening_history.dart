import 'package:dune/domain/audio/base_models/base_playlist.dart';
import 'package:dune/domain/audio/base_models/base_playlists_listening_history.dart';

final class FakePlaylistsListeningHistory
    extends BasePlaylistsListeningHistory {
  const FakePlaylistsListeningHistory({
    required super.date,
    required super.items,
  });

  @override
  Set<Type> get derived => {BasePlaylistsListeningHistory};

  @override
  FakePlaylistsListeningHistory copyWithAddedPlaylists(
      List<BasePlaylist> items) {
    return copyWith(
      items: {...this.items, ...items}.toList(),
    );
  }

  @override
  FakePlaylistsListeningHistory copyWith({
    DateTime? date,
    List<BasePlaylist>? items,
  }) {
    return FakePlaylistsListeningHistory(
      date: date ?? this.date,
      items: items ?? this.items,
    );
  }
}
