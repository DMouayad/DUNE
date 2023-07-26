import 'package:dune/domain/audio/base_models/base_track.dart';
import 'package:dune/presentation/screens/home/components/player_widgets/track_info.dart';
import 'package:dune/presentation/utils/constants.dart';
import 'package:dune/support/extensions/context_extensions.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../providers/state_controllers.dart';
import '../playback_control_buttons.dart';
import 'package:flutter/material.dart';

import '../player_widgets/playback_seek_bar.dart';

class PlayerBottomBar extends ConsumerStatefulWidget {
  const PlayerBottomBar({super.key});

  @override
  ConsumerState<PlayerBottomBar> createState() => _PlayerBottomBarState();
}

class _PlayerBottomBarState extends ConsumerState<PlayerBottomBar>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  BaseTrack? currentTrack;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final playbackStateTrack =
        ref.watch(playbackControllerProvider).currentTrack;
    if (currentTrack?.id != playbackStateTrack?.id) {
      currentTrack = playbackStateTrack;
      updateKeepAlive();
    }
    return Container(
      color: context.colorScheme.background,
      padding: const EdgeInsets.only(left: 12, bottom: 2),
      height: kBottomPlayerBarHeight,
      child: Row(
        children: [
          Expanded(
            flex: 0,
            child: TrackPlayerBarImage(
              imageDimension: 46,
              currentTrackThumbs: currentTrack?.thumbnails,
            ),
          ),
          const Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(14, 4, 24, 0),
                  child: SeekBar(),
                ),
                Expanded(
                  child: Stack(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 10.0),
                        child: PlayerBarTrackInfo(),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: PlaybackControlButtons(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
