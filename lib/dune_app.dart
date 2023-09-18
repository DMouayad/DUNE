import 'package:dune/navigation/app_router.dart';
import 'package:dune/presentation/providers/shared_providers.dart';
import 'package:dune/support/extensions/context_extensions.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

//
import 'presentation/models/tabs_state.dart';
import 'presentation/providers/state_controllers.dart';
import 'support/themes/fluent_app_themes.dart';

class DuneApp extends ConsumerStatefulWidget {
  const DuneApp({super.key});

  @override
  ConsumerState<DuneApp> createState() => _DuneAppState();
}

class _DuneAppState extends ConsumerState<DuneApp>
    with AutomaticKeepAliveClientMixin {
  int? tabsCount;
  GoRouter? router;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    ref.listen(
        appPreferencesController.select((value) => value.audioStreamingQuality),
        (previous, next) {
      ref
          .read(playbackControllerProvider.notifier)
          .player
          .setAudioStreamingQuality(next);
    });
    final appTheme = ref.watch(appThemeControllerProvider);
    final appPrefs = ref.watch(appPreferencesController);

    final shouldUseTabs = (!context.isMobile || context.isDesktopPlatform) &&
        appPrefs.tabsMode.isEnabled;
    // at the app start we assign it to one if [shouldUseTabs]
    tabsCount ??= shouldUseTabs ? 1 : null;
    if (router == null) {
      final initialAppPage =
          AppRouter.getInitialAppPage(appPrefs.initialPageOnStartup);
      final initialTabsState =
          shouldUseTabs ? _getInitialTabsState(initialAppPage) : null;
      // initialize the [AppRouter.router]
      AppRouter.init(
        // the first-ever location for the app
        RoutePath.desktopSplashScreenPage,
        initialAppPage,
        initialTabsState,
      );
      if (shouldUseTabs) {
        _registerTabsStateProvider(initialTabsState!);
      }
      router = AppRouter.router;
      updateKeepAlive();
    }
    if (shouldUseTabs) {
      if (tabsCount != ref.watch(tabsStateProvider).tabsCount) {
        tabsCount = ref.watch(tabsStateProvider).tabsCount;
        final selectedTab = ref.watch(tabsStateProvider).selectedTab;
        final newInitialLocation = selectedTab?.selectedPage?.path;
        // update the app router
        AppRouter.updateTabs(ref.watch(tabsStateProvider), newInitialLocation);
        router = AppRouter.router;
        updateKeepAlive();
      }
    }

    return FluentApp.router(
      routerConfig: router!,
      title: 'dune',
      themeMode: appTheme.themeMode,
      debugShowCheckedModeBanner: false,
      theme: FluentAppThemes.lightTheme(appTheme),
      darkTheme: FluentAppThemes.darkTheme(appTheme),
    );
  }

  TabsState _getInitialTabsState(InitialAppPage initialAppPage) {
    return TabsState(tabs: [
      TabData(tabIndex: 0).copyWithPageAdded(
        path: '/tabs/0${initialAppPage.path}',
        title: initialAppPage.name,
      )
    ]);
  }

  void _registerTabsStateProvider(TabsState initialState) {
    tabsStateProvider = StateProvider((ref) => initialState);
  }

  @override
  bool get wantKeepAlive => true;
}
