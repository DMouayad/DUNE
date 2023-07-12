import 'package:dune/data/audio/youtube/data_sources/youtube_track_data_source.dart';
import 'package:dune/domain/audio/repositories/track_repository.dart';

final class YoutubeTrackRepository extends OnlineSourceTrackRepository {
  YoutubeTrackRepository() : super(YoutubeTrackDataSource());
}
