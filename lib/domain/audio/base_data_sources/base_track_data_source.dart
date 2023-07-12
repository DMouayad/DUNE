import 'package:dune/domain/audio/base_models/audio_info_set.dart';
import 'package:dune/domain/audio/base_models/base_track.dart';
import 'package:dune/support/utils/result/result.dart';

abstract interface class BaseTrackDataSource<T extends BaseTrack> {
  FutureOrResult<T?> find(String trackId);

  FutureOrResult<List<T>> getWhereIds(List<String> ids);
}

abstract interface class BaseRemoteTrackDataSource<T extends BaseTrack>
    extends BaseTrackDataSource {
  FutureResult<AudioInfoSet> getTrackAudioInfo(String trackId);
}

abstract interface class BaseSavableTrackDataSource<T extends BaseTrack>
    extends BaseTrackDataSource {
  FutureOrResult<T> save(T track);
}
