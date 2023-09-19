import 'package:dune/navigation/app_router.dart';
import 'package:dune/presentation/providers/shared_providers.dart';
import 'package:dune/presentation/providers/state_controllers.dart';
import 'package:dune/support/extensions/context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../navigation_buttons.dart';
import 'navigation_grid.dart';
import 'side_panel_now_playing_section.dart';

const kSidePanelMinWidth = 54.0;

class SidePanel extends ConsumerStatefulWidget {
  const SidePanel({required this.onDestinationSelected, super.key});

  final void Function(QuickNavDestination dest) onDestinationSelected;

  @override
  ConsumerState<SidePanel> createState() => _SidePanelState();
}

class _SidePanelState extends ConsumerState<SidePanel>
    with AutomaticKeepAliveClientMixin {
  double railWidth = kSidePanelMinWidth;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final tabsMode = ref.read(appPreferencesController).tabsMode;

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
      duration: const Duration(milliseconds: 300),
      constraints: BoxConstraints.tight(Size.fromWidth(railWidth)),
      margin: const EdgeInsets.only(left: 12, right: 10),
      child: LayoutBuilder(builder: (context, constraints) {
        final extended = constraints.minWidth == context.maxNavRailWidth;
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (!tabsMode.isHorizontal) const NavigationButtons(),
            Expanded(
              flex: 0,
              child: NavGrid(
                extended: extended,
                width: railWidth,
                onDestinationSelected: widget.onDestinationSelected,
              ),
            ),
            const Spacer(flex: 1),
            // UserPlaylistsSection(),
            Visibility(
              visible: extended,
              child: Container(
                constraints: BoxConstraints.loose(
                  const Size.fromHeight(160),
                ),
                child: const SidePanelNowPlayingSection(),
              ),
            ),
          ],
        );
      }),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
