import 'package:dune/data/audio/youtube/data_sources/youtube_artist_data_source.dart';
import 'package:dune/data/audio/youtube/data_sources/youtube_explore_music_data_source.dart';
import 'package:dune/data/audio/youtube/data_sources/youtube_playlist_data_source.dart';
import 'package:dune/data/audio/youtube/data_sources/youtube_search_data_source.dart';
import 'package:dune/data/audio/youtube/data_sources/youtube_track_data_source.dart';
import 'package:dune/domain/audio/repositories/artist_repository.dart';
import 'package:dune/domain/audio/repositories/base_music_repository.dart';
import 'package:dune/domain/audio/repositories/explore_music_repository.dart';
import 'package:dune/domain/audio/repositories/playlist_repository.dart';
import 'package:dune/domain/audio/repositories/search_repository.dart';
import 'package:dune/domain/audio/repositories/track_repository.dart';

final class YoutubeMusicRepository implements BaseOnlineSourceMusicRepository {
  YoutubeMusicRepository()
      : _trackRepository =
            const OnlineSourceTrackRepository(YoutubeTrackDataSource()),
        _playlistRepository =
            const PlaylistRepository(YoutubePlaylistDataSource()),
        _exploreMusicRepository =
            ExploreMusicRepository(const YoutubeExploreMusicDataSource()),
        _searchRepository = const SearchRepository(YoutubeSearchDataSource()),
        _artistRepository = ArtistRepository(const YoutubeArtistDataSource());

  final SearchRepository _searchRepository;
  final OnlineSourceTrackRepository _trackRepository;
  final PlaylistRepository _playlistRepository;
  final ExploreMusicRepository _exploreMusicRepository;
  final ArtistRepository _artistRepository;

  @override
  // TODO: implement albums
  get albums => throw UnimplementedError();

  @override
  get artists => _artistRepository;

  @override
  ExploreMusicRepository get exploreMusic => _exploreMusicRepository;

  @override
  PlaylistRepository get playlists => _playlistRepository;

  @override
  get search => _searchRepository;

  @override
  OnlineSourceTrackRepository get tracks => _trackRepository;
}
