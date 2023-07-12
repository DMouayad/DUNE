import 'package:dune/domain/audio/base_models/base_play_history.dart';
import 'package:dune/domain/audio/base_models/base_playlist.dart';
import 'package:dune/domain/audio/base_models/base_track.dart';
import 'package:dune/support/utils/result/result.dart';

abstract interface class BaseUserListeningHistoryRepository {
  FutureOrResult<BaseListeningHistory> incrementTrackCompletedListensCount(
      BaseTrack track, DateTime date);

  FutureOrResult<BaseListeningHistory> addToTrackUncompletedListensDuration(
      BaseTrack track, DateTime date, Duration duration);

  FutureOrResult<BaseListeningHistory> addPlaylist(
      BasePlaylist playlist, DateTime date);

  FutureOrResult<List<BaseListeningHistory>> getByDates(List<DateTime> dates);

  FutureOrResult<List<BaseListeningHistory>> getByRange(
      DateTime startDate, DateTime endDate);

  FutureOrResult<List<BaseListeningHistory>> searchFor(String text);
}
