import 'package:dune/domain/audio/base_data_sources/base_search_data_source.dart';
import 'package:dune/domain/audio/base_models/audio_info_set.dart';
import 'package:dune/domain/audio/base_models/base_album.dart';
import 'package:dune/domain/audio/base_models/base_artist.dart';
import 'package:dune/domain/audio/base_models/base_explore_music_collection.dart';
import 'package:dune/domain/audio/base_models/base_listening_history_month_summary.dart';
import 'package:dune/domain/audio/base_models/base_track.dart';
import 'package:dune/domain/audio/base_models/base_track_listening_history.dart';
import 'package:dune/domain/audio/base_models/listening_history_collection.dart';
import 'package:dune/domain/audio/base_models/music_library.dart';
import 'package:dune/domain/audio/repositories/album_repository.dart';
import 'package:dune/domain/audio/repositories/artist_repository.dart';
import 'package:dune/domain/audio/repositories/base_music_repository.dart';
import 'package:dune/domain/audio/repositories/listening_history_repository.dart';
import 'package:dune/domain/audio/repositories/explore_music_repository.dart';
import 'package:dune/domain/audio/repositories/playlist_repository.dart';
import 'package:dune/domain/audio/repositories/search_repository.dart';
import 'package:dune/domain/audio/repositories/track_repository.dart';
import 'package:dune/domain/audio/base_models/base_playlist.dart';
import 'package:dune/domain/audio/services/audio_library_scanner.dart';
import 'package:dune/support/enums/music_source.dart';
import 'package:dune/support/extensions/extensions.dart';
import 'package:dune/support/models/query_options.dart';
import 'package:dune/support/utils/result/result.dart';
import 'package:flutter/material.dart';

part 'playlist_facade.dart';

part 'track_facade.dart';

part 'search_facade.dart';

part 'explore_music_facade.dart';

part 'user_listening_history_facade.dart';

part 'local_music_library_facade.dart';

final class MusicFacade {
  MusicFacade._({
    required BaseLocalMusicRepository localMusicRepository,
    required BaseOnlineSourceMusicRepository youtubeMusicRepository,
    required ListeningHistoryRepository listeningHistoryRepository,
    required AudioLibraryScanner audioLibraryScanner,
  }) {
    _playlists = PlaylistFacade(
      youtubePlaylistRepository: youtubeMusicRepository.playlists,
      localPlaylistRepository: localMusicRepository.playlists,
    );
    _tracks = TrackFacade(
      youtubeTrackRepository: youtubeMusicRepository.tracks,
      localTrackRepository: localMusicRepository.tracks,
    );
    _search = SearchFacade(
      youtubeSearchRepository: youtubeMusicRepository.search,
    );
    _exploreMusic = ExploreMusicFacade(
      youtubeRepository: youtubeMusicRepository.exploreMusic,
    );
    _userListeningHistory =
        UserListeningHistoryFacade(listeningHistoryRepository);
    _localMusicLibrary = LocalMusicLibraryFacade(
      localMusicRepository.tracks,
      localMusicRepository.albums,
      localMusicRepository.artists,
      audioLibraryScanner,
    );
  }

  static late MusicFacade _instance;

  late final PlaylistFacade _playlists;

  static PlaylistFacade get playlists => _instance._playlists;

  late final TrackFacade _tracks;

  static TrackFacade get tracks => _instance._tracks;

  late final SearchFacade _search;

  static SearchFacade get search => _instance._search;

  late final ExploreMusicFacade _exploreMusic;

  static ExploreMusicFacade get exploreMusic => _instance._exploreMusic;

  late final UserListeningHistoryFacade _userListeningHistory;

  static UserListeningHistoryFacade get userListeningHistory =>
      _instance._userListeningHistory;

  late final LocalMusicLibraryFacade _localMusicLibrary;

  static LocalMusicLibraryFacade get localMusicLibrary =>
      _instance._localMusicLibrary;

  static void setInstance({
    required BaseLocalMusicRepository localMusicRepository,
    required BaseOnlineSourceMusicRepository youtubeMusicRepository,
    required ListeningHistoryRepository listeningHistoryRepository,
    required AudioLibraryScanner audioLibraryScanner,
  }) {
    _instance = MusicFacade._(
      localMusicRepository: localMusicRepository,
      youtubeMusicRepository: youtubeMusicRepository,
      listeningHistoryRepository: listeningHistoryRepository,
      audioLibraryScanner: audioLibraryScanner,
    );
  }
}
