import 'package:dune/presentation/screens/home/components/player_widgets/track_info.dart';
import 'package:dune/presentation/utils/constants.dart';
import 'package:dune/support/extensions/context_extensions.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../playback_control_buttons.dart';
import 'package:flutter/material.dart';

import '../player_widgets/playback_seek_bar.dart';

class PlayerBottomBar extends ConsumerWidget {
  const PlayerBottomBar({super.key});

  @override
  Widget build(BuildContext context, ref) {
    return Container(
      color: context.colorScheme.background,
      padding: const EdgeInsets.only(left: 12, bottom: 2),
      height: kBottomPlayerBarHeight,
      child: const Row(
        children: [
          Expanded(
            flex: 0,
            child: TrackPlayerBarImage(imageDimension: 46),
          ),
          Expanded(
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
                        child: PLayerBarTrackInfo(),
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
