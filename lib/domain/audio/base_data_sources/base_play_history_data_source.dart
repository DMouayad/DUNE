import 'package:dune/domain/audio/base_models/base_play_history.dart';
import 'package:dune/domain/audio/base_models/base_playlist.dart';
import 'package:dune/domain/audio/base_models/base_track.dart';
import 'package:dune/support/utils/result/result.dart';

abstract class BaseListeningHistoryDataSource<
    ListeningHistoryType extends BaseListeningHistory,
    TrackType extends BaseTrack,
    PlaylistType extends BasePlaylist> {
  FutureOrResult<VoidValue> save(ListeningHistoryType instance);

  FutureOrResult<ListeningHistoryType?> getByDate(DateTime date);

  FutureOrResult<List<ListeningHistoryType>> getByDates(List<DateTime> dates);

  FutureOrResult<List<ListeningHistoryType>> getByRange(
      DateTime startDate, DateTime endDate);

  FutureOrResult<List<ListeningHistoryType>> getAll();

  FutureOrResult<List<ListeningHistoryType>> searchFor(String text);
}
