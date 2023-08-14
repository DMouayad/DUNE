import 'package:dune/presentation/custom_widgets/adaptive_chip.dart';
import 'package:dune/presentation/pages/settings_page/common/setting_component_card.dart';
import 'package:dune/presentation/providers/state_controllers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppThemeSettingComponent extends ConsumerWidget {
  const AppThemeSettingComponent({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final controller = ref.watch(appThemeControllerProvider.notifier);
    final currentThemeMode = ref.watch(appThemeControllerProvider).themeMode;
    return SettingComponentCard(
      iconData: Icons.format_paint_outlined,
      title: 'App theme',
      trailingText: currentThemeMode.name,
      children: [
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: List.generate(ThemeMode.values.length, (index) {
            final mode = ThemeMode.values[index];
            return AdaptiveChip(
              selected: currentThemeMode == mode,
              text: mode.name.replaceAll("ThemeMode.", ''),
              onPressed: () => controller.setThemeMode(mode),
            );
          }),
        ),
      ],
    );
  }
}
