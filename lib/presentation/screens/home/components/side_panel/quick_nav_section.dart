import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluent_ui/fluent_ui.dart' as fluent;
import 'package:flutter_riverpod/flutter_riverpod.dart';

//
import 'package:dune/navigation/app_router.dart';
import 'package:dune/presentation/providers/state_controllers.dart';
import 'package:dune/support/extensions/context_extensions.dart';
import 'package:dune/support/themes/theme_constants.dart';

import 'library_dropdown_button.dart';
import 'playlists_dropdown_button.dart';

const _kButtonHeight = 38.0;

class QuickNavSection extends ConsumerWidget {
  QuickNavSection({
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
        height: showAllWhenMinimized ? null : _kButtonHeight,
        margin: const EdgeInsets.only(top: 10),
        alignment: Alignment.topCenter,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _NavButton(
              title: 'Explore',
              iconData: context.isDesktopPlatform
                  ? fluent.FluentIcons.compass_n_w
                  : CupertinoIcons.compass,
              onPressed: () =>
                  onDestinationSelected(QuickNavDestination.explorePage),
            ),
            _NavButton(
              title: 'Listening history',
              iconData: context.isDesktopPlatform
                  ? fluent.FluentIcons.analytics_view
                  : Icons.analytics_outlined,
              onPressed: () => onDestinationSelected(
                  QuickNavDestination.listeningHistoryPage),
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
    required this.title,
    required this.onPressed,
    required this.iconData,
  }) : super(key: UniqueKey());

  final void Function() onPressed;
  final IconData iconData;
  final String title;

  @override
  Widget build(BuildContext context) {
    return FilledButton.tonalIcon(
      label: Text(title),
      icon: Icon(iconData, size: 16),
      style: ButtonStyle(
        textStyle: MaterialStateProperty.all(context.textTheme.bodyMedium),
        alignment: Alignment.centerLeft,
        elevation: MaterialStateProperty.all(0),
        shape: MaterialStateProperty.all(
            const RoundedRectangleBorder(borderRadius: kBorderRadius)),
        fixedSize: MaterialStateProperty.all(
            const Size(double.infinity, _kButtonHeight)),
        padding: MaterialStateProperty.all(
            const EdgeInsets.symmetric(horizontal: 16, vertical: 2)),
        backgroundColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.hovered)) {
            return context.colorScheme.onInverseSurface;
          }
          return Colors.transparent;
        }),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        foregroundColor:
            MaterialStateProperty.all(context.colorScheme.secondary),
      ),
      onPressed: onPressed,
    );
  }
}
