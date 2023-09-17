import 'package:dune/data/audio/isar/data_sources/isar_track_data_source.dart';
import 'package:dune/data/audio/isar/models/isar_track.dart';
import 'package:dune/domain/audio/base_models/track_audio_info.dart';
import 'package:dune/domain/audio/factories/track_factory.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../utils/isar_testing_utils.dart';

void main() {
  setUpAll(() async => await IsarTestingUtils.initIsarForTesting());
  setUp(() async => await IsarTestingUtils.refreshDatabase());

  test('it removes tracks in given directory', () async {
    // setup
    const dirPath = r'F:\some\folder';
    final dataSource = IsarTrackDataSource(IsarTestingUtils.isar);
    final baseTrack = TrackFactory().withAudioInfo(
      trackAudioInfo: [const TrackAudioInfo(url: '$dirPath\\file.mp3')],
    ).create();
    final addResult = await dataSource.save(IsarTrack.fromBase(baseTrack));
    expect(addResult.isSuccess, true);
    // act
    final removeResult = await dataSource.removeByDirectory(dirPath);
    expect(removeResult.isSuccess, true);
    expect(removeResult.requireValue.length, 1);
    // get tracks by this directory and assert none is found
    final retrieveAgainResult = await dataSource.getByDirectory(dirPath);
    expect(retrieveAgainResult.requireValue.isEmpty, true);
  });
}
