import 'dart:math';

import 'package:dune/domain/audio/base_models/base_track.dart';
import 'package:dune/presentation/providers/shared_providers.dart';
import 'package:dune/presentation/providers/state_controllers.dart';
import 'package:dune/presentation/screens/home/components/playback_control_buttons.dart';
import 'package:dune/presentation/screens/home/components/player_widgets/playback_seek_bar.dart';
import 'package:dune/presentation/screens/home/components/player_widgets/track_info.dart';
import 'package:dune/presentation/screens/home/components/player_widgets/volume_controls.dart';
import 'package:dune/support/extensions/context_extensions.dart';
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
    double getMaxImageWidth() {
      return min(70.0, railWidth! * .4);
    }

    super.build(context);

    if (railWidth != ref.watch(navigationRailSizeProvider)) {
      railWidth = ref.watch(navigationRailSizeProvider) ?? 56.0;
      maxImageWidth = getMaxImageWidth();
      updateKeepAlive();
    }
    railWidth ??= 56.0;
    maxImageWidth ??= getMaxImageWidth();
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
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                width: min(200.0, railWidth!),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flex(
                      direction: Axis.horizontal,
                      children: [
                        Expanded(
                          flex: 0,
                          child: TrackPlayerBarImage(
                            imageDimension: context.trackThumbnailDimension,
                            currentTrackThumbs: currentTrack?.thumbnails,
                          ),
                        ),
                        Expanded(
                          flex: 0,
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(
                              maxHeight: 50,
                              minHeight: 30,
                            ),
                            child: const PlayerBarTrackInfo(),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    const Expanded(child: SeekBar()),
                    const Expanded(flex: 0, child: PlaybackControlButtons()),
                    const Spacer(),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
              const Positioned(
                right: 4,
                bottom: 6,
                child: VolumeControls(),
              ),
            ],
          );
  }
}
