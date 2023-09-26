import 'package:dune/navigation/app_router.dart';
import 'package:dune/presentation/providers/shared_providers.dart';
import 'package:dune/presentation/providers/state_controllers.dart';
import 'package:dune/support/extensions/context_extensions.dart';
import 'package:dune/support/themes/theme_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluent_ui/fluent_ui.dart' as fluent;
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'library_dropdown_button.dart';
import 'playlists_dropdown_button.dart';
import 'side_panel.dart';

const _kButtonWidth = 44.0;

class NavGrid extends ConsumerWidget {
  NavGrid({
    required this.extended,
    required this.onDestinationSelected,
  }) : super(key: UniqueKey());

  final void Function(QuickNavDestination dest) onDestinationSelected;
  final bool extended;

  @override
  Widget build(BuildContext context, ref) {
    final isVerticalTabsMode =
        ref.watch(appPreferencesController).tabsMode.isVertical;
    final showAllWhenMinimized = (isVerticalTabsMode && extended);
    return ClipRRect(
      clipBehavior: Clip.hardEdge,
      child: Container(
        height: showAllWhenMinimized ? null : _kButtonWidth,
        margin: const EdgeInsets.only(top: 10, bottom: 6),
        alignment: Alignment.topCenter,
        child: Wrap(
          spacing: 8,
          runSpacing: 6,
          alignment: WrapAlignment.spaceBetween,
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
              iconData: context.isDesktopPlatform
                  ? fluent.FluentIcons.settings
                  : Icons.settings_outlined,
              onPressed: () =>
                  onDestinationSelected(QuickNavDestination.settingsPage),
            ),
            _NavButton(
              iconData: context.isDesktopPlatform
                  ? fluent.FluentIcons.analytics_view
                  : Icons.analytics_outlined,
              onPressed: () => onDestinationSelected(
                  QuickNavDestination.listeningHistoryPage),
            ),
            _NavButton(
              iconData: context.isDesktopPlatform
                  ? fluent.FluentIcons.compass_n_w
                  : CupertinoIcons.compass,
              onPressed: () =>
                  onDestinationSelected(QuickNavDestination.explorePage),
            ),
            LibraryDropdownButton(onDestSelected: onDestinationSelected),
            const PlaylistsDropdownButton(),
          ],
        ),
      ),
    );
  }
}

class _NavButton extends StatelessWidget {
  _NavButton({
    required this.onPressed,
    required this.iconData,
    this.iconColor,
    this.backgroundColor,
  }) : super(key: UniqueKey());

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
          return backgroundColor ?? context.backgroundOnCard;
        }),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        foregroundColor: MaterialStateProperty.all(
          iconColor ?? context.colorScheme.onBackground,
        ),
      ),
      onPressed: onPressed,
      child: Icon(iconData, size: context.isDesktopPlatform ? 20 : 22),
    );
  }
}
