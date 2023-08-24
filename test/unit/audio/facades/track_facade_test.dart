import 'package:dune/domain/audio/base_models/audio_info_set.dart';
import 'package:dune/domain/audio/facades/music_facade.dart';
import 'package:dune/domain/audio/factories/track_audio_info_factory.dart';
import 'package:dune/domain/audio/factories/track_factory.dart';
import 'package:dune/support/enums/music_source.dart';
import 'package:dune/support/utils/result/result.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../utils/fake_repositories/fake_track_repository.dart';
import '../../../utils/isar_testing_utils.dart';

Future<TrackFacade> _setupFacadeWith({
  required FakeOnlineSourceTrackRepository youtubeRepository,
}) async {
  return TrackFacade(
    localTrackRepository: IsarTestingUtils.isarMusicRepo.tracks,
    youtubeTrackRepository: youtubeRepository,
  );
}

void main() {
  setUpAll(() async => await IsarTestingUtils.initIsarForTesting());
  setUp(() async => await IsarTestingUtils.refreshDatabase());
  group(
    'fetching items from YoutubeRepository when provided source is'
    '[MusicSource.youtube]',
    () {
      final ytTrackAudioInfo = TrackAudioInfoFactory()
          .setMusicSource(MusicSource.youtube)
          .createCount(4);
      late final TrackFacade facade;
      setUpAll(() async {
        facade = await _setupFacadeWith(
          youtubeRepository: FakeOnlineSourceTrackRepository(
            getTrackAudioInfoResult:
                AudioInfoSet(items: ytTrackAudioInfo).asResult,
          ),
        );
      });
      test(
          'it returns a list of [TrackAudioInfo] with the source([MusicSource.youtube])'
          'when provided source is [MusicSource.youtube]', () async {
        final audioInfoResult = await facade.getTrackAudioInfo(
          TrackFactory().setMusicSource(MusicSource.youtube).create(),
          musicSource: MusicSource.youtube,
        );
        expectLater(audioInfoResult.isSuccess, true);
        expectLater(
          audioInfoResult.requireValue.items
              .every((e) => e.musicSource == MusicSource.youtube),
          true,
        );
      });
    },
  );
}
