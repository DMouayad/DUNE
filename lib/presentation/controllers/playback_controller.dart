import 'package:dune/presentation/models/audio_player.dart';
import 'package:dune/presentation/models/player_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PlaybackController extends StateNotifier<PlayerState> {
  final AudioPlayer player;
  static final _initialState = PlayerState.initial();

  PlaybackController(this.player) : super(_initialState) {
    player.stateStream.listen((event) {
      state = event;
    });
  }

  @override
  Future<void> dispose() async {
    await player.disposePlayer();
    super.dispose();
  }

  @override
  PlayerState get state => player.state;
}
