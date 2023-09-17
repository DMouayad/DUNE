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

  /// Stores all of the passed [BaseTrack] instances in the database.
  ///
  /// All function[save] function this
  FutureOrResult<List<BaseTrack>> saveAll(List<BaseTrack> tracks) async {
    final List<BaseTrack> result = [];
    for (BaseTrack track in tracks) {
      final savingTrackResult = await save(track);
      if (savingTrackResult.isSuccess) {
        result.add(savingTrackResult.requireValue);
      }
    }
    return result.asResult;
  }

  FutureVoidResult saveTrackAudioInfo(BaseTrack track, AudioInfoSet audioInfo);

  /// Removes all tracks in the directory at given [path].
  ///
  /// Returns the list of removed tracks.
  FutureResult<List<BaseTrack>> removeByDirectory(String path);
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
