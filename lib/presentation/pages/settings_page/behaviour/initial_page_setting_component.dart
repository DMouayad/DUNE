import 'package:dune/presentation/custom_widgets/adaptive_chip.dart';
import 'package:dune/presentation/pages/settings_page/common/setting_component_card.dart';
import 'package:dune/presentation/providers/state_controllers.dart';
import 'package:dune/support/enums/initial_page_on_startup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class InitialPageSettingComponent extends ConsumerWidget {
  const InitialPageSettingComponent({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final currentInitialPage = ref.watch(
        appPreferencesController.select((value) => value.initialPageOnStartup));
    return SettingComponentCard(
      iconData: Icons.assistant_navigation,
      title: 'Initial Page',
      children: [
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: List.generate(InitialPageOnStartup.values.length, (index) {
            final page = InitialPageOnStartup.values[index];
            return AdaptiveChip(
              selected: currentInitialPage == page,
              text: page.optionName,
              onPressed: () => ref
                  .read(appPreferencesController.notifier)
                  .setInitialPageOnStartup(page),
            );
          }),
        ),
      ],
    );
  }
}
