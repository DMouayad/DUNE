import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//
import 'package:dune/presentation/custom_widgets/optional_parent_widget.dart';
import 'package:dune/presentation/providers/state_controllers.dart';
import 'package:dune/presentation/providers/shared_providers.dart';
import 'package:dune/support/extensions/context_extensions.dart';
import 'package:dune/navigation/navigation.dart';
import 'package:dune/presentation/utils/constants.dart';
import 'package:go_router/go_router.dart';

//
import 'components/wide_home_screen_app_bar.dart';
import 'components/player_bottom_bar/player_bottom_bar.dart';
import 'components/side_panel/side_panel.dart';
import 'desktop_home_screen_wrapper.dart';

class WideHomeScreen extends ConsumerWidget {
  const WideHomeScreen(this.navigationShell, {Key? key}) : super(key: key);
  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context, ref) {
    // [ref.read] is used since enabling/disabling tabs layout will only takes
    // effect on the next time the app is opened
    final appTheme = ref.watch(appThemeControllerProvider);
    const topSpacing = kWideScreenAppBarHeight;

    return OptionalParentWidget(
      condition: context.isDesktopPlatform,
      parentWidgetBuilder: (child) => DesktopHomeScreenWrapper(child),
      childWidget: Theme(
        data: appTheme.materialThemeData,
        child: Material(
          color: ref.watch(appThemeControllerProvider).cardColor,
          child: Builder(
            builder: (context) {
              return Stack(
                children: [
                  if (context.isMobile)
                    const Positioned(
                        bottom: 0, right: 0, left: 0, child: PlayerBottomBar()),
                  const Positioned(
                      top: 0, right: 0, left: 0, child: WideHomeScreenAppBar()),
                  Positioned(
                    top: topSpacing,
                    left: _getBodyLeftMargin(ref, context),
                    right: 6,
                    bottom:
                        context.isMobile ? context.bottomPlayerBarHeight : 6,
                    child: navigationShell,
                  ),
                  Positioned(
                    top: topSpacing,
                    left: 6,
                    bottom:
                        context.isMobile ? context.bottomPlayerBarHeight : 0,
                    child: SidePanel(
                      onDestinationSelected: (dest) {
                        AppNavigation.instance
                            .onGoToQuickNavDestination(dest, navigationShell);
                      },
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  double _getBodyLeftMargin(WidgetRef ref, BuildContext context) {
    final panelIsPinned = ref.read(appPreferencesController).sidePanelPinned;
    final panelWidth = ref.watch(sidePanelWidthProvider);

    return panelIsPinned ? panelWidth + 12 : kSidePanelMinWidth + 12;
  }
}
