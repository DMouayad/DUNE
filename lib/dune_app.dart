import 'package:dune/support/extensions/context_extensions.dart';
import 'package:fluent_ui/fluent_ui.dart' as fluent;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//
import 'presentation/providers/state_controllers.dart';
import 'support/themes/fluent_app_themes.dart';
import 'support/themes/material_app_themes.dart';
import 'navigation/navigation.dart';

class DuneApp extends ConsumerWidget {
  const DuneApp({super.key});

  @override
  Widget build(BuildContext context, ref) {
    ref.listen(
        appPreferencesController.select((value) => value.audioStreamingQuality),
        (previous, next) {
      ref
          .read(playbackControllerProvider.notifier)
          .player
          .setAudioStreamingQuality(next);
    });
    return context.isDesktopPlatform
        ? const _FluentDuneApp()
        : const _MaterialDuneApp();
  }
}

class _FluentDuneApp extends ConsumerWidget {
  const _FluentDuneApp();

  @override
  Widget build(BuildContext context, ref) {
    final appTheme = ref.watch(appThemeControllerProvider);
    return fluent.FluentApp.router(
      routerConfig: AppNavigation.instance.appRouter,
      title: 'DUNE',
      themeMode: appTheme.themeMode,
      debugShowCheckedModeBanner: false,
      theme: FluentAppThemes.lightTheme(appTheme),
      darkTheme: FluentAppThemes.darkTheme(appTheme),
    );
  }
}

class _MaterialDuneApp extends ConsumerWidget {
  const _MaterialDuneApp();

  @override
  Widget build(BuildContext context, ref) {
    final appTheme = ref.watch(appThemeControllerProvider);

    return MaterialApp.router(
      routerConfig: AppNavigation.instance.appRouter,
      title: 'DUNE',
      themeMode: appTheme.themeMode,
      debugShowCheckedModeBanner: false,
      theme: MaterialAppThemes.lightTheme(appTheme),
      darkTheme: MaterialAppThemes.darkTheme(appTheme),
    );
  }
}
