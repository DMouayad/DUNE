import 'package:dune/presentation/custom_widgets/adaptive_chip.dart';
import 'package:dune/presentation/pages/settings_page/common/setting_component_card.dart';
import 'package:dune/presentation/providers/state_controllers.dart';
import 'package:dune/support/enums/quick_nav_destination.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class StartupPageSettingComponent extends ConsumerWidget {
  const StartupPageSettingComponent({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final currentInitialPage = ref.watch(appPreferencesController
        .select((value) => value.initialStartupDestination));
    return SettingComponentCard(
      iconData: Icons.assistant_navigation,
      title: 'Startup Page',
      children: [
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: List.generate(QuickNavDestination.values.length, (index) {
            final page = QuickNavDestination.values[index];
            return AdaptiveChip(
              selected: currentInitialPage == page,
              text: page.title,
              onPressed: () => ref
                  .read(appPreferencesController.notifier)
                  .setQuickNavDestination(page),
            );
          }),
        ),
      ],
    );
  }
}
