import 'package:dune/domain/audio/base_models/base_track.dart';
import 'package:dune/presentation/screens/home/components/player_widgets/track_info.dart';
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
    return Material(
      type: MaterialType.transparency,
      child: Container(
        color: context.colorScheme.surfaceVariant,
        padding: const EdgeInsets.only(left: 18),
        height: context.bottomPlayerBarHeight,
        child: Column(
          children: [
            const Expanded(
              flex: 0,
              child: SizedBox(
                height: 30,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(14, 14, 24, 0),
                  child: SeekBar(),
                ),
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 0,
                    child: TrackPlayerBarImage(
                      imageDimension: context.trackThumbnailDimension,
                      currentTrackThumbs: currentTrack?.thumbnails,
                    ),
                  ),
                  if (currentTrack != null)
                    SizedBox(
                      height: context.trackThumbnailDimension,
                      child: const PlayerBarTrackInfo(),
                    )
                  else
                    const Spacer(),
                  Expanded(
                    flex: 2,
                    child: Container(
                      margin: const EdgeInsets.only(
                          right: 10, bottom: 4.0, left: 8),
                      child: const PlaybackControlButtons(),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
