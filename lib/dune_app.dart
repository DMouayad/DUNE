import 'package:dune/navigation/app_router.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//
import 'presentation/providers/state_controllers.dart';
import 'support/themes/fluent_app_themes.dart';

class DuneApp extends StatelessWidget {
  const DuneApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const _DuneWindowsApp();
  }
}

class _DuneWindowsApp extends ConsumerWidget {
  const _DuneWindowsApp();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appTheme = ref.watch(appThemeControllerProvider);
    return FluentApp.router(
      routerConfig: AppRouter.instance.router,
      title: 'dune',
      themeMode: appTheme.themeMode,
      debugShowCheckedModeBanner: false,
      theme: FluentAppThemes.lightTheme(appTheme),
      darkTheme: FluentAppThemes.darkTheme(appTheme),
    );
  }
}
