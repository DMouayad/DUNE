import 'package:dune/domain/audio/factories/audio_info_set_factory.dart';
import 'package:dune/domain/audio/factories/track_factory.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../utils/isar_test_db.dart';
import '../../../utils/equality_helper.dart';

void main() {
  setUpAll(() async => await initIsarForTesting());
  setUp(() async => await refreshDatabase());
  test('it should save track in DB', () async {
    final track = TrackFactory().create();
    final fetchingTrackBefore = await isarMusicRepo.tracks.getById(track.id);
    // assert track not already present in the database
    expectLater(fetchingTrackBefore.requireValue == null, true);
    final savingResult = await isarMusicRepo.tracks.save(track);
    expectLater(savingResult.isSuccess, true);
    // now get the track by id and assert it's the same as saved one
    final fetchingTrackAfter = await isarMusicRepo.tracks.getById(track.id);
    expectLater(fetchingTrackAfter.requireValue != null, true);
    expectLater(
      EqualityHelper.tracksHasSameProps(
          fetchingTrackAfter.requireValue!, track),
      true,
    );
  });

  test('it should save track audio info in DB', () async {
    final track = TrackFactory().withoutAudioInfo().create();
    final fetchingTrackBefore = await isarMusicRepo.tracks.getById(track.id);
    // assert track doesn't already have an [AudioInfoSet]
    expectLater(fetchingTrackBefore.requireValue?.audioInfoSet, null);
    final audioInfoSet = AudioInfoSetFactory().create();
    final trackWithAudio = track.copyWith(audioInfoSet: audioInfoSet);
    // save the updated version of track which has an [AudioInfoSet]
    await isarMusicRepo.tracks.save(trackWithAudio);
    // now get the track by id and assert it has the same [audioInfoSet]
    final fetchingTrackAfter = await isarMusicRepo.tracks.getById(track.id);
    expectLater(fetchingTrackAfter.requireValue?.audioInfoSet, audioInfoSet);
  });
}