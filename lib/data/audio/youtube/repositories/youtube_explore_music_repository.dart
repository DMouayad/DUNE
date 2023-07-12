import 'package:dune/domain/audio/repositories/explore_music_repository.dart';

import '../data_sources/youtube_explore_music_data_source.dart';

final class YoutubeExploreMusicRepository extends ExploreMusicRepository {
  YoutubeExploreMusicRepository()
      : super(const YoutubeExploreMusicDataSource());
}
