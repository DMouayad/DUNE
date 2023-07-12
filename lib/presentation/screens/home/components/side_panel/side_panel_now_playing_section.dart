import 'dart:math';

import 'package:dune/presentation/screens/home/components/playback_control_buttons.dart';
import 'package:dune/presentation/screens/home/components/player_widgets/playback_seek_bar.dart';
import 'package:dune/presentation/screens/home/components/player_widgets/track_info.dart';
import 'package:dune/presentation/screens/home/components/player_widgets/volume_controls.dart';
import 'package:flutter/material.dart';

class SidePanelNowPlayingSection extends StatelessWidget {
  const SidePanelNowPlayingSection(this.parentWidth, {super.key});

  final double parentWidth;

  @override
  Widget build(BuildContext context) {
    final maxImageWidth = min(200.0, parentWidth * .8);
    return Stack(
      fit: StackFit.expand,
      children: [
        SizedBox(
          width: min(200.0, parentWidth),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            // mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: maxImageWidth,
                height: 140,
                child: TrackPlayerBarImage(imageDimension: maxImageWidth),
              ),
              SizedBox(
                width: parentWidth - 30,
                child: const ExpandableTrackInfo(),
              ),
              const Spacer(),
              SizedBox(
                  width: min(240.0, parentWidth - 40), child: const SeekBar()),
              const SizedBox(height: 26),
              const Expanded(child: PlaybackControlButtons()),
              const Spacer(),
            ],
          ),
        ),
        const Positioned(
          right: 4,
          bottom: 4,
          child: VolumeControls(),
        ),
      ],
    );
  }
}
