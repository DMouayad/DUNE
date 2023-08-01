import 'package:dune/domain/audio/base_models/base_playlist.dart';
import 'package:dune/domain/audio/base_models/base_playlists_listening_history.dart';

final class FakePlaylistsListeningHistory
    extends BasePlaylistsListeningHistory {
  const FakePlaylistsListeningHistory({
    required super.date,
    required super.playlists,
  });

  @override
  Set<Type> get derived => {BasePlaylistsListeningHistory};

  @override
  FakePlaylistsListeningHistory addPlaylists(List<BasePlaylist> playlists) {
    return copyWith(
      playlists: {...this.playlists, ...playlists}.toList(),
    );
  }

  FakePlaylistsListeningHistory copyWith({
    DateTime? date,
    List<BasePlaylist>? playlists,
  }) {
    return FakePlaylistsListeningHistory(
      date: date ?? this.date,
      playlists: playlists ?? this.playlists,
    );
  }
}
