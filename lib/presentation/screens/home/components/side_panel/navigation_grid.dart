import 'package:dune/navigation/app_router.dart';
import 'package:dune/presentation/providers/shared_providers.dart';
import 'package:dune/presentation/providers/state_controllers.dart';
import 'package:dune/support/extensions/context_extensions.dart';
import 'package:dune/support/themes/theme_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluent_ui/fluent_ui.dart' as fluent;
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'side_panel.dart';

const _kButtonWidth = 44.0;

class NavGrid extends ConsumerWidget {
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
  Widget build(BuildContext context, ref) {
    final isVerticalTabsMode =
        ref.watch(appPreferencesController).tabsMode.isVertical;
    final showAllWhenMinimized = (isVerticalTabsMode && extended);
    return Container(
      height: showAllWhenMinimized ? null : _kButtonWidth,
      margin: const EdgeInsets.symmetric(vertical: 10),
      alignment: Alignment.center,
      child: Wrap(
        spacing: 8,
        runSpacing: 10,
        clipBehavior: Clip.hardEdge,
        children: [
          _NavButton(
            iconData: CupertinoIcons.sidebar_left,
            backgroundColor: Colors.transparent,
            iconColor: extended
                ? context.colorScheme.primary
                : context.colorScheme.onPrimaryContainer,
            onPressed: () {
              if (extended) {
                ref.read(navigationRailSizeProvider.notifier).state =
                    kSidePanelMinWidth;
              } else {
                ref.read(navigationRailSizeProvider.notifier).state =
                    context.maxNavRailWidth;
              }
            },
          ),
          _NavButton(
            iconData: fluent.FluentIcons.settings,
            onPressed: () =>
                onDestinationSelected(QuickNavDestination.settingsPage),
          ),
          _NavButton(
            iconData: CupertinoIcons.rectangle_stack_badge_person_crop,
            onPressed: () =>
                onDestinationSelected(QuickNavDestination.listeningHistoryPage),
          ),
          _NavButton(
            iconData: CupertinoIcons.compass,
            onPressed: () =>
                onDestinationSelected(QuickNavDestination.explorePage),
          ),
        ],
      ),
    );
  }
}

class _NavButton extends StatelessWidget {
  const _NavButton({
    required this.onPressed,
    required this.iconData,
    this.iconColor,
    this.backgroundColor,
  });

  final void Function() onPressed;
  final IconData iconData;
  final Color? iconColor;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return FilledButton.tonal(
      style: ButtonStyle(
        elevation: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.hovered)) {
            return 0;
          }
          return null;
        }),
        shape: MaterialStateProperty.all(
            const RoundedRectangleBorder(borderRadius: kBorderRadius)),
        fixedSize: MaterialStateProperty.all(const Size.square(_kButtonWidth)),
        padding: MaterialStateProperty.all(const EdgeInsets.all(4)),
        backgroundColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.hovered)) {
            return context.colorScheme.onInverseSurface;
          }
          return backgroundColor ?? context.colorScheme.background;
        }),
      ),
      onPressed: onPressed,
      child: Icon(
        iconData,
        size: 20,
        color: iconColor ?? context.colorScheme.onBackground,
      ),
    );
  }
}
