import 'package:dune/domain/audio/base_data_sources/base_track_data_source.dart';
import 'package:dune/domain/audio/base_models/audio_info_set.dart';
import 'package:dune/domain/audio/base_models/base_track.dart';
import 'package:dune/domain/audio/repositories/track_repository.dart';
import 'package:dune/support/utils/result/result.dart';

final class FakeOnlineSourceTrackRepository
    extends OnlineSourceTrackRepository {
  FakeOnlineSourceTrackRepository({
    FutureOrResult<BaseTrack?>? findTrackResult,
    FutureOrResult<AudioInfoSet>? getTrackAudioInfoResult,
    FutureOrResult<List<BaseTrack>>? getWhereIdsResult,
  }) : super(
          FakeRemoteTrackDataSource(
              findTrackResult, getTrackAudioInfoResult, getWhereIdsResult),
        );
}

final class FakeRemoteTrackDataSource
    extends BaseRemoteTrackDataSource<BaseTrack> {
  final FutureOrResult<BaseTrack?>? findTrackResult;
  final FutureOrResult<AudioInfoSet>? getTrackAudioInfoResult;
  final FutureOrResult<List<BaseTrack>>? getWhereIdsResult;

  FakeRemoteTrackDataSource(
    this.findTrackResult,
    this.getTrackAudioInfoResult,
    this.getWhereIdsResult,
  );

  @override
  FutureOrResult<BaseTrack?> find(String trackId) async {
    return await findTrackResult!;
  }

  @override
  FutureOrResult<AudioInfoSet> getTrackAudioInfo(String trackId) async {
    return await getTrackAudioInfoResult!;
  }

  @override
  FutureOrResult<List<BaseTrack>> getWhereIds(List<String> ids) async {
    return await getWhereIdsResult!;
  }
}
