import 'package:dune/domain/audio/base_models/base_track.dart';
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

  BaseTrack? currentTrack;
  bool isLoadingTrack = false;

  @override
  Widget build(BuildContext context) {
    super.build(context);

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
            clipBehavior: Clip.antiAlias,
            fit: StackFit.expand,
            children: [
              Positioned(
                top: 0,
                left: 10,
                child: TrackPlayerBarImage(
                  imageDimension: context.trackThumbnailDimension,
                  currentTrackThumbs: currentTrack?.thumbnails,
                ),
              ),
              Positioned(
                top: 0,
                left: context.trackThumbnailDimension + 10,
                right: 6,
                child: const SizedBox(height: 50, child: PlayerBarTrackInfo()),
              ),
              const Positioned(top: 60, left: 12, right: 12, child: SeekBar()),
              const Positioned(
                bottom: 4,
                left: 0,
                right: 0,
                child: PlaybackControlButtons(),
              ),
              const Positioned(right: 2, bottom: 8, child: VolumeControls()),
            ],
          );
  }
}
