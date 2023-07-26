import 'package:dune/domain/audio/base_models/base_listening_history_month_summary.dart';
import 'package:isar/isar.dart';

part 'isar_track_month_listening_history.g.dart';

@Embedded(ignore: {
  'props',
  'hashCode',
  'stringify',
  'derived',
  'track',
})
final class IsarMonthListeningHistoryTrackSummary
    extends MonthListeningHistoryTrackSummary {
  final String? trackId;

  IsarMonthListeningHistoryTrackSummary({
    this.trackId,
    super.track,
    super.completedListensCount,
    super.totalListeningMinutes,
  });

  @override
  Set<Type> get derived => {MonthListeningHistoryTrackSummary};
}
