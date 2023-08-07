import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:window_manager/window_manager.dart';

//
import 'package:dune/navigation/app_router.dart';
import 'package:dune/presentation/custom_widgets/optional_parent_widget.dart';
import 'package:dune/presentation/providers/state_controllers.dart';
import 'package:dune/presentation/utils/app_tab_view_helper.dart';
import 'package:dune/presentation/providers/shared_providers.dart';
import 'package:dune/support/extensions/context_extensions.dart';

//
import 'components/app_tab_view.dart';
import 'components/app_title_bar.dart';
import 'components/player_bottom_bar/player_bottom_bar.dart';
import 'components/side_panel/side_panel.dart';

final showBackButtonProvider = StateProvider((ref) => false);

class WideHomeScreen extends ConsumerWidget {
  const WideHomeScreen(this.navigationShell, {Key? key}) : super(key: key);

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context, ref) {
    final tabsModeEnabled =
        ref.watch(appPreferencesController.select((v) => v.tabsModeEnabled));

    if (tabsModeEnabled) {
      ref.listen(
        selectedTabKeyProvider,
        (prev, next) => AppTabViewHelper.onCurrentTabKeyChange(next, ref),
      );
    }
    ref.listen(
      homeNavigationShellBranchIndexProvider,
      (prev, next) {
        if (tabsModeEnabled) {
          AppTabViewHelper.onCurrentHomeNavigationShellBranchIndexChange(
              next, ref);
        } else {
          final destinationIndex = HomeNavigationShellBranchIndex.values
              .singleWhere((e) => e == next);
          if (!HomeNavigationShellBranchIndex.navigationRailDestinations
              .contains(next)) {
            ref
                .read(navigationRailSelectedIndex.notifier)
                .update((state) => null);
          }
          navigationShell.goBranch(destinationIndex.value);
        }
      },
    );
    final appTheme = ref.watch(appThemeControllerProvider);
    return Material(
      type: MaterialType.transparency,
      child: Theme(
        data: appTheme.materialThemeData,
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
                const Positioned(
                    top: 0, right: 0, left: 0, child: AppTitleBar()),
                Positioned.fill(
                  // top margins for the [AppTitleBar]
                  top: 54,
                  bottom: context.isMobile ? context.bottomPlayerBarHeight : 0,
                  child: Row(
                    children: [
                      Expanded(
                        flex: 0,
                        child: OptionalParentWidget(
                          condition:
                              context.isMobile && context.isDesktopPlatform,
                          parentWidgetBuilder: (child) =>
                              DragToMoveArea(child: child),
                          childWidget: const SidePanel(),
                        ),
                      ),
                      // the main body widget
                      if (tabsModeEnabled)
                        const Expanded(child: AppTabView())
                      else
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
  }
}
