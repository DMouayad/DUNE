import 'package:dune/navigation/app_router.dart';
import 'package:dune/presentation/providers/shared_providers.dart';
import 'package:dune/presentation/providers/state_controllers.dart';
import 'package:dune/support/extensions/context_extensions.dart';
import 'package:dune/support/themes/theme_constants.dart';
import 'package:fluent_ui/fluent_ui.dart' as fluent;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppBarNavButtons extends ConsumerWidget {
  const AppBarNavButtons({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final buttonStyle = fluent.ButtonStyle(
      shape: fluent.ButtonState.all(
        const RoundedRectangleBorder(borderRadius: kBorderRadius),
      ),
      iconSize: fluent.ButtonState.all(15),
    );
    final tabsMode =
        ref.watch(appPreferencesController.select((s) => s.tabsMode));
    return SizedBox(
      width: tabsMode.isVertical ? context.maxNavRailWidth : 120,
      height: 44,
      child: Wrap(
        clipBehavior: Clip.hardEdge,
        alignment: WrapAlignment.spaceBetween,
        runAlignment: WrapAlignment.center,
        children: [
          Consumer(builder: (context, ref, _) {
            final canGoBack = ref.watch(showBackButtonProvider);
            return fluent.IconButton(
              style: buttonStyle,
              icon: const fluent.Icon(fluent.FluentIcons.back),
              onPressed: canGoBack
                  ? () {
                      if (AppRouter.router.canPop()) {
                        AppRouter.router.pop();
                        ref.read(tabsStateProvider.notifier).update(
                            (state) => state.withPreviousPageSelected());
                      }
                    }
                  : null,
            );
          }),
          fluent.IconButton(
            style: buttonStyle,
            icon: const fluent.Icon(fluent.FluentIcons.forward),
            onPressed: null,
          ),
          SizedBox(width: tabsMode.isVertical ? 120 : 10),
          fluent.IconButton(
            style: buttonStyle,
            icon: const fluent.Icon(fluent.FluentIcons.history),
            onPressed: null,
          ),
          const SizedBox(width: 1),
        ],
      ),
    );
  }
}
