import 'package:dune/data/audio/isar/models/isar_track_listening_history.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../utils/isar_test_db.dart';

DateTime get date => DateTime.now();

void main() {
  setUpAll(() async => await initIsarForTesting());
  setUp(() async => await refreshDatabase());
  test(
    'it should return null when no tracks listening history exists for month',
    () async {
      final noTrackListeningHistoriesExists =
          (await isar.isarTrackListeningHistorys.count()) == 0;
      expectLater(noTrackListeningHistoriesExists, true);
      final result = await isarMusicRepo.listeningHistory.getMonthSummary(
        month: date.month,
        year: date.year,
      );
      expectLater(result.requireValue, null);
    },
  );

  test(
    "it should create a new [BaseListeningHistoryMonthSummary] when it's not found"
    " in the db and track listening histories in the month",
    () async {
      final monthSummaryBefore = (await isarMusicRepo.listeningHistory
              .getMonthSummary(month: date.month, year: date.year))
          .requireValue;
      // assert no month summary exists for [date.month]
      expectLater(monthSummaryBefore, null);
      await isarTrackListeningHistorySeeder.seedCount();
      final monthSummary = (await isarMusicRepo.listeningHistory
              .getMonthSummary(month: date.month, year: date.year))
          .requireValue;
      expectLater(monthSummary != null, true);
    },
  );
}
