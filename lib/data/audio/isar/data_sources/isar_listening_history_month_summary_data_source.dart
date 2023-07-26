import 'package:dune/data/audio/isar/models/isar_listening_history_month_summary.dart';
import 'package:dune/domain/audio/base_data_sources/base_listening_history_month_summary_data_source.dart';
import 'package:dune/domain/audio/base_models/base_listening_history_month_summary.dart';
import 'package:dune/support/utils/result/result.dart';
import 'package:isar/isar.dart';

class IsarListeningHistoryMonthSummaryDataSource
    extends BaseListeningHistoryMonthSummaryDataSource<
        IsarListeningHistoryMonthSummary> {
  final Isar _isar;

  IsarListeningHistoryMonthSummaryDataSource(this._isar);

  @override
  FutureResult<BaseListeningHistoryMonthSummary?> getMonthSummary({
    required int month,
    required int year,
  }) async {
    return await Result.fromAsync(() async {
      return await _isar.isarListeningHistoryMonthSummarys
          .where()
          .monthYearEqualTo(month, year)
          .findFirst();
    });
  }

  @override
  FutureOrResult<BaseListeningHistoryMonthSummary> save(
    IsarListeningHistoryMonthSummary instance,
  ) async {
    return await Result.fromAsync(() async {
      return await _isar.writeTxn(() async {
        final isarId =
            await _isar.isarListeningHistoryMonthSummarys.put(instance);
        return instance.copyWith(id: isarId);
      });
    });
  }
}
