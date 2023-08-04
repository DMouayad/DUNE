import 'package:dune/presentation/custom_widgets/adaptive_chip.dart';
import 'package:dune/presentation/pages/settings_page/common/more_sources_info.dart';
import 'package:dune/presentation/pages/settings_page/common/setting_component_card.dart';
import 'package:dune/presentation/providers/state_controllers.dart';
import 'package:dune/support/enums/music_source.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MusicSearchSourceSettingComponent extends ConsumerWidget {
  const MusicSearchSourceSettingComponent({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final currentSource = ref
        .watch(appPreferencesController.select((value) => value.searchEngine));
    return SettingComponentCard(
      iconData: Icons.manage_search,
      title: 'Default Search Engine',
      trailingText: currentSource.name,
      children: [
        const MoreSourcesFeatureInfo(),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children:
              List.generate(MusicSource.valuesWithoutUnknown.length, (index) {
            final source = MusicSource.valuesWithoutUnknown[index];
            return AdaptiveChip(
              selected: currentSource == source,
              text: source.name,
              onPressed: source != MusicSource.youtube
                  ? null
                  : () {
                      ref
                          .read(appPreferencesController.notifier)
                          .setSearchEngine(source);
                    },
            );
          }),
        ),
      ],
    );
  }
}
