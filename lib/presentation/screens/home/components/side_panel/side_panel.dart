import 'package:dune/presentation/utils/constants.dart';
import 'package:dune/presentation/providers/shared_providers.dart';
import 'package:dune/support/extensions/context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'side_panel_now_playing_section.dart';

const kSidePanelMinWidth = 50.0;

class SidePanel extends ConsumerStatefulWidget {
  const SidePanel({required this.onDestinationSelected, super.key});

  final void Function(int index) onDestinationSelected;

  @override
  ConsumerState<SidePanel> createState() => _SidePanelState();
}

class _SidePanelState extends ConsumerState<SidePanel>
    with AutomaticKeepAliveClientMixin {
  double railWidth = kSidePanelMinWidth;

  @override
  Widget build(BuildContext context) {
    super.build(context);

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
                  leading: const _SidePanelButton(),
                  extended: extended,
                  destinations: destinations,
                  minWidth: kSidePanelMinWidth,
                  labelType: extended ? null : NavigationRailLabelType.none,
                  selectedIndex: null,
                  onDestinationSelected: widget.onDestinationSelected,
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

  @override
  bool get wantKeepAlive => true;
}

class _SidePanelButton extends ConsumerWidget {
  const _SidePanelButton();

  @override
  Widget build(BuildContext context, ref) {
    final isExtended =
        ref.watch(navigationRailSizeProvider) == context.maxNavRailWidth;
    return IconButton(
      tooltip: isExtended ? 'Close side panel' : 'Open side panel',
      onPressed: () {
        if (isExtended) {
          ref.read(navigationRailSizeProvider.notifier).state =
              kSidePanelMinWidth;
        } else {
          ref.read(navigationRailSizeProvider.notifier).state =
              context.maxNavRailWidth;
        }
      },
      padding: EdgeInsets.zero,
      icon: Icon(
        Icons.menu_rounded,
        size: 22,
        color: context.colorScheme.onSurfaceVariant,
      ),
    );
  }
}
