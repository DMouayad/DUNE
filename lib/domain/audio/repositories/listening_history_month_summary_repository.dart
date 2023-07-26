import 'package:dune/domain/audio/base_data_sources/base_listening_history_month_summary_data_source.dart';
import 'package:dune/domain/audio/base_data_sources/base_track_listening_history_data_source.dart';
import 'package:dune/domain/audio/base_models/base_listening_history_month_summary.dart';
import 'package:dune/domain/use_cases/listening_history_month_summary_use_cases.dart';
import 'package:dune/support/utils/result/result.dart';
import 'package:flutter/material.dart';

abstract class ListeningHistoryMonthSummaryRepository
    with ListeningHistoryMonthSummaryUseCases {
  final BaseListeningHistoryMonthSummaryDataSource _dataSource;
  final BaseTrackListeningHistoryDataSource _trackListeningHistoryDataSource;

  ListeningHistoryMonthSummaryRepository(
      this._dataSource, this._trackListeningHistoryDataSource);

  FutureResult<BaseListeningHistoryMonthSummary> createMonthSummary({
    required int month,
    required int year,
  });

  @override
  FutureResult<BaseListeningHistoryMonthSummary?> getMonthSummary({
    required int month,
    required int year,
  }) async {
    return (await _dataSource.getMonthSummary(month: month, year: year))
        .flatMapSuccessAsync((value) async {
      if (value == null) {
        // check if there's been any listening activity in this month
        final monthHasListeningActivity =
            await hasTrackListeningHistoriesInMonth(year: year, month: month)
                .then((result) => result.mapTo(
                      onSuccess: (value) => value,
                      onFailure: (_) => false,
                    ));
        // if yes then create a new summary and return it.
        if (monthHasListeningActivity) {
          return await createMonthSummary(month: month, year: year);
        }
      }
      return value.asResult;
    });
  }

  FutureResult<bool> hasTrackListeningHistoriesInMonth({
    required int month,
    required int year,
  }) async {
    return await _trackListeningHistoryDataSource.hasAnyHistoriesInDateRange(
      DateTimeRange(
        start: DateTime(year, month, 1),
        end: DateTime(year, month, 31),
      ),
    );
  }
}
