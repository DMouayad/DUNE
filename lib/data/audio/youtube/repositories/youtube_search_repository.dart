import 'package:dune/data/audio/youtube/data_sources/youtube_search_data_source.dart';
import 'package:dune/domain/audio/repositories/search_repository.dart';

final class YoutubeSearchRepository extends SearchRepository {
  YoutubeSearchRepository() : super(YoutubeSearchDataSource());
}
