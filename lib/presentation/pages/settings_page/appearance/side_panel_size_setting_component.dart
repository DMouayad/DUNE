import 'package:dune/presentation/pages/settings_page/common/setting_component_card.dart';
import 'package:dune/presentation/providers/state_controllers.dart';
import 'package:dune/support/extensions/context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SidePanelSizeSettingComponent extends ConsumerWidget {
  const SidePanelSizeSettingComponent({super.key});

  @override
  Widget build(BuildContext context, ref) {
    return SettingComponentCard(
      title: "Side panel",
      iconData: Icons.window,
      children: [
        SwitchListTile(
          title: Text(
            "Remember Side Panel Size",
            style: context.textTheme.titleMedium?.copyWith(
              color: context.colorScheme.primary,
              fontWeight: FontWeight.w500,
            ),
          ),
          subtitle: const Text(
            "Remember side panel width on the next startup",
          ),
          value: ref.watch(appPreferencesController).rememberLastSidePanelSize,
          onChanged: (value) {
            ref
                .read(appPreferencesController.notifier)
                .setShouldRememberLastSidePanelSize(value);
          },
        ),
      ],
    );
  }
}
