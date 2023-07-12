import 'package:dune/presentation/pages/settings_page/common/setting_component_card.dart';
import 'package:dune/presentation/providers/state_controllers.dart';
import 'package:dune/support/extensions/context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppWindowSizeSettingComponent extends ConsumerWidget {
  const AppWindowSizeSettingComponent({super.key});

  @override
  Widget build(BuildContext context, ref) {
    return SettingComponentCard(
      title: "Window Size",
      iconData: Icons.screenshot_monitor,
      children: [
        SwitchListTile(
          title: Text(
            "Remember last window Size",
            style: context.textTheme.titleMedium?.copyWith(
              color: context.colorScheme.primary,
              fontWeight: FontWeight.w500,
            ),
          ),
          subtitle: const Text(
            "Whether to restore the same window size on the next time you open"
            " the app.",
          ),
          value: ref.watch(appPreferencesController).rememberLastWindowSize,
          onChanged: (value) {
            ref
                .read(appPreferencesController.notifier)
                .setShouldRememberLastWindowSize(value);
          },
        ),
      ],
    );
  }
}
