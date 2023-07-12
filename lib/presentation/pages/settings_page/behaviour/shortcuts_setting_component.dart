import 'package:dune/support/extensions/context_extensions.dart';
import 'package:flutter/material.dart';

import '../common/setting_component_card.dart';

const kShortCuts = [
  {'keys': 'Space', 'function': "Play\\Pause"},
  {'keys': 'CTRL + M', 'function': "Mute\\Un-Mute DUNE's audio volume"},
  {'keys': 'CTRL + ArrowUp', 'function': "Increase DUNE's audio volume"},
  {'keys': 'CTRL + ArrowDown', 'function': "Decrease DUNE's audio volume"},
  {'keys': 'CTRL + ArrowRight', 'function': "Jump forward"},
  {'keys': 'CTRL + ArrowLeft', 'function': "Jump backward"},
  {'keys': 'CTRL + S', 'function': "Open Search"},
];

class ShortcutsSettingComponent extends StatelessWidget {
  const ShortcutsSettingComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SettingComponentCard(
      iconData: Icons.keyboard_alt_outlined,
      title: 'Keys Map',
      children: [
        Center(
          child: ListTile(
            dense: true,
            minLeadingWidth: 4,
            leading: Icon(
              Icons.info_outline,
              color: context.colorScheme.secondary,
            ),
            title: Text(
              'customizing keys mapping will be made available in future versions',
              style: context.textTheme.titleSmall?.copyWith(
                color: context.colorScheme.primary,
              ),
            ),
          ),
        ),
        ...kShortCuts
            .map((e) => _ShortcutInfoWidget(
                  keys: e['keys']!,
                  function: e['function']!,
                ))
            .toList(),
      ],
    );
  }
}

class _ShortcutInfoWidget extends StatelessWidget {
  const _ShortcutInfoWidget({
    Key? key,
    required this.keys,
    required this.function,
  }) : super(key: key);
  final String keys;
  final String function;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      title: Text(
        function,
        style: context.textTheme.bodyLarge?.copyWith(
          color: context.colorScheme.secondary,
        ),
      ),
      trailing: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
          child: Text(
            keys,
            style: context.textTheme.titleSmall,
          ),
        ),
      ),
    );
  }
}
