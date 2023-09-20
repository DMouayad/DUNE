import 'package:dune/presentation/models/tabs_state.dart';
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
import 'components/app_title_bar.dart';
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
    final topSpacing = tabsMode.isHorizontal ? 85.5 : 34.0;
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
                const Positioned(
                    top: 0, right: 0, left: 0, child: AppTitleBar()),
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
                Positioned.fill(
                  top: topSpacing,
                  right: 6,
                  bottom: context.isMobile ? context.bottomPlayerBarHeight : 0,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 0,
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
                      Expanded(child: navigationShell),
                    ],
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
            TabData(tabIndex: navigationShell.currentIndex + 1),
          ),
        );
  }
}
