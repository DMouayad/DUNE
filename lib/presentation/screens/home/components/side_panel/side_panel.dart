import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

//
import 'package:dune/navigation/app_router.dart';
import 'package:dune/presentation/custom_widgets/top_search_bar.dart';
import 'package:dune/presentation/providers/shared_providers.dart';
import 'package:dune/presentation/providers/state_controllers.dart';
import 'package:dune/support/extensions/context_extensions.dart';

//
import '../side_panel_nav_buttons.dart';
import 'library_dropdown_button.dart';
import 'navigation_grid.dart';
import 'playlists_dropdown_button.dart';
import 'side_panel_now_playing_section.dart';
import 'vertical_tabs_list.dart';

const kSidePanelMinWidth = 50.0;

class SidePanel extends ConsumerStatefulWidget {
  const SidePanel({
    required this.onDestinationSelected,
    super.key,
    required this.onAddNewTab,
    required this.onTabChanged,
  });

  final void Function() onAddNewTab;
  final void Function(QuickNavDestination dest) onDestinationSelected;
  final void Function(int index) onTabChanged;

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
        railWidth =
            ref.watch(navigationRailSizeProvider) ?? context.maxNavRailWidth;
      }
      updateKeepAlive();
    }

    return AnimatedContainer(
      curve: Curves.fastOutSlowIn,
      duration: const Duration(milliseconds: 200),
      constraints: BoxConstraints.tight(Size.fromWidth(railWidth)),
      margin: const EdgeInsets.only(left: 12, right: 10, top: 10),
      child: LayoutBuilder(builder: (context, constraints) {
        final extended = constraints.minWidth == context.maxNavRailWidth;
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 0,
              child: Wrap(
                // a Clip is used to clip-out [SidePanelNavButtons] when
                // its offset is not zero.
                clipBehavior: Clip.hardEdge,
                alignment: WrapAlignment.end,
                crossAxisAlignment: WrapCrossAlignment.center,
                runSpacing: 10,
                children: [
                  if (!tabsMode.isHorizontal)
                    SizedBox(
                      width: double.infinity,
                      height: 40,
                      child: SidePanelNavButtons(extended),
                    ),
                  const TopSearchBar(),
                ],
              ),
            ),
            Expanded(
              flex: 0,
              child: NavGrid(
                extended: extended,
                width: railWidth,
                onDestinationSelected: widget.onDestinationSelected,
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  AnimatedSlide(
                    offset: extended ? Offset.zero : const Offset(0, -.1),
                    duration: const Duration(milliseconds: 400),
                    child: Visibility(
                      visible: extended,
                      child: const LibraryDropdownButton(),
                    ),
                  ),
                  const SizedBox(height: 6),
                  AnimatedSlide(
                    offset: extended ? Offset.zero : const Offset(0, -.1),
                    duration: const Duration(milliseconds: 400),
                    child: Visibility(
                      visible: extended,
                      child: const PlaylistsDropdownButton(),
                    ),
                  ),
                  if (tabsMode.isVertical) ...[
                    const Divider(height: 20),
                    VerticalTabsList(
                      extended: extended,
                      onTabChanged: widget.onTabChanged,
                      onAddNewTab: widget.onAddNewTab,
                    ),
                  ],
                ],
              ),
            ),
            Visibility(
              visible: extended,
              child: Container(
                margin: const EdgeInsets.only(top: 16),
                constraints: BoxConstraints.loose(
                  const Size.fromHeight(120),
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
