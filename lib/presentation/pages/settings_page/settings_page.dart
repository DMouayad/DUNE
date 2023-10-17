import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

//
import 'package:dune/presentation/providers/state_controllers.dart';
import 'package:dune/presentation/pages/settings_page/behaviour/desktop_app_bar_setting_component.dart';
import 'package:dune/support/extensions/context_extensions.dart';
import 'package:dune/support/themes/theme_constants.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'about_section.dart';
import 'package:dune/presentation/custom_widgets/page_title.dart';
import 'appearance/primary_color_settings_component.dart';
import 'appearance/layout_settings_component.dart';
import 'appearance/app_window_size_setting_component.dart';
import 'behaviour/startup_page_setting_component.dart';
import 'common/setting_section.dart';
import 'behaviour/shortcuts_setting_component.dart';
import 'appearance/app_theme_settings_component.dart';
import 'appearance/window_effect_settings_component.dart';
import 'library/music_folders_setting_component.dart';
import 'media_and_network_usage/audio_streaming_quality_option_setting_component.dart';
import 'media_and_network_usage/explore_music_source_setting_component.dart';
import 'media_and_network_usage/images_cache_setting_component.dart';
import 'media_and_network_usage/music_search_source_setting_component.dart';
import 'media_and_network_usage/thumbnail_quality_option_setting_component.dart';

class SettingsDialog extends ConsumerWidget {
  const SettingsDialog({super.key});

  @override
  Widget build(BuildContext context, ref) {
    // we're listening to theme changes here because the theme of dialog and its children
    // doesn't get updated by default when the user toggles the theme mode.
    final theme = ref.watch(appThemeControllerProvider).materialThemeData;
    return Dialog(
      backgroundColor: theme.colorScheme.background,
      shape: const RoundedRectangleBorder(borderRadius: kBorderRadius),
      child: Theme(
        data: theme,
        child: const Stack(
          children: [
            SettingsPage(),
            Positioned(top: 10, right: 10, child: CloseButton()),
          ],
        ),
      ),
    );
  }
}

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    const biggerSpacer = SizedBox(height: 40.0);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 16),
          child: PageTitle('Settings'),
        ),
        Expanded(
          child: ListView(
            shrinkWrap: true,
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
            physics: const BouncingScrollPhysics(),
            children: [
              const SettingSection(
                title: 'Library',
                contents: [MusicFoldersSettingComponent()],
              ),
              SettingSection(
                title: 'Appearance & Layout',
                contents: [
                  const AppThemeSettingComponent(),
                  const PrimaryColorSettingComponent(),
                  if (kIsWindowEffectsSupported)
                    const WindowEffectSettingComponent(),
                  if (!context.isMobile || context.isDesktopPlatform) ...[
                    if (!kIsWeb) const AppWindowSizeSettingComponent(),
                    const LayoutModeSettingComponent(),
                  ]
                ],
              ),
              const SettingSection(
                title: 'Media & Network Usage',
                contents: [
                  ExploreMusicSourceSettingComponent(),
                  MusicSearchSourceSettingComponent(),
                  ThumbnailQualityOptionSettingComponent(),
                  AudioStreamingQualityOptionSettingComponent(),
                  CacheSettingComponent(),
                ],
              ),
              SettingSection(
                title: 'Behaviour',
                contents: [
                  const StartupPageSettingComponent(),
                  if (context.isDesktopPlatform) ...[
                    const DesktopAppBarSettingComponent(),
                    const ShortcutsSettingComponent(),
                  ],
                ],
              ),
              biggerSpacer,
              const AboutSection(),
              const SizedBox(height: 80),
            ],
          ),
        ),
      ],
    );
  }
}
