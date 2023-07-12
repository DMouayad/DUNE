import 'package:dune/support/helpers/platform_helpers.dart';
import 'package:dune/support/helpers/provider_helpers.dart';
import 'package:flutter/material.dart';
import 'package:fluent_ui/fluent_ui.dart' as fluent;
import 'package:system_theme/system_theme.dart';

import '../common/setting_component_card.dart';

class PrimaryColorSettingComponent extends StatelessWidget {
  final MaterialColor currentPrimaryColor;
  final void Function(MaterialColor color) onChanged;

  const PrimaryColorSettingComponent({
    super.key,
    required this.currentPrimaryColor,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
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
          children: [
            ...Colors.primaries.map((color) {
              return _ColorBlock(
                onSelected: () => onChanged(color),
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
                      onSelected: () => onChanged(systemColor),
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
    return Padding(
      padding: const EdgeInsets.all(2.0),
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
