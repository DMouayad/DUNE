import 'package:dune/presentation/custom_widgets/adaptive_chip.dart';
import 'package:dune/presentation/pages/settings_page/common/setting_component_card.dart';
import 'package:dune/presentation/providers/state_controllers.dart';
import 'package:dune/support/enums/music_source.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../common/more_sources_info.dart';

class ExploreMusicSourceSettingComponent extends ConsumerWidget {
  const ExploreMusicSourceSettingComponent({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final currentSource = ref.watch(
        appPreferencesController.select((value) => value.exploreMusicSource));
    return SettingComponentCard(
      iconData: Icons.explore_outlined,
      title: 'Default Explore Music Source',
      trailingText: currentSource.name,
      children: [
        const MoreSourcesFeatureInfo(),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: List.generate(MusicSource.remoteSources.length, (index) {
            final source = MusicSource.remoteSources[index];
            return AdaptiveChip(
              selected: currentSource == source,
              text: source.name,
              onPressed: source != MusicSource.youtube
                  ? null
                  : () => ref
                      .read(appPreferencesController.notifier)
                      .setExploreMusicSource(source),
            );
          }),
        ),
      ],
    );
  }
}
