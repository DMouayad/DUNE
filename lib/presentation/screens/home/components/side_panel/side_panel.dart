import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

//
import 'package:dune/presentation/custom_widgets/optional_parent_widget.dart';
import 'package:dune/presentation/utils/constants.dart';
import 'package:dune/support/enums/quick_nav_destination.dart';
import 'package:dune/presentation/custom_widgets/top_search_bar.dart';
import 'package:dune/presentation/providers/shared_providers.dart';
import 'package:dune/presentation/providers/state_controllers.dart';
import 'package:dune/support/extensions/context_extensions.dart';

//
import 'quick_nav_section.dart';
import 'side_panel_now_playing_section.dart';
import 'vertical_tabs_list.dart';

class SidePanel extends ConsumerStatefulWidget {
  const SidePanel({super.key, required this.onDestinationSelected});

  final void Function(QuickNavDestination dest) onDestinationSelected;

  @override
  ConsumerState<SidePanel> createState() => _SidePanelState();
}

class _SidePanelState extends ConsumerState<SidePanel> {
  @override
  Widget build(BuildContext context) {
    final tabsMode = ref.read(appPreferencesController).tabsMode;
    ref.listen(appPreferencesController.select((s) => s.sidePanelPinned),
        (wasPinned, pinned) {
      ref.read(sidePanelWidthProvider.notifier).state =
          pinned ? context.maxNavRailWidth : kSidePanelMinWidth;
    });
    final panelWidth = ref.watch(sidePanelWidthProvider);
    final pinned = ref.watch(appPreferencesController).sidePanelPinned;
    final extended = pinned ? true : panelWidth == context.maxNavRailWidth;

    if (pinned && panelWidth != context.maxNavRailWidth) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        ref.read(sidePanelWidthProvider.notifier).state =
            context.maxNavRailWidth;
      });
    }

    return OptionalParentWidget(
      condition: !ref.watch(appPreferencesController).sidePanelPinned,
      parentWidgetBuilder: (child) {
        return MouseRegion(
          onEnter: (_) => ref.read(sidePanelWidthProvider.notifier).state =
              context.maxNavRailWidth,
          onExit: (_) {
            if (ref.watch(isReorderingVerticalTabsProvider)) return;
            ref.read(sidePanelWidthProvider.notifier).state =
                kSidePanelMinWidth;
          },
          child: child,
        );
      },
      childWidget: Stack(
        children: [
          if (!pinned)
            Positioned.fill(
              child: Material(
                color: extended
                    ? context.colorScheme.background
                    : Colors.transparent,
                elevation: 0,
              ),
            ),
          AnimatedSize(
            curve: Curves.fastEaseInToSlowEaseOut,
            duration: const Duration(milliseconds: 450),
            child: Container(
              constraints: BoxConstraints.loose(
                Size.fromWidth(panelWidth),
              ),
              padding: EdgeInsets.only(
                right: extended && !pinned ? 6 : 0,
                top: 10,
              ),
              decoration: BoxDecoration(
                color: extended && !pinned
                    ? ref.watch(appThemeControllerProvider).cardColor
                    : Colors.transparent,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Expanded(flex: 0, child: TopSearchBar()),
                  Expanded(
                    child: ListView(
                      padding: const EdgeInsets.only(top: 10),
                      children: [
                        Visibility(
                          visible: extended,
                          child: QuickNavSection(
                            onDestinationSelected: widget.onDestinationSelected,
                          ),
                        ),
                        if (tabsMode.isVertical) ...[
                          const Divider(),
                          const SizedBox(height: 4),
                          VerticalTabsList(extended: extended),
                        ],
                      ],
                    ),
                  ),
                  Visibility(
                    visible: extended,
                    child: Container(
                      margin: const EdgeInsets.only(top: 16),
                      constraints:
                          BoxConstraints.loose(const Size.fromHeight(128)),
                      child: const SidePanelNowPlayingSection(),
                    ),
                  ),
                ],
              ),
              // }),
            ),
          ),
        ],
      ),
    );
  }
}
