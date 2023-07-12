import 'package:dune/navigation/app_router.dart';
import 'package:dune/presentation/providers/shared_providers.dart';
import 'package:dune/support/extensions/context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SettingsButton extends ConsumerWidget {
  const SettingsButton({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final inSettingsPage = ref.watch(homeNavigationShellBranchIndexProvider) ==
        HomeNavigationShellBranchIndex.settingsPage;

    return IconButton(
      onPressed: () {
        ref
            .read(homeNavigationShellBranchIndexProvider.notifier)
            .update((state) => HomeNavigationShellBranchIndex.settingsPage);
      },
      icon: Icon(
        inSettingsPage ? Icons.settings : Icons.settings_outlined,
        size: 20,
        color: inSettingsPage
            ? context.colorScheme.primary
            : context.colorScheme.onSurfaceVariant,
      ),
    );
  }
}
