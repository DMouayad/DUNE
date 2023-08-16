import 'package:dune/domain/audio/base_models/audio_info_set.dart';
import 'package:dune/domain/audio/base_models/base_track.dart';
import 'package:dune/domain/audio/traits/finds_by_music_source.dart';
import 'package:dune/support/utils/result/result.dart';

abstract interface class BaseTrackDataSource<T extends BaseTrack> {
  FutureOrResult<T?> find(String trackId);

  FutureOrResult<List<T>> getWhereIds(List<String> ids);

  const BaseTrackDataSource();
}

abstract class BaseRemoteTrackDataSource<T extends BaseTrack>
    extends BaseTrackDataSource {
  const BaseRemoteTrackDataSource();

  FutureOrResult<AudioInfoSet> getTrackAudioInfo(String trackId);
}

abstract class BaseSavableTrackDataSource<T extends BaseTrack>
    extends BaseTrackDataSource with FindsByMusicSource<T> {
  FutureOrResult<T> save(T track);

  const BaseSavableTrackDataSource();
}
