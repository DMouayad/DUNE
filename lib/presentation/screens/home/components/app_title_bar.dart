import 'package:dune/presentation/custom_widgets/desktop_app_bar_buttons.dart';
import 'package:dune/presentation/custom_widgets/full_screen_search_bar.dart';
import 'package:dune/presentation/providers/shared_providers.dart';
import 'package:dune/presentation/providers/state_controllers.dart';
import 'package:dune/support/extensions/context_extensions.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:window_manager/window_manager.dart';

import 'side_panel/side_panel.dart';

class AppTitleBar extends ConsumerWidget {
  const AppTitleBar({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final appTheme = ref.watch(appThemeControllerProvider);

    final searchViewWidth =
        context.screenWidth * (context.screenWidth > 900 ? .8 : .8);
    return DragToMoveArea(
      child: Container(
        padding: const EdgeInsets.only(left: 8),
        color: appTheme.cardColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (!context.isMobile)
              const Expanded(flex: 0, child: _SidePanelButton()),
            Flexible(
              flex: 0,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Text(
                  'DUNE',
                  textAlign: TextAlign.start,
                  style: context.textTheme.titleMedium?.copyWith(
                    color: context.colorScheme.secondary,
                    fontFamily: 'bruno_ace',
                  ),
                ),
              ),
            ),
            if (!context.isMobile) const Spacer(),
            Expanded(
              flex: 5,
              child: Container(
                height: 50,
                width: context.screenWidth * .66,
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: FullScreenSearchBar(
                  searchViewSize: Size.fromWidth(searchViewWidth),
                ),
              ),
            ),
            if (!context.isMobile) const Spacer(),
            if (context.isDesktopPlatform && !kIsWeb)
              const Expanded(flex: 0, child: DesktopAppBarButtons()),
          ],
        ),
      ),
    );
  }
}

class _SidePanelButton extends ConsumerWidget {
  const _SidePanelButton();

  @override
  Widget build(BuildContext context, ref) {
    final isExtended =
        ref.watch(navigationRailSizeProvider) == context.maxNavRailWidth;

    return IconButton(
      onPressed: () {
        if (isExtended) {
          ref.read(navigationRailSizeProvider.notifier).state =
              kSidePanelMinWidth;
        } else {
          ref.read(navigationRailSizeProvider.notifier).state =
              context.maxNavRailWidth;
        }
      },
      padding: EdgeInsets.zero,
      icon: Icon(
        Icons.menu_rounded,
        size: 22,
        color: context.colorScheme.onSurfaceVariant,
      ),
    );
  }
}
