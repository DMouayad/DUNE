import 'package:dune/navigation/app_router.dart';
import 'package:dune/presentation/providers/state_controllers.dart';
import 'package:dune/presentation/utils/constants.dart';
import 'package:dune/presentation/providers/shared_providers.dart';
import 'package:dune/support/logger_service.dart';
import 'package:dune/support/extensions/context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:window_manager/window_manager.dart';
import 'side_panel_resizer.dart';
import 'settings_button.dart';
import 'side_panel_now_playing_section.dart';

const minWidth = 44.0;

class SidePanel extends ConsumerWidget {
  const SidePanel({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final selectedIndex = ref.watch(navigationRailSelectedIndex);

    final currentBranchIsADestination = HomeNavigationShellBranchIndex
        .navigationRailDestinations
        .contains(ref.watch(homeNavigationShellBranchIndexProvider));

    final cardColor = ref
        .watch(appThemeControllerProvider.select((value) => value.cardColor));

    final railWidth = ref.watch(navigationRailSizeProvider) ?? minWidth;
    final extended = railWidth > 180;

    return LayoutBuilder(builder: (context, constraints) {
      final maxWidth = context.maxNavRailWidth;
      return Container(
        constraints: BoxConstraints.loose(Size.fromWidth(railWidth)),
        decoration: BoxDecoration(color: cardColor),
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (extended)
                  Flexible(
                    flex: 0,
                    child: DragToMoveArea(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 6),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              // flex: 0,
                              child: Text(
                                'DUNE',
                                textAlign: TextAlign.center,
                                style: context.textTheme.titleMedium?.copyWith(
                                  color: context.colorScheme.secondary,
                                  fontFamily: 'bruno_ace',
                                ),
                              ),
                            ),
                            const Expanded(
                              flex: 0,
                              child: SettingsButton(),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                Expanded(
                  flex: 0,
                  child: SizedBox(
                    height: 300,
                    width: railWidth,
                    child: NavigationRail(
                      backgroundColor: Colors.transparent,
                      extended: extended,
                      destinations: destinations,
                      minWidth: extended ? minWidth : 52,
                      trailing: extended ? null : const SettingsButton(),
                      labelType: extended ? null : NavigationRailLabelType.none,
                      selectedIndex:
                          currentBranchIsADestination ? selectedIndex : null,
                      onDestinationSelected: (index) =>
                          _onDestinationSelected(index, ref, selectedIndex),
                    ),
                  ),
                ),
                const Spacer(flex: 1),
                // UserPlaylistsSection(),
                if (extended)
                  Container(
                    constraints: BoxConstraints.loose(
                      const Size.fromHeight(160),
                    ),
                    child: const SidePanelNowPlayingSection(),
                  ),
              ],
            ),
            if (!context.isMobile)
              Positioned(
                top: 0,
                right: 0,
                bottom: 0,
                child: SidePanelResizer(
                  maxWidth: maxWidth,
                  minWidth: 52,
                  railWidth: railWidth,
                ),
              ),
          ],
        ),
      );
    });
  }

  void _onDestinationSelected(int index, WidgetRef ref, int? selectedIndex) {
    if (selectedIndex != index) {
      ref.read(navigationRailSelectedIndex.notifier).update((state) => index);
      if (HomeNavigationShellBranchIndex.navigationRailDestinations.length >
          index) {
        final destinationBranchIndex = HomeNavigationShellBranchIndex
            .navigationRailDestinations
            .elementAt(index);
        ref
            .read(homeNavigationShellBranchIndexProvider.notifier)
            .update((state) => destinationBranchIndex);
      } else {
        Log.e(
          "A HomeNavigationShellBranchIndex doesn't exists for"
          " NavigationRailDestination with index: $index",
        );
      }
    }
  }
}
