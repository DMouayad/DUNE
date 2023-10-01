import 'dart:math';

import 'package:dune/presentation/providers/shared_providers.dart';
import 'package:dune/support/extensions/context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluent_ui/fluent_ui.dart' as fluent_ui;
import 'package:dune/support/themes/fluent_app_themes.dart';

const _kSidePanelMinWidth = 50.0;

class SidePanelResizer extends ConsumerWidget {
  const SidePanelResizer({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final panelWidth = ref.watch(sidePanelSideProvider) ?? _kSidePanelMinWidth;
    final double maxWidth = context.maxNavRailWidth;
    void setRailWidth(double newWidth) {
      if (newWidth != panelWidth) {
        ref.read(sidePanelSideProvider.notifier).update((state) => newWidth);
      }
    }

    void onResizeRail(DragUpdateDetails d) {
      /// If the resizer is being dragged to the left
      final isExpanding = !d.localPosition.dx.isNegative;

      /// New rail width is the sum of old width [panelWidth]
      /// and new dx position of the resizer
      double newWidth = panelWidth + d.localPosition.dx;
      // asserting its not bigger than the minimum rail width
      newWidth = max(_kSidePanelMinWidth, newWidth);

      if (isExpanding) {
        if (newWidth < maxWidth) {
          // if it's almost fully expanded, expand it immediately.
          if (newWidth >= (maxWidth * .8)) {
            newWidth = maxWidth;
          }
          setRailWidth(newWidth);
        }
      } else {
        if ((newWidth) > _kSidePanelMinWidth) {
          // if we reached 80px width, make it compact immediately.
          if (newWidth <= 90) {
            newWidth = _kSidePanelMinWidth;
          }
          setRailWidth(newWidth);
        }
      }
    }

    final isExtended = panelWidth == maxWidth;
    return fluent_ui.Tooltip(
      message: isExtended ? "Double Tap to collapse" : "Double Tap to expand",
      style: FluentAppThemes.getTooltipTheme(context.isDarkMode),
      child: GestureDetector(
        onDoubleTap: () {
          setRailWidth(isExtended ? _kSidePanelMinWidth : maxWidth);
        },
        child: fluent_ui.HoverButton(
          onHorizontalDragUpdate: onResizeRail,
          cursor: fluent_ui.SystemMouseCursors.resizeColumn,
          builder: (context, state) {
            return const VerticalDivider(width: 8, color: Colors.transparent);
          },
        ),
      ),
    );
  }
}
