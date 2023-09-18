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
import 'components/side_panel/side_panel_resizer.dart';
import 'desktop_home_screen_wrapper.dart';

class WideHomeScreen extends ConsumerWidget {
  const WideHomeScreen(this.navigationShell, {Key? key}) : super(key: key);
  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context, ref) {
    // [ref.read] is used since enabling/disabling tabs layout will only takes
    // effect on the next time the app is opened
    final tabsModeEnabled =
        ref.read(appPreferencesController).tabsMode.isEnabled;
    final appTheme = ref.watch(appThemeControllerProvider);
    final topSpacing = tabsModeEnabled ? 85.5 : 44.5;
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
                    bottom: 0,
                    right: 0,
                    left: 0,
                    child: PlayerBottomBar(),
                  ),
                Positioned(
                  top: 0,
                  right: 0,
                  left: 0,
                  child: AppTitleBar(
                    tabsModeEnabled: tabsModeEnabled,
                    onTabChanged: (i) => _onTabChanged(i, ref),
                    onAddNewTab: () {
                      ref.read(tabsStateProvider.notifier).update(
                            (state) => state.withTabAdded(TabData(
                                tabIndex: navigationShell.currentIndex + 1)),
                          );
                    },
                  ),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  top: topSpacing - 1,
                  child: const Divider(height: 1, thickness: .5),
                ),
                Positioned.fill(
                  // top margins for the [AppTitleBar]
                  top: topSpacing,
                  bottom: context.isMobile ? context.bottomPlayerBarHeight : 0,
                  child: Row(
                    children: [
                      Expanded(
                        flex: 0,
                        child: SidePanel(
                          onDestinationSelected: (index) {
                            AppRouter.onQuickNavDestinationSelected(
                                index, navigationShell);
                          },
                        ),
                      ),
                      const SidePanelResizer(),
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
}
