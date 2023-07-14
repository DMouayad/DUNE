import 'package:dune/domain/audio/base_models/base_track.dart';
import 'package:dune/presentation/providers/state_controllers.dart';
import 'package:dune/support/extensions/context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:fluent_ui/fluent_ui.dart' as fluent;
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'draggable_track_card.dart';
import 'optional_parent_widget.dart';

final flyoutController = fluent.FlyoutController();

class TrackCardWrapper extends ConsumerWidget {
  const TrackCardWrapper({
    super.key,
    required this.track,
    required this.child,
    required this.cardColor,
    this.onPlayTrack,
    this.onDelete,
    this.onDownload,
  });

  final BaseTrack track;
  final Widget child;
  final void Function()? onPlayTrack;
  final void Function()? onDelete;
  final void Function()? onDownload;
  final Color cardColor;

  @override
  Widget build(BuildContext context, ref) {
    final isSelected = ref
        .watch(tracksSelectionControllerProvider)
        .selectedValues
        .containsKey(track.id);
    final tappingEnabled = onPlayTrack != null || isSelected;
    return fluent.FlyoutTarget(
      controller: flyoutController,
      child: OptionalParentWidget(
        parentWidgetBuilder: (child) {
          return Tooltip(
            message: isSelected ? "Tap to unselect" : "Tap to play",
            waitDuration: const Duration(milliseconds: 1000),
            child: child,
          );
        },
        condition: tappingEnabled,
        childWidget: Material(
          color: cardColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: isSelected
                ? BorderSide(
                    color:
                        context.colorScheme.onPrimaryContainer.withOpacity(.9),
                    // strokeAlign: BorderSide.strokeAlignOutside,
                    width: 1.3,
                  )
                : BorderSide.none,
          ),
          borderOnForeground: true,
          child: DraggableTrackCard(
            child: InkWell(
              onSecondaryTapUp: (tapDetails) {
                if (!context.isDesktopPlatform || isSelected) return;
                // This calculates the position of the flyout according to the parent navigator
                final box = context.findRenderObject() as RenderBox;
                final position = box.localToGlobal(
                  tapDetails.localPosition,
                  ancestor: Navigator.of(context).context.findRenderObject(),
                );
                flyoutController.showFlyout(
                  barrierColor: Colors.transparent,
                  position: position,
                  builder: (context) {
                    return TrackPopupMenu(
                      track,
                      onDelete: onDelete,
                      onDownload: onDownload,
                    );
                  },
                );
              },
              hoverColor: tappingEnabled
                  ? context.colorScheme.primaryContainer
                  : context.colorScheme.surfaceVariant,
              mouseCursor: tappingEnabled ? null : MouseCursor.defer,
              focusColor: context.colorScheme.primaryContainer,
              customBorder: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              onTap: () => onTap(ref),
              borderRadius: BorderRadius.circular(10),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
                child: child,
              ),
            ),
          ),
        ),
      ),
    );
  }

  void onTap(WidgetRef ref) {
    final isSelectionMode = ref.watch(tracksSelectionControllerProvider
        .select((value) => value.selectionEnabled));
    if (isSelectionMode) {
      ref
          .read(tracksSelectionControllerProvider.notifier)
          .toggleSelectionForItem(track.id, track);
    } else if (onPlayTrack != null) {
      onPlayTrack!();
    }
  }
}

class TrackPopupMenu extends ConsumerWidget {
  const TrackPopupMenu(
    this.track, {
    this.onDelete,
    this.onDownload,
    super.key,
  });

  final BaseTrack track;
  final void Function()? onDelete;
  final void Function()? onDownload;

  @override
  Widget build(BuildContext context, ref) {
    return fluent.MenuFlyout(
      items: [
        fluent.MenuFlyoutItem(
          leading: const Icon(fluent.FluentIcons.multi_select),
          text: const Text('Select'),
          onPressed: () {
            ref
                .read(tracksSelectionControllerProvider.notifier)
                .toggleSelectionForItem(track.id, track);
            fluent.Flyout.of(context).close();
          },
        ),
        if (onDownload != null)
          fluent.MenuFlyoutItem(
            leading: const Icon(fluent.FluentIcons.download),
            text: const Text('Download'),
            onPressed: onDownload != null
                ? () {
                    onDownload!();
                    fluent.Flyout.of(context).close();
                  }
                : null,
          ),
        if (onDelete != null)
          fluent.MenuFlyoutItem(
            leading: const Icon(fluent.FluentIcons.delete),
            text: const Text('Delete'),
            onPressed: onDelete != null
                ? () {
                    onDelete!();
                    fluent.Flyout.of(context).close();
                  }
                : null,
          ),
      ],
    );
  }
}
