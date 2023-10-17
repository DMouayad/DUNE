import 'package:dune/navigation/src/helpers/tabs_routers_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//
import 'package:dune/presentation/custom_widgets/optional_parent_widget.dart';
import 'package:dune/presentation/providers/state_controllers.dart';
import 'package:dune/presentation/providers/shared_providers.dart';
import 'package:dune/support/extensions/context_extensions.dart';
import 'package:dune/navigation/navigation.dart';
import 'package:dune/presentation/utils/constants.dart';

//

import 'components/horizontal_tabs_bar.dart';
import 'components/wide_home_screen_app_bar.dart';
import 'components/player_bottom_bar/player_bottom_bar.dart';
import 'components/side_panel/side_panel.dart';
import 'desktop_home_screen_wrapper.dart';

class WideHomeScreenWithTabs extends ConsumerWidget {
  const WideHomeScreenWithTabs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    // [ref.read] is used since enabling/disabling tabs layout will only takes
    // effect on the next time the app is opened
    final tabsMode = ref.read(appPreferencesController).tabsMode;
    final appTheme = ref.watch(appThemeControllerProvider);
    final topSpacing = tabsMode.isHorizontal ? 80.0 : kWideScreenAppBarHeight;

    return OptionalParentWidget(
      condition: context.isDesktopPlatform,
      parentWidgetBuilder: (child) => DesktopHomeScreenWrapper(child),
      childWidget: Theme(
        data: appTheme.materialThemeData,
        child: Material(
          color: ref.watch(appThemeControllerProvider).cardColor,
          child: Builder(
            builder: (context) {
              return Stack(
                children: [
                  if (context.isMobile)
                    const Positioned(
                        bottom: 0, right: 0, left: 0, child: PlayerBottomBar()),
                  const Positioned(
                      top: 0, right: 0, left: 0, child: WideHomeScreenAppBar()),
                  if (tabsMode.isHorizontal)
                    const Positioned(
                      right: 0,
                      left: 0,
                      top: 36,
                      child: SizedBox(height: 42, child: HorizontalTabsBar()),
                    ),
                  Positioned(
                    top: topSpacing,
                    left: _getBodyLeftMargin(ref, context),
                    right: 6,
                    bottom:
                        context.isMobile ? context.bottomPlayerBarHeight : 6,
                    child: const _Body(),
                  ),
                  Positioned(
                    top: topSpacing,
                    left: 6,
                    bottom:
                        context.isMobile ? context.bottomPlayerBarHeight : 0,
                    child: SidePanel(
                      onDestinationSelected:
                          AppNavigation.instance.onGoToQuickNavDestination,
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  double _getBodyLeftMargin(WidgetRef ref, BuildContext context) {
    final panelIsPinned = ref.read(appPreferencesController).sidePanelPinned;
    final panelWidth = ref.watch(sidePanelWidthProvider);
    if (panelIsPinned && panelWidth == kSidePanelMinWidth) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        ref.read(sidePanelWidthProvider.notifier).state =
            context.maxNavRailWidth;
      });
    }
    return panelIsPinned ? (panelWidth) + 12 : kSidePanelMinWidth + 12;
  }
}

class _Body extends ConsumerStatefulWidget {
  const _Body();

  @override
  ConsumerState<_Body> createState() => _BodyState();
}

class _BodyState extends ConsumerState<_Body> {
  late final controller = PageController();

  TabsRoutersHelper get helper => AppNavigation.instance.tabsRouters!;

  @override
  void initState() {
    helper.addListeners(
      onCurrentRouterChanged: (index) {
        if (controller.hasClients) {
          controller.jumpToPage(index);
        }
      },
    );

    super.initState();
  }

  final _pageKey = GlobalKey<State<PageView>>();

  final notifier = AppNavigation.instance.tabsRouters!.notifier;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: notifier,
      builder: (context, child) {
        return PageView.builder(
          key: _pageKey,
          controller: controller,
          clipBehavior: Clip.hardEdge,
          padEnds: false,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: notifier.items.length,
          itemBuilder: (context, index) {
            return ExcludeFocus(
              key: ValueKey(index),
              excluding: helper.currentRouterIndexNotifier.value != index,
              child: FocusTraversalGroup(
                child:
                    Router.withConfig(config: notifier.items.elementAt(index)),
              ),
            );
          },
        );
      },
    );
  }
}
