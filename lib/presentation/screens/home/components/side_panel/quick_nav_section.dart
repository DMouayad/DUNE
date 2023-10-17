import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluent_ui/fluent_ui.dart' as fluent;

//
import 'package:dune/support/enums/quick_nav_destination.dart';
import 'package:dune/support/extensions/context_extensions.dart';
import 'package:dune/support/themes/theme_constants.dart';

import 'library_dropdown_button.dart';
import 'playlists_dropdown_button.dart';

class QuickNavSection extends StatelessWidget {
  QuickNavSection({required this.onDestinationSelected})
      : super(key: UniqueKey());

  final void Function(QuickNavDestination dest) onDestinationSelected;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 0,
          child: QuickNavDestinationButton(
            title: 'Explore',
            iconData: context.isDesktopPlatform
                ? fluent.FluentIcons.compass_n_w
                : CupertinoIcons.compass,
            onPressed: () =>
                onDestinationSelected(QuickNavDestination.explorePage),
          ),
        ),
        Expanded(
          flex: 0,
          child: QuickNavDestinationButton(
            title: 'Listening history',
            iconData: context.isDesktopPlatform
                ? fluent.FluentIcons.analytics_view
                : Icons.analytics_outlined,
            onPressed: () =>
                onDestinationSelected(QuickNavDestination.listeningHistoryPage),
          ),
        ),
        Expanded(
          flex: 0,
          child: LibraryDropdownButton(onDestSelected: onDestinationSelected),
        ),
        const Expanded(
          flex: 0,
          child: PlaylistsDropdownButton(),
        ),
      ],
    );
  }
}

class QuickNavDestinationButton extends StatelessWidget {
  QuickNavDestinationButton({
    required this.title,
    required this.onPressed,
    required this.iconData,
  }) : super(key: UniqueKey());

  final void Function() onPressed;
  final IconData iconData;
  final String title;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        title,
        style: context.textTheme.bodyMedium?.copyWith(
          color: context.colorScheme.secondary,
        ),
      ),
      leading: Icon(iconData, size: 16),
      visualDensity: VisualDensity.adaptivePlatformDensity,
      textColor: context.colorScheme.secondary,
      iconColor: context.colorScheme.secondary,
      shape: const RoundedRectangleBorder(borderRadius: kBorderRadius),
      dense: true,
      horizontalTitleGap: context.isDesktopPlatform ? 0 : null,
      onTap: onPressed,
    );
  }
}
