import 'package:dune/presentation/models/selection_state.dart';
import 'package:dune/support/extensions/context_extensions.dart';
import 'package:dune/support/themes/theme_constants.dart';
import 'package:flutter/material.dart';
import 'package:fluent_ui/fluent_ui.dart' as fluent;

import 'optional_parent_widget.dart';

class SelectableCard<CardItemType extends Object> extends StatelessWidget {
  const SelectableCard({
    super.key,
    required this.child,
    required this.selectionState,
    required this.onSelected,
    required this.popupMenu,
    required this.selectionKey,
    this.onTap,
  });

  final Widget child;
  final String selectionKey;
  final SelectionState<CardItemType> selectionState;
  final Widget popupMenu;

  final void Function() onSelected;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final isSelected = selectionState.selectedValues.containsKey(selectionKey);
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
                  color: context.colorScheme.onBackground.withOpacity(.3),
                  width: 2,
                )
              : BorderSide.none,
        ),
        borderOnForeground: true,
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
          hoverColor: onTap != null
              ? context.colorScheme.surfaceVariant.withOpacity(.3)
              : null,
          mouseCursor: onTap != null ? null : MouseCursor.defer,
          focusColor: context.colorScheme.primaryContainer,
          customBorder:
              const RoundedRectangleBorder(borderRadius: kBorderRadius),
          onTap: _onTap,
          borderRadius: kBorderRadius,
          child: child,
        ),
      ),
    );
  }

  void _onTap() {
    if (selectionState.selectionEnabled) {
      onSelected();
    } else if (onTap != null) {
      onTap!();
    }
  }
}

final flyoutController = fluent.FlyoutController();

void showTrackCardPopupMenu(
  BuildContext context,
  bool isSelected,
  Offset localPosition,
  Widget menu,
) {
  if (!context.isDesktopPlatform || isSelected) return;
  // This calculates the position of the flyout according to the parent navigator
  final box = context.findRenderObject() as RenderBox;
  final position = box.localToGlobal(
    localPosition,
    ancestor: Navigator.of(context).context.findRenderObject(),
  );
  flyoutController.showFlyout(
    barrierColor: Colors.transparent,
    position: position,
    builder: (context) => menu,
  );
}
