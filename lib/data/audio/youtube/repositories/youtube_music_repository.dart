import 'package:dune/data/audio/youtube/repositories/youtube_track_repository.dart';
import 'package:dune/domain/audio/repositories/base_music_repository.dart';
import 'package:dune/domain/audio/repositories/explore_music_repository.dart';
import 'package:dune/domain/audio/repositories/playlist_repository.dart';
import 'package:dune/domain/audio/repositories/track_repository.dart';

import 'youtube_explore_music_repository.dart';
import 'youtube_playlist_repository.dart';
import 'youtube_search_repository.dart';

final class YoutubeMusicRepository implements BaseOnlineSourceMusicRepository {
  YoutubeMusicRepository() {
    _trackRepository = YoutubeTrackRepository();
    _playlistRepository = YoutubePlaylistRepository();
    _exploreMusicRepository = YoutubeExploreMusicRepository();
    _searchRepository = YoutubeSearchRepository();
  }

  late final YoutubeSearchRepository _searchRepository;
  late final YoutubeTrackRepository _trackRepository;
  late final YoutubePlaylistRepository _playlistRepository;
  late final YoutubeExploreMusicRepository _exploreMusicRepository;

  @override
  // TODO: implement albums
  get albums => throw UnimplementedError();

  @override
  // TODO: implement artists
  get artists => throw UnimplementedError();

  @override
  ExploreMusicRepository get exploreMusic => _exploreMusicRepository;

  @override
  PlaylistRepository get playlists => _playlistRepository;

  @override
  get search => _searchRepository;

  @override
  OnlineSourceTrackRepository get tracks => _trackRepository;
}
