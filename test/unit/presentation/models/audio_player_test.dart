import 'package:dune/domain/audio/base_models/base_track.dart';
import 'package:dune/presentation/models/audio_player.dart';
import 'package:dune/presentation/utils/listening_history_helper.dart';
import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../test_helpers/fake_models/fake_audio_player.dart';
import '../../../test_helpers/fake_models/fake_playlist.dart';
import '../../../test_helpers/fake_models/fake_track.dart';

late AudioPlayer player;
late FakeAudioPlayerStreams _streams;
final listeningHistoryHelper = ListeningHistoryHelper(
  (p0) {},
  (p0) {},
  (p0, p1) {},
);

void main() {
  setUp(() {
    _streams = FakeAudioPlayerStreams();
    player = FakeAudioPlayer(_streams, listeningHistoryHelper);
  });

  group('Player streams tests', () {
    test(
      'player should update its state when [AudioPlayerStreams.playing] emits'
      ' [true] and [player.currentTrack] is not null',
      () {
        final track = FakeTrackFactory().withAudioInfo().create();
        player.setCurrentTrack(track);
        _streams.playingStreamController.add(true);
        expect(player.state.isPlaying, true);
      },
    );
    test(
      'player should NOT update its state when [AudioPlayerStreams.playing] emits'
      ' [true] and [player.currentTrack] is null',
      () {
        // assert initial [state.isPlaying] is false
        expect(player.state.isPlaying, false);
        _streams.playingStreamController.add(true);
        expect(player.state.isPlaying, false);
      },
    );
    test(
      'player should update its state when [AudioPlayerStreams.playing] emits'
      ' [false]',
      () {
        _streams.playingStreamController.add(false);
        expect(player.state.isPlaying, false);
      },
    );
    test(
      'player should update its state when [AudioPlayerStreams.position] emits new value',
      () {
        const newPosition = Duration(seconds: 2);
        _streams.positionStreamController.add(newPosition);
        expect(player.state.position, newPosition);
      },
    );
    test(
      'player should update its state when [AudioPlayerStreams.duration] emits new value',
      () {
        expect(player.state.buffer, Duration.zero);
        const newDuration = Duration(seconds: 2);
        _streams.durationStreamController.add(newDuration);
        expect(player.state.duration, newDuration);
      },
    );
    test(
      'player should update its state when [AudioPlayerStreams.buffer] emits new value',
      () {
        expect(player.state.buffer, Duration.zero);
        const newBuffer = Duration(seconds: 2);
        _streams.bufferStreamController.add(newBuffer);
        expect(player.state.buffer, newBuffer);
      },
    );
    test(
      'player should update its state when [AudioPlayerStreams.buffering] emits new value',
      () {
        expect(player.state.isBuffering, false);
        const newValue = true;
        _streams.bufferingStreamController.add(newValue);
        expect(player.state.isBuffering, newValue);
      },
    );
    test(
      'player should update its state when [AudioPlayerStreams.volume] emits new value',
      () {
        const newValue = 20.0;
        expect(player.state.volume != newValue, true);
        _streams.volumeStreamController.add(newValue);
        expect(player.state.volume, newValue);
      },
    );
    test(
      'player should update its state when [AudioPlayerStreams.completed] emits new value',
      () {
        const newValue = true;
        expect(player.state.isCompleted, false);
        _streams.completedStreamController.add(newValue);
        expect(player.state.isCompleted, newValue);
      },
    );
  });
  group('player shuffle tests', () {
    test('calling [player.toggleShuffle] should enable shuffle when disabled',
        () {
      expect(player.state.shuffle, false);
      player.toggleShuffle();
      expect(player.state.shuffle, true);
    });
    test(
        'calling [player.toggleShuffle] should disable shuffle when it is enabled',
        () {
      player.toggleShuffle(enabled: true);
      expect(player.state.shuffle, true);
      player.toggleShuffle();
      expect(player.state.shuffle, false);
    });
  });
  group('[player.playPlaylist()] tests', () {
    BaseTrack? trackToPlay;
    final FakePlaylist playlist =
        FakePlaylistFactory().setTracksCount(10).create();

    test('it should update [player.state.currentPlaylist] to the provided one',
        () async {
      await player.playPlaylist(playlist, track: trackToPlay);
      expectLater(player.state.currentPlaylist, playlist);
    });
    test('it should start playing a track from provided playlist', () async {
      await player.playPlaylist(playlist, track: trackToPlay);
      expectLater(player.state.isPlaying, true);
      expectLater(playlist.tracks.contains(player.state.currentTrack), true);
    });
    test('it should play the provided track', () async {
      trackToPlay = faker.randomGenerator.element(playlist.tracks);
      await player.playPlaylist(playlist, track: trackToPlay);

      expectLater(player.state.isPlaying, true);
      expectLater(player.state.currentTrack, trackToPlay);
    });
  });

  group('playback tests', () {
    test('player should stop when loading a new track', () async {
      final track1 = FakeTrackFactory().withAudioInfo().create();
      // play first track and assert its playing
      await player.playSingleTrack(track1);
      expectLater(player.state.isPlaying, true);
      expectLater(player.state.currentTrack, track1);
      // now play the second track
      final track2 = FakeTrackFactory().withAudioInfo().create();
      player.playSingleTrack(track2);
      expectLater(player.state.isPlaying, false);
      expectLater(player.state.isLoading, true);
    });
    test('player should stop loading when loading a new track is finished',
        () async {
      final track1 = FakeTrackFactory().withAudioInfo().create();
      // play track
      player.playSingleTrack(track1);
      // immediately assert it's not playing and loading the track
      expect(player.state.isPlaying, false);
      expect(player.state.isLoading, true);
      // wait for the player to be play the track and assert loading is finished
      await Future.delayed(const Duration(seconds: 2));
      expectLater(player.state.isPlaying, true);
      expectLater(player.state.isLoading, false);
      expectLater(player.state.currentTrack, track1);
    });
  });
}
