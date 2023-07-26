import 'package:dune/domain/audio/base_models/base_listening_history_month_summary.dart';
import 'package:dune/support/utils/result/result.dart';

mixin ListeningHistoryMonthSummaryUseCases {
  FutureResult<BaseListeningHistoryMonthSummary?> getMonthSummary({
    required int month,
    required int year,
  });
}
