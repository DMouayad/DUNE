import 'package:dune/domain/audio/base_models/base_track.dart';
import 'package:dune/domain/audio/factories/playlist_factory.dart';
import 'package:dune/domain/audio/factories/track_factory.dart';
import 'package:dune/presentation/models/audio_player.dart';
import 'package:dune/presentation/utils/listening_history_helper.dart';
import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../utils/fake_models/fake_audio_player.dart';

late AudioPlayer player;
late FakeAudioPlayerStreams _streams;

/// A fake instance & wont be used since we're testing the [AudioPlayer] only.
final _listeningHistoryHelper = ListeningHistoryHelper(
  (p0) {},
  (p0) {},
  (p0, p1) {},
);

void main() {
  setUp(() {
    _streams = FakeAudioPlayerStreams();
    player = FakeAudioPlayer(_streams, _listeningHistoryHelper);
  });

  group('Player streams tests', () {
    test(
      'player should update its state when [AudioPlayerStreams.playing] emits'
      ' [true] and [player.currentTrack] is not null',
      () async {
        final track = TrackFactory().withAudioInfo().create();
        await player.playSingleTrack(track);
        expectLater(player.state.isPlaying, true);
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
    final playlist = PlaylistFactory().setTracksCount(10).create();

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
      final track1 = TrackFactory().withAudioInfo().create();
      // play first track and assert its playing
      await player.playSingleTrack(track1);
      expectLater(player.state.isPlaying, true);
      expectLater(player.state.currentTrack, track1);
      // now play the second track
      final track2 = TrackFactory().withAudioInfo().create();
      player.playSingleTrack(track2);
      expectLater(player.state.isPlaying, false);
      expectLater(player.state.isLoading, true);
    });
    test(
        '[player.state.isLoading] should be [false] when loading a new track is finished',
        () async {
      final track1 = TrackFactory().withAudioInfo().create();
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
    test(
      'player should have [track] in its [state.playerTracks]',
      () async {
        final track = TrackFactory().withAudioInfo().create();
        await player.playSingleTrack(track);
        await Future.delayed(const Duration(milliseconds: 100));
        expectLater(player.state.playerTracks.single, track);
      },
    );
    test(
      '[player.state.currentTrack] should match provided track'
      ' with player tracks is empty',
      () async {
        final track = TrackFactory().withAudioInfo().create();
        await player.playSingleTrack(track);
        expectLater(player.state.currentTrack, track);
      },
    );
    test(
        '[player.state.currentTrack] should match provided track'
        ' (with previously-played tracks)', () async {
      final playlist = PlaylistFactory().setTracksCount(10).create();
      await player.playPlaylist(playlist);
      final track = TrackFactory().withAudioInfo().create();
      await player.playSingleTrack(track);
      expectLater(player.state.currentTrack, track);
    });
    test(
        'calling [player.playSingleTrack] should set [state.currentPlaylist] to null',
        () async {
      final playlist = PlaylistFactory().setTracksCount(10).create();
      await player.playPlaylist(playlist);
      // assert [playlist] has been set as current.
      expectLater(player.state.currentPlaylist, playlist);
      // then play a single track
      final track = TrackFactory().withAudioInfo().create();
      await player.playSingleTrack(track);
      expectLater(player.state.currentTrack, track);
      expectLater(player.state.currentPlaylist, null);
    });
  });
}
