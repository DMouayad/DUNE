import 'package:dune/domain/audio/base_models/base_playlist.dart';

import 'base_album.dart';
import 'base_artist.dart';
import 'base_track.dart';

class MusicLibrary {
  final List<BaseTrack> tracks;
  final List<BaseArtist> artists;
  final List<BaseAlbum> albums;
  final List<BasePlaylist> playlists;

  const MusicLibrary(
    this.tracks,
    this.artists,
    this.albums,
    this.playlists,
  );
}
