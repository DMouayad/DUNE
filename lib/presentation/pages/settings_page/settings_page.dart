import 'package:dune/presentation/custom_widgets/page_title.dart';
import 'package:dune/presentation/providers/state_controllers.dart';
import 'package:dune/presentation/utils/constants.dart';
import 'package:dune/support/themes/theme_constants.dart';
import 'package:dune/support/extensions/context_extensions.dart';
import 'package:fluent_ui/fluent_ui.dart' as fluent;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'about_section.dart';
import 'appearance/primary_color_settings_component.dart';
import 'appearance/layout_settings_component.dart';
import 'appearance/app_window_size_setting_component.dart';
import 'appearance/side_panel_size_setting_component.dart';
import 'behaviour/initial_page_setting_component.dart';
import 'common/setting_section.dart';
import 'behaviour/shortcuts_setting_component.dart';
import 'appearance/app_theme_settings_component.dart';
import 'appearance/window_effect_settings_component.dart';
import 'media_and_network_usage/audio_streaming_quality_option_setting_component.dart';
import 'media_and_network_usage/explore_music_source_setting_component.dart';
import 'media_and_network_usage/music_search_source_setting_component.dart';
import 'media_and_network_usage/thumbnail_quality_option_setting_component.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final appThemeController = ref.watch(appThemeControllerProvider.notifier);
    final appTheme = ref.watch(appThemeControllerProvider);
    const biggerSpacer = SizedBox(height: 40.0);

    return fluent.ScaffoldPage(
      header: const PageTitle('Settings'),
      padding: kPagePadding,
      content: ListView(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
        physics: const BouncingScrollPhysics(),
        children: [
          SettingSection(
            title: 'Appearance & Layout',
            contents: [
              AppThemeSettingComponent(
                currentThemeMode: appTheme.themeMode,
                onChanged: (themeMode) =>
                    appThemeController.setThemeMode(themeMode),
              ),
              PrimaryColorSettingComponent(
                currentPrimaryColor: appTheme.primaryColor,
                onChanged: (MaterialColor color) {
                  appThemeController.setAccentColor(color);
                },
              ),
              if (kIsWindowEffectsSupported)
                const WindowEffectSettingComponent(),
              if (!context.isMobile || context.isDesktopPlatform) ...[
                if (!kIsWeb) const AppWindowSizeSettingComponent(),
                const LayoutModeSettingComponent(),
                const SidePanelSizeSettingComponent(),
              ]
            ],
          ),
          // biggerSpacer,
          const SettingSection(
            title: 'Media & Network Usage',
            contents: [
              ExploreMusicSourceSettingComponent(),
              MusicSearchSourceSettingComponent(),
              ThumbnailQualityOptionSettingComponent(),
              AudioStreamingQualityOptionSettingComponent(),
            ],
          ),
          // Divider(),
          SettingSection(
            title: 'Behaviour',
            contents: [
              const InitialPageSettingComponent(),
              if (context.isDesktopPlatform) ...[
                // const VolumeStepSettingComponent(),
                const ShortcutsSettingComponent(),
              ],
            ],
          ),
          biggerSpacer,
          const AboutSection(),
          const SizedBox(height: 80),
        ],
      ),
    );
  }
}
