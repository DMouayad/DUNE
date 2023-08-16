import 'package:dune/domain/audio/base_data_sources/base_track_data_source.dart';
import 'package:dune/domain/audio/base_models/audio_info_set.dart';
import 'package:dune/domain/audio/base_models/track_audio_info.dart';
import 'package:dune/domain/audio/base_models/base_track.dart';
import 'package:dune/support/enums/music_source.dart';
import 'package:dune/support/utils/result/result.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

import '../helpers/youtube_explode_proxy.dart';

final class YoutubeTrackDataSource implements BaseRemoteTrackDataSource {
  const YoutubeTrackDataSource();

  @override
  FutureOrResult<BaseTrack?> find(String trackId) async {
    return await Result.fromAsync(() async {
      final ytExplode = YoutubeExplode();

      final video = await ytExplode.videos.get(trackId);
      ytExplode.close();
      return YoutubeExplodeProxy.videoToYoutubeTrack(video);
    });
  }

  @override
  FutureResult<AudioInfoSet> getTrackAudioInfo(String trackId) async {
    return await Result.fromAsync(() async {
      final ytExplode = YoutubeExplode();
      final StreamManifest manifest =
          await ytExplode.videos.streams.getManifest(trackId);
      final audioInfoList = manifest.audioOnly
          .map((e) => TrackAudioInfo(
                url: e.url.toString(),
                format: e.container.name,
                bitrateInKb: e.bitrate.kiloBitsPerSecond,
                totalBytes: e.size.totalBytes,
                musicSource: MusicSource.youtube,
              ))
          .toList();
      ytExplode.close();
      return AudioInfoSet.fromListWithUnknownQuality(audioInfoList);
    });
  }

  @override
  FutureOrResult<List<BaseTrack>> getWhereIds(List<String> ids) {
    // TODO: implement getWhereIds
    throw UnimplementedError();
  }
}
