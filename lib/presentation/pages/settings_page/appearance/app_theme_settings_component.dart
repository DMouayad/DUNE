import 'package:dune/presentation/custom_widgets/adaptive_chip.dart';
import 'package:dune/presentation/pages/settings_page/common/setting_component_card.dart';
import 'package:flutter/material.dart';

class AppThemeSettingComponent extends StatelessWidget {
  final ThemeMode currentThemeMode;
  final void Function(ThemeMode) onChanged;

  const AppThemeSettingComponent({
    super.key,
    required this.currentThemeMode,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
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
              onPressed: () => onChanged(mode),
            );
          }),
        ),
      ],
    );
  }
}
