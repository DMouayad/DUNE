import 'package:dune/domain/audio/base_data_sources/base_track_data_source.dart';
import 'package:dune/domain/audio/base_models/audio_info_set.dart';
import 'package:dune/domain/audio/base_models/base_track.dart';
import 'package:dune/support/utils/result/result.dart';

abstract base class TrackRepository<DataSource extends BaseTrackDataSource> {
  final DataSource _trackDataSource;

  TrackRepository(this._trackDataSource);

  FutureOrResult<BaseTrack?> getById(String id) async {
    return await _trackDataSource.find(id);
  }
}

abstract base class SavableTrackRepository<
        DataSource extends BaseTrackDataSource>
    extends TrackRepository<DataSource> {
  SavableTrackRepository(super.trackDataSource);

  FutureOrResult<BaseTrack> save(BaseTrack track);

  FutureVoidResult saveTrackAudioInfo(BaseTrack track, AudioInfoSet audioInfo);
}

abstract base class OnlineSourceTrackRepository<
        DataSource extends BaseRemoteTrackDataSource>
    extends TrackRepository<DataSource> {
  OnlineSourceTrackRepository(DataSource trackDataSource)
      : super(trackDataSource);

  FutureOrResult<AudioInfoSet> getTrackAudioInfo(
    BaseTrack track,
  ) async {
    return await _trackDataSource.getTrackAudioInfo(track.id);
  }
}
