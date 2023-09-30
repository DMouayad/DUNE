import 'package:dune/domain/audio/base_data_sources/base_artist_data_source.dart';
import 'package:dune/domain/audio/base_data_sources/base_track_data_source.dart';
import 'package:dune/domain/audio/base_models/audio_info_set.dart';
import 'package:dune/domain/audio/base_models/base_artist.dart';
import 'package:dune/domain/audio/base_models/track_audio_info.dart';
import 'package:dune/domain/audio/base_models/base_track.dart';
import 'package:dune/support/enums/music_source.dart';
import 'package:dune/support/utils/result/result.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

import '../helpers/youtube_explode_proxy.dart';

final class YoutubeArtistDataSource implements BaseArtistDataSource {
  const YoutubeArtistDataSource();

  @override
  FutureOrResult<BaseArtist?> find(String artistId) async {
    return await Result.fromAsync(() async {
      final ytExplode = YoutubeExplode();
      final artistVideos = await ytExplode.channels.get(artistId);
      await ytExplode.channels.getUploads(artistId).toList();

      ytExplode.close();
      // return YoutubeExplodeProxy.(video);
    });
  }

  @override
  FutureOrResult<List<BaseArtist>> getWhereIds(List<String> ids) {
    // TODO: implement getWhereIds
    throw UnimplementedError();
  }
}
