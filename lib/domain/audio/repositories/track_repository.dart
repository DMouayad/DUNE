import 'package:dune/domain/audio/base_data_sources/base_track_data_source.dart';
import 'package:dune/domain/audio/base_models/audio_info_set.dart';
import 'package:dune/domain/audio/base_models/base_track.dart';
import 'package:dune/domain/audio/traits/finds_by_music_source.dart';
import 'package:dune/support/utils/result/result.dart';

base class TrackRepository<DataSource extends BaseTrackDataSource> {
  final DataSource _trackDataSource;

  const TrackRepository(this._trackDataSource);

  FutureOrResult<BaseTrack?> getById(String id) async {
    return await _trackDataSource.find(id);
  }
}

abstract base class SavableTrackRepository<
        DataSource extends BaseSavableTrackDataSource>
    extends TrackRepository<DataSource> with FindsByMusicSource<BaseTrack> {
  const SavableTrackRepository(super.trackDataSource);

  FutureOrResult<BaseTrack> save(BaseTrack track);

  FutureVoidResult saveTrackAudioInfo(BaseTrack track, AudioInfoSet audioInfo);
}

base class OnlineSourceTrackRepository<
        DataSource extends BaseRemoteTrackDataSource>
    extends TrackRepository<DataSource> {
  const OnlineSourceTrackRepository(DataSource trackDataSource)
      : super(trackDataSource);

  FutureOrResult<AudioInfoSet> getTrackAudioInfo(
    BaseTrack track,
  ) async {
    return await _trackDataSource.getTrackAudioInfo(track.id);
  }
}
