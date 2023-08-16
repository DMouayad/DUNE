import 'package:dune/domain/audio/repositories/local_music_library_repository.dart';

import 'album_repository.dart';
import 'artist_repository.dart';
import 'explore_music_repository.dart';
import 'playlist_repository.dart';
import 'search_repository.dart';
import 'track_repository.dart';

abstract interface class BaseMusicRepository<
    Playlists extends PlaylistRepository,
    Tracks extends TrackRepository,
    Artists extends ArtistRepository,
    Albums extends AlbumRepository,
    Search extends SearchRepository> {
  const BaseMusicRepository();

  Playlists get playlists;

  Tracks get tracks;

  Artists get artists;

  Albums get albums;

  Search get search;
}

abstract interface class BaseOnlineSourceMusicRepository<
        Playlists extends PlaylistRepository,
        Tracks extends OnlineSourceTrackRepository,
        Artists extends ArtistRepository,
        Albums extends AlbumRepository,
        Search extends SearchRepository,
        ExploreMusic extends ExploreMusicRepository>
    implements BaseMusicRepository<Playlists, Tracks, Artists, Albums, Search> {
  ExploreMusic get exploreMusic;
  const BaseOnlineSourceMusicRepository();
}

abstract interface class BaseLocalMusicRepository<
        Playlists extends SavablePlaylistRepository,
        Tracks extends SavableTrackRepository,
        Artists extends SavableArtistRepository,
        Albums extends SavableAlbumRepository,
        Search extends SearchRepository,
        LocalMusicLibrary extends LocalMusicLibraryRepository>
    implements BaseMusicRepository<Playlists, Tracks, Artists, Albums, Search> {
  LocalMusicLibrary get localMusicLibrary;
}
