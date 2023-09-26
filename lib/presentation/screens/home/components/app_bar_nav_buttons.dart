import 'package:dune/navigation/app_router.dart';
import 'package:dune/presentation/providers/shared_providers.dart';
import 'package:dune/support/extensions/context_extensions.dart';
import 'package:fluent_ui/fluent_ui.dart' as fluent;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomBackButton extends ConsumerWidget {
  const CustomBackButton({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final canGoBack = ref.watch(showBackButtonProvider);
    return fluent.IconButton(
      style: _getButtonStyle(context),
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
  }
}

class CustomForwardButton extends ConsumerWidget {
  const CustomForwardButton({super.key});

  @override
  Widget build(BuildContext context, ref) {
    return fluent.IconButton(
      style: _getButtonStyle(context),
      icon: const fluent.Icon(fluent.FluentIcons.forward),
      onPressed: () {},
    );
  }
}

fluent.ButtonStyle _getButtonStyle(BuildContext context) {
  return fluent.ButtonStyle(
    foregroundColor: fluent.ButtonState.resolveWith((states) {
      return states.isDisabled ? null : context.colorScheme.onBackground;
    }),
    shape: fluent.ButtonState.all(
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
    ),
  );
}
