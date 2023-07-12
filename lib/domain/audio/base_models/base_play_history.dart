import 'package:dune/domain/audio/base_models/base_album.dart';
import 'package:dune/support/extensions/extensions.dart';

import 'base_artist.dart';
import 'base_playlist.dart';
import 'base_track_record.dart';

abstract class BaseListeningHistory<T extends BaseTrackRecord,
    P extends BasePlaylist> {
  /// The date this history occurred on.
  final DateTime date;

  /// List of track records which contains the information regarding listened-to
  /// tracks on the specified [date].
  final List<T> tracks;

  /// List of playlists which were played on the specified [date]
  final List<P> playlists;

  /// List of tracks which were listened-to on the specified [date]
  List<BaseArtist> get artists;

  /// List of albums which were listened-from on the specified [date]
  List<BaseAlbum> get albums;

  BaseListeningHistory({
    required this.date,
    required this.tracks,
    required this.playlists,
  });

  @override
  String toString() {
    return 'BaseListeningHistory{date: $date, tracks: $tracks, playlists: $playlists, artists: $artists, albums: $albums}';
  }

  Map<String, dynamic> toMap() {
    return {
      'date': date.toString(),
      'tracks': tracks.map((e) => e.toMap()).toList(),
      'playlists': playlists.map((e) => e.toMap()).toList(),
    };
  }
}

mixin ListeningHistoryDataExtractor {
  static List<BaseAlbum> getAlbumsFromTracks(List<BaseTrackRecord> tracks) {
    final albumsList = <BaseAlbum>[];
    for (BaseTrackRecord trackRecord in tracks) {
      if (trackRecord.track?.album != null) {
        final alreadyAdded = albumsList.firstWhereOrNull(
                (e) => e.id == trackRecord.track!.album!.id) !=
            null;
        if (!alreadyAdded) {
          albumsList.add(trackRecord.track!.album!);
        }
      }
    }
    return albumsList;
  }

  static List<BaseArtist> getArtistsFromTracks(List<BaseTrackRecord> tracks) {
    final artists = <BaseArtist>[];
    for (BaseTrackRecord trackRecord in tracks) {
      if (trackRecord.track?.artists != null) {
        artists.addAll(trackRecord.track!.artists);
      }
    }
    return artists.toSet().toList();
  }
}
