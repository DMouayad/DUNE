// EXTERNAL PACKAGES
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_taggy/flutter_taggy.dart';
import 'package:media_kit/media_kit.dart';

// APP
import 'package:dune/dune_app.dart';

// SUPPORT
import 'support/helpers/app_window_helper.dart';
import 'support/helpers/dependencies_helper.dart';
import 'support/helpers/platform_helpers.dart';
import 'support/helpers/isar_helper.dart';
import 'support/helpers/provider_helpers.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MediaKit.ensureInitialized();
  Taggy.initialize();

  final isar = await IsarHelper.init();
  final appTheme = await registerThemeProvider(isar);
  final appPreferences = await registerAppPreferencesControllerProvider(isar);

  if (isDesktopNotWebPlatform) {
    // configure the app window
    await AppWindowHelper.initConfigurations(appPreferences);
    await AppWindowHelper.setWindowEffect(appTheme);
  }

  await registerMusicFacades(isar);

  registerNavigationService(appPreferences);

  // initialize global [Provider]s variables
  registerControllersProviders();

  runApp(const ProviderScope(child: DuneApp()));
}
