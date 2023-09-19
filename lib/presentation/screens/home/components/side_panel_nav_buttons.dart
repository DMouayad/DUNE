import 'package:dune/navigation/app_router.dart';
import 'package:dune/presentation/providers/shared_providers.dart';
import 'package:fluent_ui/fluent_ui.dart' as fluent;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SidePanelNavButtons extends ConsumerWidget {
  const SidePanelNavButtons({super.key});

  @override
  Widget build(BuildContext context, ref) {
    return fluent.IconButton(
      style: fluent.ButtonStyle(
        iconSize: fluent.ButtonState.all(16),
      ),
      onPressed: () {
        final canPop = AppRouter.router.canPop();
        if (canPop) {
          AppRouter.router.pop();
          ref
              .read(tabsStateProvider.notifier)
              .update((state) => state.withPreviousPageSelected());
        }
      },
      icon: const fluent.Icon(fluent.FluentIcons.back),
    );
  }
}
