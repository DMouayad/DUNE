import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//
import 'package:dune/support/extensions/context_extensions.dart';
import 'package:dune/presentation/providers/state_controllers.dart';
import '../common/setting_component_card.dart';

class DesktopAppBarSettingComponent extends ConsumerWidget {
  const DesktopAppBarSettingComponent({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final autoHideEnabled =
        ref.watch(appPreferencesController).autoHideWideScreenAppBarButtons;
    return SettingComponentCard(
      title: 'App bar',
      iconData: Icons.desktop_windows_rounded,
      children: [
        SwitchListTile(
          title: Text(
            'Automatically hide buttons in top app bar',
            style: context.textTheme.titleSmall?.copyWith(
              color: autoHideEnabled
                  ? context.colorScheme.primary
                  : context.colorScheme.onBackground.withOpacity(.8),
              fontWeight: FontWeight.w500,
            ),
          ),
          value: ref
              .watch(appPreferencesController)
              .autoHideWideScreenAppBarButtons,
          onChanged: (enabled) {
            ref
                .read(appPreferencesController.notifier)
                .setAutoHideAppBarButtons(enabled);
          },
        ),
      ],
    );
  }
}
