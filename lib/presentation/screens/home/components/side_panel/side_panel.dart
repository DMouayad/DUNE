import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

//
import 'package:dune/navigation/app_router.dart';
import 'package:dune/presentation/custom_widgets/top_search_bar.dart';
import 'package:dune/presentation/providers/shared_providers.dart';
import 'package:dune/presentation/providers/state_controllers.dart';
import 'package:dune/support/extensions/context_extensions.dart';

//
import 'quick_nav_section.dart';
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

    return Container(
      constraints: BoxConstraints.tight(Size.fromWidth(railWidth)),
      margin: const EdgeInsets.only(left: 10, right: 12, top: 10),
      child: LayoutBuilder(builder: (context, constraints) {
        final extended = constraints.maxWidth == context.maxNavRailWidth;
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Expanded(flex: 0, child: TopSearchBar()),
            Expanded(
              child: ListView(
                shrinkWrap: true,
                children: [
                  Visibility(
                    visible: extended,
                    child: QuickNavSection(
                      extended: extended,
                      onDestinationSelected: widget.onDestinationSelected,
                    ),
                  ),
                  if (tabsMode.isVertical) ...[
                    const Divider(),
                    const SizedBox(height: 4),
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
