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
        Text(
          "Note: if you enable/disable tabs, restarting the app is required for changes to take effect.",
          textAlign: TextAlign.start,
          style: context.textTheme.bodyMedium?.copyWith(
            color: context.colorScheme.onBackground.withOpacity(.8),
          ),
        ),
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
            padding: const EdgeInsets.only(left: 20),
            child: Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                const Text('Tabs alignment:'),
                ...[TabsMode.vertical, TabsMode.horizontal]
                    .map((e) => _OptionWidget(e))
                    .toList(),
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
      child: CheckboxListTile(
        value: currentMode == mode,
        dense: true,
        controlAffinity: ListTileControlAffinity.leading,
        onChanged: (selected) {
          if (selected ?? false) {
            ref.read(_tabsModeProvider.notifier).state = mode;
            ref.read(appPreferencesController.notifier).setTabMode(mode);
          }
        },
        title: Text(mode.name),
      ),
    );
  }
}
