import 'package:dune/domain/audio/base_models/base_listening_history_month_summary.dart';
import 'package:dune/domain/use_cases/listening_history_month_summary_use_cases.dart';
import 'package:dune/support/utils/result/result.dart';

abstract class BaseListeningHistoryMonthSummaryDataSource<
        T extends BaseListeningHistoryMonthSummary>
    with ListeningHistoryMonthSummaryUseCases {
  FutureOrResult<BaseListeningHistoryMonthSummary> save(T instance);
}
