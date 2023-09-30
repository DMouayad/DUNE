import 'package:dune/navigation/tabs_state.dart';
import 'package:dune/presentation/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
//
import 'package:dune/presentation/custom_widgets/optional_parent_widget.dart';
import 'package:dune/presentation/providers/state_controllers.dart';
import 'package:dune/presentation/providers/shared_providers.dart';
import 'package:dune/support/extensions/context_extensions.dart';
import 'package:dune/navigation/app_router.dart';

//
import 'components/wide_home_screen_app_bar.dart';
import 'components/player_bottom_bar/player_bottom_bar.dart';
import 'components/side_panel/side_panel.dart';
import 'components/tabs_bar.dart';
import 'desktop_home_screen_wrapper.dart';

class WideHomeScreen extends ConsumerWidget {
  const WideHomeScreen(this.navigationShell, {Key? key}) : super(key: key);
  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context, ref) {
    // [ref.read] is used since enabling/disabling tabs layout will only takes
    // effect on the next time the app is opened
    final tabsMode = ref.read(appPreferencesController).tabsMode;
    final appTheme = ref.watch(appThemeControllerProvider);
    final topSpacing = tabsMode.isHorizontal ? 80.0 : kWideScreenAppBarHeight;
    final screen = Theme(
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
                Positioned(
                  top: 0,
                  right: 0,
                  left: 0,
                  child: WideHomeScreenAppBar(tabsEnabled: tabsMode.isEnabled),
                ),
                if (tabsMode.isHorizontal)
                  Positioned(
                    right: 0,
                    left: 0,
                    top: 36,
                    child: SizedBox(
                      height: 42,
                      child: TabsBar(
                        onTabChanged: (i) => _onTabChanged(i, ref),
                        onAddNewTab: () => _onAddNewTab(ref),
                      ),
                    ),
                  ),
                Positioned(
                  top: topSpacing,
                  left: _getBodyLeftMargin(ref),
                  right: 6,
                  bottom: context.isMobile ? context.bottomPlayerBarHeight : 0,
                  child: navigationShell,
                ),
                Positioned(
                  top: topSpacing,
                  left: 6,
                  bottom: context.isMobile ? context.bottomPlayerBarHeight : 0,
                  child: SidePanel(
                    onTabChanged: (i) => _onTabChanged(i, ref),
                    onAddNewTab: () => _onAddNewTab(ref),
                    onDestinationSelected: (dest) {
                      AppRouter.onQuickNavDestinationSelected(
                        dest,
                        navigationShell,
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
    return OptionalParentWidget(
      condition: context.isDesktopPlatform,
      parentWidgetBuilder: (child) => DesktopHomeScreenWrapper(child),
      childWidget: screen,
    );
  }

  double _getBodyLeftMargin(WidgetRef ref) {
    final panelIsPinned = ref.read(appPreferencesController).sidePanelPinned;
    final railWidth = ref.watch(navigationRailSizeProvider);
    // return panelIsPinned ? (railWidth ?? kSidePanelMinWidth) + 6 : 6;
    return panelIsPinned
        ? (railWidth ?? kSidePanelMinWidth) + 12
        : kSidePanelMinWidth + 12;
  }

  void _onTabChanged(int index, WidgetRef ref) {
    if (ref.watch(tabsStateProvider).selectedTabIndex != index) {
      ref
          .read(tabsStateProvider.notifier)
          .update((state) => state.withNewSelectedTab(index));
      navigationShell.goBranch(index);
    }
  }

  void _onAddNewTab(WidgetRef ref) {
    ref.read(tabsStateProvider.notifier).update(
          (state) => state.withTabAdded(
            TabData.withEmptyPage(tabIndex: navigationShell.currentIndex + 1),
          ),
        );
  }
}
