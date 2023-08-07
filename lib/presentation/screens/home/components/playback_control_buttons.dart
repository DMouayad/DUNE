import 'package:dune/presentation/providers/state_controllers.dart';
import 'package:dune/support/extensions/context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'player_widgets/play_pause_button.dart';

class PlaybackControlButtons extends ConsumerWidget {
  const PlaybackControlButtons({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final audioPlayer = ref.read(playbackControllerProvider.notifier);
    final playerState = ref.watch(playbackControllerProvider);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: const Icon(Icons.skip_previous),
          iconSize: context.isMobile ? 28 : 24,
          color: context.colorScheme.secondary,
          onPressed:
              playerState.isIdle ? null : () => audioPlayer.player.prev(),
        ),
        const PlayPauseButton(),
        IconButton(
          icon: const Icon(Icons.skip_next),
          iconSize: context.isMobile ? 28 : 24,
          color: context.colorScheme.secondary,
          onPressed:
              playerState.isIdle ? null : () => audioPlayer.player.next(),
        ),
      ],
    );
  }
}

class PlaybackOptionButton extends ConsumerWidget {
  final IconData iconData;
  final bool optionEnabled;
  final void Function()? onPressed;

  const PlaybackOptionButton({
    super.key,
    required this.iconData,
    required this.optionEnabled,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return IconButton(
      icon: Icon(
        iconData,
        color: optionEnabled
            ? context.colorScheme.primary
            : context.isDarkMode
                ? Colors.white54
                : Colors.black45,
      ),
      iconSize: context.isMobile ? null : 24,
      color: context.colorScheme.secondary,
      onPressed: onPressed,
    );
  }
}
