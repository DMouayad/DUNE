import 'base_playlist.dart';

abstract class BasePlaylistsListeningHistory<P extends BasePlaylist> {
  /// The date the [playlists] were listened to on.
  final DateTime date;

  /// List of playlists which were played on the specified [date]
  final List<P> playlists;

  const BasePlaylistsListeningHistory({
    required this.date,
    required this.playlists,
  });

  BasePlaylistsListeningHistory addPlaylists(List<P> playlists);

  Map<String, dynamic> toMap() {
    return {
      'date': date.toString(),
      'playlists': playlists.map((e) => e.toMap()).toList(),
    };
  }
}
