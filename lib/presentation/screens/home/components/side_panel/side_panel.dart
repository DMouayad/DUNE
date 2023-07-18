import 'package:dune/navigation/app_router.dart';
import 'package:dune/presentation/providers/state_controllers.dart';
import 'package:dune/presentation/utils/constants.dart';
import 'package:dune/presentation/providers/shared_providers.dart';
import 'package:dune/support/logger_service.dart';
import 'package:dune/support/extensions/context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:window_manager/window_manager.dart';
import 'nav_rail_resizer.dart';
import 'settings_button.dart';
import 'side_panel_now_playing_section.dart';

const minWidth = 56.0;

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
    final maxWidth = context.maxNavRailWidth;

    final railWidth = ref.watch(navigationRailSizeProvider) ?? minWidth;
    final extended = railWidth > 180;
    final playerState = ref.watch(playbackControllerProvider);

    return Container(
      constraints: BoxConstraints.loose(Size.fromWidth(railWidth)),
      decoration: BoxDecoration(color: cardColor),
      child: Stack(
        children: [
          Column(
            children: [
              if (extended)
                Expanded(
                  flex: 0,
                  child: DragToMoveArea(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 6),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'DUNE',
                            textAlign: TextAlign.center,
                            style: context.textTheme.titleMedium?.copyWith(
                              color: context.colorScheme.secondary,
                              fontFamily: 'bruno_ace',
                            ),
                          ),
                          const SettingsButton(),
                        ],
                      ),
                    ),
                  ),
                ),
              Expanded(
                child: NavigationRail(
                  backgroundColor: Colors.transparent,
                  extended: extended,
                  destinations: destinations,
                  minWidth: minWidth,
                  trailing: extended ? null : const SettingsButton(),
                  labelType: NavigationRailLabelType.none,
                  selectedIndex:
                      currentBranchIsADestination ? selectedIndex : null,
                  onDestinationSelected: (index) =>
                      _onDestinationSelected(index, ref, selectedIndex),
                ),
              ),
              // UserPlaylistsSection(),
              if (extended &&
                  (playerState.isLoading || playerState.currentTrack != null))
                Expanded(
                  child: SidePanelNowPlayingSection(railWidth),
                ),
            ],
          ),
          Positioned(
            top: context.screenHeight * .4,
            right: 0,
            child: NavRailResizer(
              maxWidth: maxWidth,
              minWidth: minWidth,
              railWidth: railWidth,
            ),
          ),
        ],
      ),
    );
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
