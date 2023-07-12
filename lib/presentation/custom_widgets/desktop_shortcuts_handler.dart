import 'package:dune/presentation/providers/state_controllers.dart';
import 'package:dune/presentation/providers/shared_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DesktopShortcutsHandler extends ConsumerWidget {
  const DesktopShortcutsHandler({Key? key, required this.child})
      : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context, ref) {
    return CallbackShortcuts(
      bindings: <ShortcutActivator, VoidCallback>{
        const SingleActivator(LogicalKeyboardKey.keyS, control: true): () {
          if (ref.watch(materialSearchBarControllerProvider).isOpen) {
            return;
          }
          ref.read(materialSearchBarControllerProvider).openView();
        },
        const SingleActivator(LogicalKeyboardKey.arrowUp, control: true): () {
          ref.read(playbackControllerProvider.notifier).player.increaseVolume();
        },
        const SingleActivator(LogicalKeyboardKey.arrowDown, control: true): () {
          ref.read(playbackControllerProvider.notifier).player.decreaseVolume();
        },
        const SingleActivator(LogicalKeyboardKey.arrowRight, control: true):
            () {
          ref.read(playbackControllerProvider.notifier).player.seek(
              ref.watch(playbackControllerProvider).position +
                  kSeekDurationStep);
        },
        const SingleActivator(LogicalKeyboardKey.arrowLeft, control: true): () {
          ref.read(playbackControllerProvider.notifier).player.seek(
              ref.watch(playbackControllerProvider).position -
                  kSeekDurationStep);
        },
        const SingleActivator(LogicalKeyboardKey.space): () {
          ref.read(playbackControllerProvider.notifier).player.startOrPause();
        },
        const SingleActivator(LogicalKeyboardKey.keyM, control: true): () {
          ref.read(playbackControllerProvider.notifier).player.toggleMute();
        },
        const SingleActivator(LogicalKeyboardKey.audioVolumeMute): () {
          ref.read(playbackControllerProvider.notifier).player.toggleMute();
        },
        const SingleActivator(LogicalKeyboardKey.mediaTrackNext): () {
          ref.read(playbackControllerProvider.notifier).player.next();
        },
        const SingleActivator(LogicalKeyboardKey.mediaTrackPrevious): () {
          ref.read(playbackControllerProvider.notifier).player.prev();
        },
        const SingleActivator(LogicalKeyboardKey.mediaPlayPause): () {
          ref.read(playbackControllerProvider.notifier).player.startOrPause();
        },
        const SingleActivator(LogicalKeyboardKey.escape): () {
          if (ref.watch(tracksSelectionControllerProvider
              .select((value) => value.selectionEnabled))) {
            ref
                .read(tracksSelectionControllerProvider.notifier)
                .cancelSelection();
          }
        },
      },
      child: Focus(
        autofocus: true,
        child: child,
      ),
    );
  }
}

const kSeekDurationStep = Duration(seconds: 5);
