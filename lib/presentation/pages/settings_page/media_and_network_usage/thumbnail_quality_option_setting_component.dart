import 'package:dune/domain/app_preferences/base_app_preferences.dart';
import 'package:dune/presentation/custom_widgets/adaptive_chip.dart';
import 'package:dune/presentation/providers/state_controllers.dart';
import 'package:dune/support/extensions/context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../common/setting_component_card.dart';

class ThumbnailQualityOptionSettingComponent extends ConsumerWidget {
  const ThumbnailQualityOptionSettingComponent({super.key});

  @override
  Widget build(context, ref) {
    final currentQualitiesOrder = ref.watch(appPreferencesController
        .select((value) => value.thumbnailQualitiesOrder));

    return SettingComponentCard(
      title: 'Thumbnails Quality',
      iconData: Icons.image_rounded,
      contentPadding: const EdgeInsets.symmetric(horizontal: 12),
      trailingText: currentQualitiesOrder.name,
      children: [
        Text(
          'Configure the thumbnail image quality for online-source media,'
          ' applied to: songs and albums cover, artists profile image, etc...',
          style: context.textTheme.bodyMedium?.copyWith(
            color: context.colorScheme.onPrimaryContainer,
          ),
        ),
        const SizedBox(height: 30),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: List.generate(ThumbnailQualitiesOrderOption.values.length,
              (index) {
            final option = ThumbnailQualitiesOrderOption.values[index];
            return AdaptiveChip(
              selected: currentQualitiesOrder == option,
              text: option.name,
              onPressed: () => onChanged(option, ref),
            );
          }).reversed.toList(),
        ),
      ],
    );
  }

  void onChanged(ThumbnailQualitiesOrderOption option, WidgetRef ref) {
    ref
        .read(appPreferencesController.notifier)
        .setThumbnailQualitiesOrderOption(option);
  }
}
