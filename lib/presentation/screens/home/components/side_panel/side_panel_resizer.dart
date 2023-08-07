import 'dart:math';

import 'package:dune/presentation/providers/state_controllers.dart';
import 'package:dune/presentation/providers/shared_providers.dart';
import 'package:dune/support/extensions/context_extensions.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluent_ui/fluent_ui.dart' as fluent_ui;
import 'package:dune/support/themes/fluent_app_themes.dart';

class SidePanelResizer extends ConsumerWidget {
  const SidePanelResizer({
    super.key,
    required this.maxWidth,
    required this.minWidth,
    required this.railWidth,
  });

  final double maxWidth;
  final double minWidth;
  final double railWidth;

  @override
  Widget build(BuildContext context, ref) {
    void setRailWidth(double newWidth) {
      if (newWidth != ref.watch(navigationRailSizeProvider)) {
        ref
            .read(navigationRailSizeProvider.notifier)
            .update((state) => newWidth);
        EasyDebounce.debounce("nav rail width", const Duration(seconds: 3), () {
          ref
              .read(appPreferencesController.notifier)
              .setLastSidePanelWidth(ref.watch(navigationRailSizeProvider));
        });
      }
    }

    void onResizeRail(DragUpdateDetails d) {
      /// If the resizer is being dragged to the left
      final isExpanding = !d.localPosition.dx.isNegative;

      /// New rail width is the sum of old width [railWidth]
      /// and new dx position of the resizer
      double newWidth = railWidth + d.localPosition.dx;
      // asserting its not bigger than the minimum rail width
      newWidth = max(minWidth, newWidth);

      if (isExpanding) {
        if (newWidth < maxWidth) {
          // if it's almost fully expanded, expand it immediately.
          if (newWidth >= (maxWidth * .8)) {
            newWidth = maxWidth;
          }
          setRailWidth(newWidth);
        }
      } else {
        if ((newWidth) > minWidth) {
          // if we reached 80px width, make it compact immediately.
          if (newWidth <= 90) {
            newWidth = minWidth;
          }
          setRailWidth(newWidth);
        }
      }
    }

    final isExtended = railWidth == maxWidth;
    return fluent_ui.Tooltip(
      message: isExtended ? "Double Tap to collapse" : "Double Tap to expand",
      style: FluentAppThemes.getTooltipTheme(context.isDarkMode),
      child: GestureDetector(
        onDoubleTap: () {
          setRailWidth(isExtended ? minWidth : maxWidth);
        },
        child: SizedBox(
          width: 4,
          child: fluent_ui.HoverButton(
            onHorizontalDragUpdate: onResizeRail,
            cursor: fluent_ui.SystemMouseCursors.resizeColumn,
            builder: (context, state) {
              return VerticalDivider(
                width: 1,
                color: context.colorScheme.surfaceVariant.withOpacity(.8),
              );
            },
          ),
        ),
      ),
    );
  }
}
