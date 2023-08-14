import 'package:dune/presentation/providers/state_controllers.dart';
import 'package:dune/support/extensions/context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../common/setting_component_card.dart';

final _tabsModeEnabledProvider =
    StateProvider((ref) => ref.watch(appPreferencesController).tabsModeEnabled);

class LayoutModeSettingComponent extends ConsumerWidget {
  const LayoutModeSettingComponent({super.key});

  @override
  Widget build(BuildContext context, ref) {
    return SettingComponentCard(
      title: 'Layout Mode',
      iconData: Icons.design_services_rounded,
      children: [
        SwitchListTile(
          title: Text(
            "Tabs",
            style: context.textTheme.titleMedium?.copyWith(
              color: context.colorScheme.primary,
              fontWeight: FontWeight.w500,
            ),
          ),
          subtitle: RichText(
            text: TextSpan(
                text:
                    "If enabled, newly opened pages will appear in a separate tab.\n",
                style: context.textTheme.bodyMedium,
                children: [
                  TextSpan(
                    text:
                        "Note: changes will take effect after restarting the app.",
                    style: context.textTheme.titleSmall,
                  ),
                ]),
          ),
          value: ref.watch(_tabsModeEnabledProvider),
          onChanged: (value) {
            ref.read(_tabsModeEnabledProvider.notifier).state = value;
            ref
                .read(appPreferencesController.notifier)
                .setTabModeIsEnabled(value);
          },
        ),
      ],
    );
  }
}
