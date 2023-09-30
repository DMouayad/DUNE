import 'package:dune/presentation/providers/state_controllers.dart';
import 'package:dune/support/extensions/context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart' as av;
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SeekBar extends ConsumerWidget {
  const SeekBar({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final playerState = ref.watch(playbackControllerProvider);
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: av.ProgressBar(
        barCapShape: av.BarCapShape.round,
        thumbGlowColor: context.colorScheme.primaryContainer,
        thumbColor: context.colorScheme.primary.withOpacity(.8),
        progressBarColor: context.colorScheme.primary.withOpacity(.8),
        baseBarColor: context.isDarkMode
            ? Colors.white12
            : context.colorScheme.secondary.withOpacity(.12),
        timeLabelTextStyle: context.textTheme.bodySmall?.copyWith(
          color: context.colorScheme.secondary.withOpacity(.7),
          fontWeight: FontWeight.w500,
        ),
        timeLabelLocation: av.TimeLabelLocation.none,
        thumbCanPaintOutsideBar: false,
        thumbGlowRadius: 8.0,
        thumbRadius: 5,
        barHeight: context.isDesktopPlatform ? 6 : 4,
        progress: playerState.position,
        buffered: playerState.buffer,
        total: playerState.duration,
        onSeek: playerState.isIdle
            ? null
            : (position) => ref
                .read(playbackControllerProvider.notifier)
                .player
                .seek(position),
      ),
    );
  }
}
