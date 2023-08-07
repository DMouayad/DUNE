import 'package:dune/navigation/app_router.dart';
import 'package:dune/presentation/providers/state_controllers.dart';
import 'package:dune/presentation/utils/constants.dart';
import 'package:dune/presentation/providers/shared_providers.dart';
import 'package:dune/support/logger_service.dart';
import 'package:dune/support/extensions/context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'side_panel_now_playing_section.dart';

const kSidePanelMinWidth = 52.0;

class SidePanel extends ConsumerStatefulWidget {
  const SidePanel({super.key});

  @override
  ConsumerState<SidePanel> createState() => _SidePanelState();
}

class _SidePanelState extends ConsumerState<SidePanel>
    with AutomaticKeepAliveClientMixin {
  double railWidth = kSidePanelMinWidth;

  Color getPanelColor(BuildContext context) {
    final appTheme = ref.watch(appThemeControllerProvider);
    final minimized = railWidth == kSidePanelMinWidth;
    return appTheme.acrylicWindowEffectEnabled
        ? minimized
            ? Colors.transparent
            : appTheme.cardColor
        : context.colorScheme.background;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final selectedIndex = ref.watch(navigationRailSelectedIndex);

    final currentBranchIsADestination = HomeNavigationShellBranchIndex
        .navigationRailDestinations
        .contains(ref.watch(homeNavigationShellBranchIndexProvider));
    if (railWidth != ref.watch(navigationRailSizeProvider)) {
      if (context.isMobile) {
        if (railWidth != kSidePanelMinWidth) {
          ref.read(navigationRailSizeProvider.notifier).state =
              kSidePanelMinWidth;
          railWidth = kSidePanelMinWidth;
        }
      } else {
        railWidth = ref.watch(navigationRailSizeProvider) ?? kSidePanelMinWidth;
      }
      updateKeepAlive();
    }

    return AnimatedContainer(
      curve: Curves.fastOutSlowIn,
      duration: const Duration(milliseconds: 400),
      constraints: BoxConstraints.tight(Size.fromWidth(railWidth)),
      decoration: BoxDecoration(
        color: getPanelColor(context),
      ),
      child: LayoutBuilder(builder: (context, constraints) {
        final extended = constraints.minWidth == context.maxNavRailWidth;
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 0,
              child: Container(
                height: 300,
                width: constraints.minWidth,
                padding: const EdgeInsets.only(left: 6),
                child: NavigationRail(
                  backgroundColor: Colors.transparent,
                  extended: extended,
                  destinations: destinations,
                  minWidth: extended ? 44 : kSidePanelMinWidth,
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
                  const Size.fromHeight(180),
                ),
                child: const SidePanelNowPlayingSection(),
              ),
          ],
        );
      }),
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

  @override
  bool get wantKeepAlive => true;
}
