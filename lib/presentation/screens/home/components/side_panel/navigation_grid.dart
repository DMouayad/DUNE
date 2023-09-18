import 'package:dune/navigation/app_router.dart';
import 'package:dune/presentation/providers/shared_providers.dart';
import 'package:dune/support/extensions/context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'side_panel.dart';

const _kButtonWidth = 54.0;

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
      alignment: Alignment.centerLeft,
      width: extended ? width : _kButtonWidth,
      child: GridView(
        padding: EdgeInsets.zero,
        scrollDirection: Axis.horizontal,
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          mainAxisExtent: _kButtonWidth,
          mainAxisSpacing: 8,
          crossAxisCount: 1,
        ),
        children: [
          Consumer(
            builder: (BuildContext context, WidgetRef ref, Widget? child) {
              return _NavButton(
                iconData: Icons.menu,
                backgroundColor:
                    extended ? context.colorScheme.surfaceVariant : null,
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
            },
          ),
          if (extended) ...[
            Visibility(
              visible: extended,
              child: _NavButton(
                iconData: Icons.settings_outlined,
                onPressed: () =>
                    onDestinationSelected(QuickNavDestination.settingsPage),
              ),
            ),
            Visibility(
              visible: extended,
              child: _NavButton(
                iconData: Icons.work_history_outlined,
                onPressed: () => onDestinationSelected(
                    QuickNavDestination.listeningHistoryPage),
              ),
            ),
            Visibility(
              visible: extended,
              child: _NavButton(
                iconData: Icons.explore_outlined,
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
    this.backgroundColor,
  });

  final void Function() onPressed;
  final IconData iconData;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(14),
      onTap: onPressed,
      child: Container(
        width: _kButtonWidth,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: backgroundColor ??
              context.colorScheme.surfaceVariant.withOpacity(.3),
        ),
        child: Icon(
          iconData,
          size: 20,
          color: context.colorScheme.primary,
        ),
      ),
    );
  }
}
