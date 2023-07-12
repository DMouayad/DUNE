import 'package:dune/data/audio/youtube/data_sources/youtube_playlist_data_source.dart';
import 'package:dune/domain/audio/repositories/playlist_repository.dart';

final class YoutubePlaylistRepository extends PlaylistRepository {
  YoutubePlaylistRepository() : super(YoutubePlaylistDataSource());
}
