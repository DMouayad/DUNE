import 'package:dune/navigation/app_router.dart';
import 'package:dune/presentation/custom_widgets/full_screen_search_bar.dart';
import 'package:dune/presentation/custom_widgets/optional_parent_widget.dart';
import 'package:dune/presentation/providers/state_controllers.dart';
import 'package:dune/presentation/utils/app_tab_view_helper.dart';
import 'package:dune/presentation/providers/shared_providers.dart';
import 'package:dune/support/extensions/context_extensions.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:window_manager/window_manager.dart';

import 'components/app_tab_view.dart';
import 'components/side_panel/side_panel.dart';
import '../../custom_widgets/desktop_app_bar_buttons.dart';

final showBackButtonProvider = StateProvider((ref) => false);

class WideHomeScreen extends ConsumerStatefulWidget {
  const WideHomeScreen(this.navigationShell, {Key? key}) : super(key: key);

  final StatefulNavigationShell navigationShell;

  @override
  ConsumerState<WideHomeScreen> createState() => _WideHomeScreenState();
}

class _WideHomeScreenState extends ConsumerState<WideHomeScreen> {
  @override
  void initState() {
    GoRouter.of(context).routerDelegate.addListener(() {
      final shouldShowBackButton = AppRouter.canPop();
      if (shouldShowBackButton != ref.watch(showBackButtonProvider)) {
        ref
            .read(showBackButtonProvider.notifier)
            .update((state) => shouldShowBackButton);
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final tabsModeEnabled = ref.watch(appPreferencesController).tabsModeEnabled;
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
          widget.navigationShell.goBranch(destinationIndex.value);
        }
      },
    );

    return Material(
      type: MaterialType.transparency,
      child: Theme(
        data: ref.watch(
            appThemeControllerProvider.select((s) => s.materialThemeData)),
        child: Builder(builder: (_) {
          return Row(
            children: [
              const Expanded(flex: 0, child: SidePanel()),
              const SizedBox(width: 4),
              if (tabsModeEnabled)
                Expanded(
                  child: LayoutBuilder(builder: (context, constraints) {
                    return AppTabView(
                      footer: _ActionButtons(parentWidth: constraints.maxWidth),
                    );
                  }),
                )
              else
                Expanded(
                  child: LayoutBuilder(builder: (context, constraints) {
                    return Stack(
                      children: [
                        if (context.isDesktopPlatform)
                          const Positioned.fill(
                            top: 0,
                            child: DragToMoveArea(
                              child: SizedBox(height: 36),
                            ),
                          ),
                        // the main body widget
                        Positioned.fill(top: 40, child: widget.navigationShell),
                        Positioned(
                          top: 0,
                          right: 0,
                          left: context.isDesktop ? 100 : 52,
                          child:
                              _ActionButtons(parentWidth: constraints.maxWidth),
                        ),
                        if (ref.watch(showBackButtonProvider))
                          Positioned(
                            top: 4,
                            left: 4,
                            child: BackButton(
                              onPressed: () {
                                GoRouter.of(context).pop();
                              },
                              color: context.colorScheme.secondary,
                            ),
                          ),
                      ],
                    );
                  }),
                ),
            ],
          );
        }),
      ),
    );
  }
}

class _ActionButtons extends ConsumerWidget {
  const _ActionButtons({required this.parentWidth});

  final double parentWidth;

  @override
  Widget build(BuildContext context, ref) {
    final tabsModeEnabled = ref.watch(appPreferencesController).tabsModeEnabled;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        OptionalParentWidget(
          condition: !tabsModeEnabled,
          parentWidgetBuilder: (child) => Expanded(child: child),
          childWidget: Container(
            margin: EdgeInsets.only(top: tabsModeEnabled ? 0 : 6),
            height: 40,
            width: tabsModeEnabled ? 40 : null,
            child: FullScreenSearchBar(
              parentSize: Size.fromWidth(parentWidth),
            ),
          ),
        ),
        if (!tabsModeEnabled) const SizedBox(width: 40),
        if (context.isDesktopPlatform && !kIsWeb) const DesktopAppBarButtons(),
      ],
    );
  }
}
