import 'package:dune/navigation/app_router.dart';
import 'package:dune/presentation/providers/shared_providers.dart';
import 'package:fluent_ui/fluent_ui.dart' as fluent;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SidePanelNavButtons extends StatelessWidget {
  const SidePanelNavButtons(this.showAll, {super.key});

  final bool showAll;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      clipBehavior: Clip.hardEdge,
      alignment: WrapAlignment.spaceBetween,
      runAlignment: WrapAlignment.center,
      runSpacing: 4,
      spacing: 16,
      children: [
        Visibility(
          visible: showAll,
          child: fluent.IconButton(
            style: fluent.ButtonStyle(
              iconSize: fluent.ButtonState.all(16),
            ),
            icon: const fluent.Icon(fluent.FluentIcons.history),
            onPressed: null,
          ),
        ),
        if (showAll) const SizedBox(width: 80),
        Consumer(builder: (context, ref, _) {
          final canGoBack = ref.watch(showBackButtonProvider);
          return fluent.IconButton(
            style: fluent.ButtonStyle(
              iconSize: fluent.ButtonState.all(16),
            ),
            icon: const fluent.Icon(fluent.FluentIcons.back),
            onPressed: canGoBack
                ? () {
                    if (AppRouter.router.canPop()) {
                      AppRouter.router.pop();
                      ref
                          .read(tabsStateProvider.notifier)
                          .update((state) => state.withPreviousPageSelected());
                    }
                  }
                : null,
          );
        }),
        Visibility(
          visible: showAll,
          child: fluent.IconButton(
            style: fluent.ButtonStyle(
              iconSize: fluent.ButtonState.all(16),
            ),
            icon: const fluent.Icon(fluent.FluentIcons.forward),
            onPressed: null,
          ),
        ),
      ],
    );
  }
}
