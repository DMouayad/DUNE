import 'dart:math';

import 'package:dune/domain/audio/base_models/base_track.dart';
import 'package:dune/presentation/providers/shared_providers.dart';
import 'package:dune/presentation/providers/state_controllers.dart';
import 'package:dune/presentation/screens/home/components/playback_control_buttons.dart';
import 'package:dune/presentation/screens/home/components/player_widgets/playback_seek_bar.dart';
import 'package:dune/presentation/screens/home/components/player_widgets/track_info.dart';
import 'package:dune/presentation/screens/home/components/player_widgets/volume_controls.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SidePanelNowPlayingSection extends ConsumerStatefulWidget {
  const SidePanelNowPlayingSection({super.key});

  @override
  ConsumerState<SidePanelNowPlayingSection> createState() =>
      _SidePanelNowPlayingSectionState();
}

class _SidePanelNowPlayingSectionState
    extends ConsumerState<SidePanelNowPlayingSection>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  double? maxImageWidth;
  double? railWidth;
  BaseTrack? currentTrack;
  bool isLoadingTrack = false;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    if (railWidth != ref.watch(navigationRailSizeProvider)) {
      railWidth = ref.watch(navigationRailSizeProvider) ?? 56.0;
      maxImageWidth = min(200.0, railWidth! * .8);
      updateKeepAlive();
    }
    railWidth ??= 56.0;
    maxImageWidth ??= min(200.0, railWidth! * .8);
    if (isLoadingTrack != ref.watch(playbackControllerProvider).isLoading) {
      isLoadingTrack = ref.watch(playbackControllerProvider).isLoading;
      updateKeepAlive();
    }
    if (currentTrack?.id !=
        ref.watch(playbackControllerProvider).currentTrack?.id) {
      currentTrack = ref.watch(playbackControllerProvider).currentTrack;
      updateKeepAlive();
    }
    return !(isLoadingTrack || currentTrack != null)
        ? const SizedBox.shrink()
        : Stack(
            fit: StackFit.expand,
            children: [
              SizedBox(
                width: min(200.0, railWidth!),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: maxImageWidth,
                      height: 140,
                      child: TrackPlayerBarImage(
                        imageDimension: maxImageWidth!,
                        currentTrackThumbs: currentTrack?.thumbnails,
                      ),
                    ),
                    SizedBox(
                      width: railWidth! - 30,
                      child: ExpandableTrackInfo(currentTrack),
                    ),
                    const Spacer(),
                    SizedBox(
                        width: min(240.0, railWidth! - 40),
                        child: const SeekBar()),
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
