import 'package:dune/navigation/app_router.dart';
import 'package:dune/presentation/providers/shared_providers.dart';
import 'package:dune/support/extensions/context_extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluent_ui/fluent_ui.dart' as fluent;
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'side_panel.dart';

const _kButtonWidth = 52.0;

class NavGrid extends StatelessWidget {
  const NavGrid({
    super.key,
    required this.extended,
    required this.width,
    required this.onDestinationSelected,
  });

  final void Function(QuickNavDestination dest) onDestinationSelected;
  final bool extended;
  final double width;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      height: _kButtonWidth,
      duration: const Duration(milliseconds: 170),
      margin: const EdgeInsets.symmetric(vertical: 10),
      alignment: Alignment.centerLeft,
      width: extended ? width : _kButtonWidth,
      child: GridView(
        padding: EdgeInsets.zero,
        scrollDirection: Axis.horizontal,
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          mainAxisExtent: _kButtonWidth,
          mainAxisSpacing: 10,
          crossAxisCount: 1,
        ),
        children: [
          Consumer(builder: (context, ref, _) {
            return _NavButton(
              iconData: CupertinoIcons.sidebar_left,
              iconColor: extended ? context.colorScheme.primary : null,
              onPressed: () {
                if (extended) {
                  ref.read(navigationRailSizeProvider.notifier).state =
                      kSidePanelMinWidth;
                } else {
                  ref.read(navigationRailSizeProvider.notifier).state =
                      context.maxNavRailWidth;
                }
              },
            );
          }),
          if (extended) ...[
            Visibility(
              visible: extended,
              child: _NavButton(
                iconData: fluent.FluentIcons.settings,
                iconSize: 20,
                onPressed: () =>
                    onDestinationSelected(QuickNavDestination.settingsPage),
              ),
            ),
            Visibility(
              visible: extended,
              child: _NavButton(
                iconData: CupertinoIcons.rectangle_stack_badge_person_crop,
                onPressed: () => onDestinationSelected(
                    QuickNavDestination.listeningHistoryPage),
              ),
            ),
            Visibility(
              visible: extended,
              child: _NavButton(
                iconData: CupertinoIcons.compass,
                onPressed: () =>
                    onDestinationSelected(QuickNavDestination.explorePage),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _NavButton extends StatelessWidget {
  const _NavButton({
    required this.onPressed,
    required this.iconData,
    this.iconSize,
    this.iconColor,
  });

  final void Function() onPressed;
  final IconData iconData;
  final double? iconSize;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    return FilledButton.tonal(
      style: ButtonStyle(
        shape: MaterialStateProperty.all(RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        )),
        backgroundColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.hovered)) {
            return context.colorScheme.surfaceVariant.withOpacity(.21);
          }
          if (states.contains(MaterialState.selected)) {
            return Colors.red;
          }
          return context.colorScheme.background;
        }),
      ),
      onPressed: onPressed,
      child: Icon(
        iconData,
        size: iconSize ?? 23,
        color: iconColor ?? context.colorScheme.secondary,
      ),
    );
  }
}
