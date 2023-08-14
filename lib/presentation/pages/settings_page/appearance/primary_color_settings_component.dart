import 'package:dune/presentation/providers/state_controllers.dart';
import 'package:dune/support/helpers/platform_helpers.dart';
import 'package:dune/support/helpers/provider_helpers.dart';
import 'package:flutter/material.dart';
import 'package:fluent_ui/fluent_ui.dart' as fluent;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:system_theme/system_theme.dart';

import '../common/setting_component_card.dart';

class PrimaryColorSettingComponent extends ConsumerWidget {
  const PrimaryColorSettingComponent({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final controller = ref.watch(appThemeControllerProvider.notifier);
    final currentPrimaryColor =
        ref.watch(appThemeControllerProvider).primaryColor;
    return SettingComponentCard(
      iconData: Icons.format_color_fill_outlined,
      title: 'Accent color',
      trailing: Container(
        height: 30,
        width: 30,
        color: currentPrimaryColor,
        alignment: Alignment.center,
      ),
      children: [
        Wrap(
          spacing: 6,
          runSpacing: 10,
          children: [
            ...Colors.primaries.map((color) {
              return _ColorBlock(
                onSelected: () => controller.setAccentColor(color),
                isCurrent: currentPrimaryColor.value == color.value,
                color: color,
              );
            }).toList(),
            if (isDesktopNotWebPlatform)
              ...() {
                final systemColor = SystemTheme.accentColor.toMaterialColor;
                return [
                  const VerticalDivider(),
                  Tooltip(
                    message: "System color",
                    child: _ColorBlock(
                      onSelected: () => controller.setAccentColor(systemColor),
                      isCurrent: currentPrimaryColor.value == systemColor.value,
                      color: systemColor,
                    ),
                  ),
                ];
              }(),
            // toMaterialColor
          ],
        ),
      ],
    );
  }
}

class _ColorBlock extends StatelessWidget {
  final void Function() onSelected;
  final MaterialColor color;

  final bool isCurrent;

  const _ColorBlock({
    required this.onSelected,
    required this.color,
    required this.isCurrent,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(4),
      child: fluent.Button(
        onPressed: onSelected,
        style: fluent.ButtonStyle(
          padding: fluent.ButtonState.all(EdgeInsets.zero),
        ),
        child: Container(
          height: 40,
          width: 40,
          color: color,
          alignment: Alignment.center,
          child: isCurrent
              ? Icon(
                  fluent.FluentIcons.check_mark,
                  color: color.basedOnLuminance(),
                  size: 22.0,
                )
              : null,
        ),
      ),
    );
  }
}
