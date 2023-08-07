import 'package:dune/presentation/custom_widgets/dune_loading_widget.dart';
import 'package:dune/presentation/providers/state_controllers.dart';
import 'package:dune/support/extensions/context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PlayPauseButton extends ConsumerWidget {
  const PlayPauseButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final playerState = ref.watch(playbackControllerProvider);
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 200),
      transitionBuilder: (child, animation) {
        return ScaleTransition(scale: animation, child: child);
      },
      switchOutCurve: Curves.elasticIn,
      switchInCurve: Curves.decelerate,
      child: playerState.isLoading || playerState.isBuffering
          ? const DuneLoadingWidget(size: 20)
          : InkWell(
              key: Key(playerState.isPlaying.toString()),
              radius: 50,
              borderRadius: BorderRadius.circular(24),
              onTap: playerState.isIdle
                  ? null
                  : () => ref
                      .read(playbackControllerProvider.notifier)
                      .player
                      .startOrPause(),
              child: Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: context.colorScheme.secondaryContainer,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(8),
                ),
                margin: const EdgeInsets.symmetric(horizontal: 6),
                child: Center(
                  child: Icon(
                    playerState.isPlaying ? Icons.pause : Icons.play_arrow,
                    size: context.isMobile ? 30 : 28,
                    color: context.colorScheme.secondary,
                  ),
                ),
              ),
            ),
    );
  }
}
