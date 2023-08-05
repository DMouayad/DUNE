import 'package:dune/presentation/providers/state_controllers.dart';
import 'package:dune/support/extensions/context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluent_ui/fluent_ui.dart' as fluent;

class VolumeControls extends ConsumerStatefulWidget {
  const VolumeControls({super.key});

  @override
  ConsumerState<VolumeControls> createState() => _VolumeControlsState();
}

class _VolumeControlsState extends ConsumerState<VolumeControls> {
  bool showSlider = false;

  @override
  Widget build(BuildContext context) {
    final audioPlayer = ref.watch(playbackControllerProvider.notifier);
    final playerState = ref.watch(playbackControllerProvider);
    ref.listen(playbackControllerProvider, (prev, next) {
      if (prev?.volume != next.volume) {
        if (!showSlider) {
          setState(() => showSlider = true);
          Future.delayed(const Duration(seconds: 3), () {
            setState(() => showSlider = false);
          });
        }
      }
    });
    final isMuted = playerState.volume == 0.0;

    return InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: () {
        if (isMuted) {
          audioPlayer.player.setVolume(25.0);
        } else {
          audioPlayer.player.setVolume(0.0);
        }
      },
      onHover: (isHovered) {
        if (isHovered) {
          if (!showSlider) setState(() => showSlider = true);
        } else {
          if (showSlider) setState(() => showSlider = false);
        }
      },
      child: Container(
        width: 44,
        margin: const EdgeInsets.only(bottom: 6),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (showSlider)
              Card(
                color: context.colorScheme.background,
                elevation: 3,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                  child: SizedBox(
                    height: 90,
                    width: 44,
                    child: fluent.Slider(
                      value: playerState.volume,
                      vertical: true,
                      min: 0.0,
                      max: 100,
                      style: fluent.SliderThemeData(
                        labelForegroundColor: context.colorScheme.onBackground,
                      ),
                      onChanged: audioPlayer.player.setVolume,
                    ),
                  ),
                ),
              ),
            // if (!showSlider)
            Icon(
              isMuted ? Icons.volume_off_rounded : Icons.volume_up,
              color: isMuted ? Colors.red : context.colorScheme.secondary,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}
