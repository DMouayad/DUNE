import 'dart:math';

import 'package:dune/data/audio/isar/models/isar_track_listening_history.dart';
import 'package:dune/domain/audio/base_models/base_track.dart';
import 'package:dune/domain/audio/base_models/base_track_listening_history.dart';
import 'package:dune/support/extensions/extensions.dart';
import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';

import '../test_helpers/fake_models/fake_track.dart';
import '../test_helpers/isar_test_db.dart';

Future<BaseTrackListeningHistory> createHistoryForTrack(
    BaseTrack track, DateTime date) async {
  final completedListensCount = faker.randomGenerator.integer(50);

  final result1 = await isarMusicRepo.listeningHistory
      .incrementTrackCompletedListensCount(track, date);

  final trackHistory = result1.requireValue.tracksListeningHistory
      .whereKey(date.onlyDate)
      ?.firstWhereOrNull((element) => element.track?.id == track.id);

  await isar.writeTxn(() async => await isar.isarTrackListeningHistorys.put(
      trackHistory!.copyWith(completedListensCount: completedListensCount)));
  final duration = Duration(seconds: faker.randomGenerator.integer(1000));
  final result2 =
      await isarMusicRepo.listeningHistory.addToTrackUncompletedListensDuration(
    track,
    date,
    duration,
  );
  final trackListeningHistory = result2.requireValue.tracksListeningHistory
      .whereKey(date.onlyDate)
      ?.firstWhereOrNull((element) => element.track?.id == track.id);
  return trackListeningHistory!;
}

DateTime get now => DateTime.now();

DateTime get _randomDate => faker.date.dateTimeBetween(
    DateTime(now.year, now.month), DateTime(now.year, now.month, 32));

Future<List<BaseTrackListeningHistory>> createTracksListeningHistories([
  DateTime? date,
]) async {
  final tracks = FakeTrackFactory().createCount(Random().nextInt(30));
  final histories = <BaseTrackListeningHistory>[];

  for (var track in tracks) {
    histories.add(
      await createHistoryForTrack(track, date ?? _randomDate),
    );
  }
  return histories;
}
