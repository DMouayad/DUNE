import 'package:dune/domain/audio/base_models/base_track.dart';
import 'package:dune/presentation/models/selection_state.dart';
import 'package:dune/support/extensions/context_extensions.dart';
import 'package:dune/support/themes/theme_constants.dart';
import 'package:flutter/material.dart';
import 'package:fluent_ui/fluent_ui.dart' as fluent;

import 'draggable_track_card.dart';
import 'optional_parent_widget.dart';
import 'track_card_pop_up_menu.dart';

class TrackCardWrapper extends StatelessWidget {
  const TrackCardWrapper({
    super.key,
    required this.track,
    required this.child,
    required this.selectionState,
    required this.onSelected,
    required this.onPlayTrack,
    required this.playOnTap,
    required this.popupMenu,
    this.onDelete,
    this.onDownload,
  });

  final BaseTrack track;
  final Widget child;
  final void Function() onPlayTrack;
  final void Function()? onDelete;
  final void Function()? onDownload;
  final SelectionState<BaseTrack> selectionState;
  final void Function() onSelected;
  final bool playOnTap;
  final TrackCardPopupMenu popupMenu;

  @override
  Widget build(BuildContext context) {
    final isSelected = selectionState.selectedValues.containsKey(track.id);
    return OptionalParentWidget(
      parentWidgetBuilder: (child) {
        return fluent.FlyoutTarget(
          controller: flyoutController,
          child: child,
        );
      },
      condition: context.isDesktopPlatform,
      childWidget: Material(
        color: context.colorScheme.background,
        shape: RoundedRectangleBorder(
          borderRadius: kBorderRadius,
          side: isSelected
              ? BorderSide(
                  color: context.colorScheme.onPrimaryContainer.withOpacity(.9),
                  width: 1.3,
                )
              : BorderSide.none,
        ),
        borderOnForeground: true,
        child: DraggableTrackCard(
          selectionState: selectionState,
          child: InkWell(
            onLongPress: onSelected,
            onSecondaryTapUp: (tapDetails) {
              showTrackCardPopupMenu(
                context,
                isSelected,
                tapDetails.localPosition,
                popupMenu,
              );
            },
            hoverColor: playOnTap ? context.colorScheme.primaryContainer : null,
            mouseCursor: playOnTap ? null : MouseCursor.defer,
            focusColor: context.colorScheme.primaryContainer,
            customBorder:
                const RoundedRectangleBorder(borderRadius: kBorderRadius),
            onTap: onTap,
            borderRadius: kBorderRadius,
            child: child,
          ),
        ),
      ),
    );
  }

  void onTap() {
    if (selectionState.selectionEnabled) {
      onSelected();
    } else if (playOnTap) {
      onPlayTrack();
    }
  }
}
