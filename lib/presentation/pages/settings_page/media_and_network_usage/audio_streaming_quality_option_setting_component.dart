import 'package:dune/presentation/custom_widgets/adaptive_chip.dart';
import 'package:dune/presentation/providers/state_controllers.dart';
import 'package:dune/support/enums/audio_streaming_quality.dart';
import 'package:dune/support/extensions/context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../common/setting_component_card.dart';

class AudioStreamingQualityOptionSettingComponent extends ConsumerWidget {
  const AudioStreamingQualityOptionSettingComponent({super.key});

  @override
  Widget build(context, ref) {
    final currentQuality = ref
        .watch(appPreferencesController.select((s) => s.audioStreamingQuality));
    return SettingComponentCard(
      title: 'Audio Streaming Quality',
      iconData: Icons.audiotrack_outlined,
      contentPadding: const EdgeInsets.symmetric(horizontal: 4),
      trailingText: currentQuality.name,
      children: [
        Text(
          'Configure the streaming quality:',
          style: context.textTheme.bodyMedium?.copyWith(
            color: context.colorScheme.onPrimaryContainer,
          ),
        ),
        const SizedBox(height: 30),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: List.generate(AudioStreamingQuality.withoutUndefined.length,
              (index) {
            final option = AudioStreamingQuality.withoutUndefined[index];
            return AdaptiveChip(
              selected: currentQuality == option,
              text: option.name,
              onPressed: () {
                ref
                    .read(appPreferencesController.notifier)
                    .setAudioStreamingQualityOption(option);
              },
            );
          }).toList(),
        ),
      ],
    );
  }
}
