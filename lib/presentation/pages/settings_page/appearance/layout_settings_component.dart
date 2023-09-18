import 'dart:math';

import 'package:dune/domain/app_preferences/base_app_preferences.dart';
import 'package:dune/presentation/providers/state_controllers.dart';
import 'package:dune/support/extensions/context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../common/setting_component_card.dart';

final _tabsModeProvider =
    StateProvider((ref) => ref.watch(appPreferencesController).tabsMode);

class LayoutModeSettingComponent extends ConsumerWidget {
  const LayoutModeSettingComponent({super.key});

  @override
  Widget build(BuildContext context, ref) {
    // we use the standalone [_tabsModeProvider]
    // to reflect any changes made by the user in the UI (only to know if it's enabled or not)
    // The real change in app's layout will take affect at the next startup.
    final isEnabled = ref.watch(_tabsModeProvider).isEnabled;
    return SettingComponentCard(
      title: 'Tabs',
      iconData: Icons.tab_outlined,
      children: [
        SwitchListTile(
          title: Text(
            'Tabs are ${isEnabled ? "enabled" : 'disabled'}',
            style: context.textTheme.titleSmall?.copyWith(
              color: isEnabled
                  ? context.colorScheme.primary
                  : context.colorScheme.onBackground.withOpacity(.8),
              fontWeight: FontWeight.w500,
            ),
          ),
          value: isEnabled,
          onChanged: (enabled) {
            final newMode = enabled ? TabsMode.vertical : TabsMode.disabled;
            ref.read(_tabsModeProvider.notifier).state = newMode;
            ref.read(appPreferencesController.notifier).setTabMode(newMode);
          },
        ),
        if (isEnabled)
          Container(
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.only(top: 22, left: 26),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Note: changes will take effect after restarting the app.",
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: context.colorScheme.onBackground.withOpacity(.8),
                  ),
                ),
                Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    const Text('tabs alignment:'),
                    ...[TabsMode.vertical, TabsMode.horizontal]
                        .map((e) => _OptionWidget(e))
                        .toList(),
                  ],
                )
              ],
            ),
          ),
      ],
    );
  }
}

class _OptionWidget extends ConsumerWidget {
  const _OptionWidget(this.mode);

  final TabsMode mode;

  @override
  Widget build(BuildContext context, ref) {
    final currentMode = ref.watch(_tabsModeProvider);

    return SizedBox(
      width: min(200, context.screenWidth * .3),
      child: RadioListTile(
        groupValue: currentMode,
        value: mode,
        onChanged: (value) {
          if (value == null) return;
          ref.read(_tabsModeProvider.notifier).state = value;
          ref.read(appPreferencesController.notifier).setTabMode(value);
        },
        title: Text(mode.name),
      ),
    );
  }
}
