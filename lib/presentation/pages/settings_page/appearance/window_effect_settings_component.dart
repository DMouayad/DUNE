import 'package:dune/presentation/custom_widgets/adaptive_chip.dart';
import 'package:dune/presentation/pages/settings_page/common/setting_component_card.dart';
import 'package:dune/presentation/providers/state_controllers.dart';
import 'package:dune/support/themes/theme_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WindowEffectSettingComponent extends ConsumerWidget {
  const WindowEffectSettingComponent({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final currentEffect = ref.watch(appThemeControllerProvider).windowEffect;
    return SettingComponentCard(
      iconData: Icons.style_outlined,
      title: 'Window Effects',
      children: [
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children:
              List.generate(supportedDesktopWindowEffects.length, (index) {
            final windowEffect = supportedDesktopWindowEffects[index];
            return AdaptiveChip(
              selected: currentEffect == windowEffect,
              text: windowEffect.name,
              onPressed: () {
                ref
                    .watch(appThemeControllerProvider.notifier)
                    .setWindowEffect(windowEffect);
              },
            );
          }),
        ),
      ],
    );
  }
}
