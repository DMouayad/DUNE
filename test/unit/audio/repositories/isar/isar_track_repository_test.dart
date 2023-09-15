import 'package:collection/collection.dart';
import 'package:dune/domain/audio/base_models/base_track.dart';
import 'package:dune/domain/audio/factories/audio_info_set_factory.dart';
import 'package:dune/domain/audio/factories/track_factory.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../utils/isar_testing_utils.dart';
import '../../../../utils/equality_helper.dart';

void main() {
  setUpAll(() async => await IsarTestingUtils.initIsarForTesting());
  setUp(() async => await IsarTestingUtils.refreshDatabase());
  Future<BaseTrack?> saveThenFetchTrack(BaseTrack track) async {
    final savingResult =
        await IsarTestingUtils.isarMusicRepo.tracks.save(track);
    if (savingResult.isFailure) return null;
    // now get the track by id
    return (await IsarTestingUtils.isarMusicRepo.tracks.getById(track.id))
        .requireValue;
  }

  test('it should save track in DB', () async {
    final track = TrackFactory().create();
    final fetchingTrackBefore =
        await IsarTestingUtils.isarMusicRepo.tracks.getById(track.id);
    // assert track isn't already saved in the database
    expectLater(fetchingTrackBefore.requireValue == null, true);
    // now save the track then fetch it again
    final savedTrack = await saveThenFetchTrack(track);
    expectLater(savedTrack != null, true);
  });
  test('all track properties should be saved', () async {
    /// the track-to-save
    final track = TrackFactory().create();
    final savedTrack = await saveThenFetchTrack(track);

    final firstProps = List.from(track.props);
    firstProps.remove(track.artists);
    firstProps.remove(track.album);
    final secondProps = List.from(savedTrack!.props);
    secondProps.remove(savedTrack.artists);
    secondProps.remove(savedTrack.album);
    // assert both tracks properties(without album&artists) are the same
    expectLater(const ListEquality().equals(firstProps, secondProps), true);
    expectLater(
      EqualityHelper.albumsHasSameProps(track.album, savedTrack.album),
      true,
    );
    expectLater(
      EqualityHelper.tracksHasSameArtists(track, savedTrack),
      true,
    );
  });
  test('it should save track audio info in DB', () async {
    final track = TrackFactory().withoutAudioInfo().create();
    final fetchingTrackBefore =
        await IsarTestingUtils.isarMusicRepo.tracks.getById(track.id);
    // assert track doesn't already have an [AudioInfoSet]
    expectLater(fetchingTrackBefore.requireValue?.audioInfoSet, null);

    final audioInfoSet = AudioInfoSetFactory().create();
    final trackWithAudio = track.copyWith(audioInfoSet: audioInfoSet);

    // save the updated version of track which has an [AudioInfoSet]
    await IsarTestingUtils.isarMusicRepo.tracks.save(trackWithAudio);

    // now get the track by id and assert it has the same [audioInfoSet]
    final fetchingTrackAfter =
        await IsarTestingUtils.isarMusicRepo.tracks.getById(track.id);
    expectLater(fetchingTrackAfter.requireValue?.audioInfoSet, audioInfoSet);
  });
}
