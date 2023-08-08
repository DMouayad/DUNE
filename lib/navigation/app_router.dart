library app_router;

import 'package:dune/domain/audio/base_models/thumbnails_set.dart';
import 'package:dune/presentation/custom_widgets/page_body_wrapper.dart';
import 'package:dune/presentation/pages/explore_music_category_page.dart';
import 'package:dune/presentation/pages/explore_page/explore_page.dart';
import 'package:dune/presentation/pages/library_page/library_page.dart';
import 'package:dune/presentation/pages/listening_history_page/listening_history_page.dart';
import 'package:dune/presentation/pages/playlist_page/playlist_page.dart';
import 'package:dune/presentation/pages/search_page/search_page.dart';
import 'package:dune/presentation/pages/settings_page/settings_page.dart';
import 'package:dune/presentation/screens/desktop_splash_screen.dart';
import 'package:dune/presentation/screens/home/desktop_home_screen.dart';
import 'package:dune/presentation/screens/home/home_screen.dart';
import 'package:dune/presentation/screens/home/wide_home_screen.dart';
import 'package:dune/support/context_builders/context_builder.dart';
import 'package:dune/support/context_builders/context_widget_builder.dart';
import 'package:dune/support/enums/initial_page_on_startup.dart';
import 'package:dune/support/enums/music_source.dart';
import 'package:dune/support/extensions/context_extensions.dart';
import 'package:fluent_ui/fluent_ui.dart' show DrillInPageTransition;
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../env.dart';

part 'routes/home_screen_route.dart';

part 'routes/desktop_splash_screen_route.dart';

part 'routes/playlist_page_route.dart';

part 'routes/category_playlists_page_route.dart';

part 'constants.dart';

class AppRouter {
  static final GlobalKey<NavigatorState> rootNavigatorKey =
      GlobalKey<NavigatorState>();
  static late final AppRouter _instance;

  final GoRouter _defaultLayoutRouter;

  /// A [GoRouter] _instance used as the primary app Navigator/Router.
  ///
  /// this router has only one route which is the home screen route
  final GoRouter _tabsLayoutRouter;

  final String _initialLocation;

  static late bool _tabsModeEnabled;

  static String get initialLocation => _instance._initialLocation;

  static GoRouter get router => _tabsModeEnabled
      ? _instance._tabsLayoutRouter
      : _instance._defaultLayoutRouter;

  AppRouter._(this._initialLocation)
      : _tabsLayoutRouter = GoRouter(
          navigatorKey: AppRouter.rootNavigatorKey,
          initialLocation: RoutePath.desktopSplashScreenPage,
          routes: [
            DesktopSplashScreenRoute(),
            GoRoute(
              path: '/home',
              builder: (context, state) => const WideTabsLayoutHomeScreen(),
            ),
          ],
        ),
        _defaultLayoutRouter = GoRouter(
          navigatorKey: AppRouter.rootNavigatorKey,
          initialLocation: RoutePath.desktopSplashScreenPage,
          routes: [
            StatefulShellRoute.indexedStack(
              builder: (
                BuildContext context,
                GoRouterState state,
                StatefulNavigationShell navigationShell,
              ) {
                return CustomBuilder<Widget>(
                  adaptiveBuilder: AdaptiveBuilder(
                    windowsChild: WideDefaultLayoutHomeScreen(navigationShell),
                  ),
                  responsiveBuilder: ResponsiveBuilder(
                    mobileChild: HomeScreen(navigationShell),
                    wideScreenChild:
                        WideDefaultLayoutHomeScreen(navigationShell),
                  ),
                ).of(context);
              },
              branches: [
                // the order must be the same as the values of
                // [HomeNavigationShellBranchIndex]
                StatefulShellBranch(routes: [ExplorePageRoute()]),
                StatefulShellBranch(routes: [SearchPageRoute()]),
                StatefulShellBranch(routes: [ListeningHistoryPageRoute()]),
                StatefulShellBranch(routes: [LibraryPageRoute()]),
                StatefulShellBranch(routes: [SettingsPageRoute()]),
              ],
            ),
            DesktopSplashScreenRoute(),
          ],
          debugLogDiagnostics: kIsDebug,
        );

  static void init({required String initialLocation}) {
    instance = AppRouter._(initialLocation);
  }

  static final homeNavigationShellBranches = {
    HomeNavigationShellBranchIndex.explorePage: (
      route: ExplorePageRoute(),
      page: const ExplorePage()
    ),
    HomeNavigationShellBranchIndex.searchPage: (
      route: SearchPageRoute(),
      page: const SearchPage(),
    ),
    HomeNavigationShellBranchIndex.libraryPage: (
      route: LibraryPageRoute(),
      page: const LibraryPage(),
    ),
    HomeNavigationShellBranchIndex.settingsPage: (
      route: SettingsPageRoute(),
      page: const SettingsPage()
    ),
    HomeNavigationShellBranchIndex.listeningHistoryPage: (
      route: ListeningHistoryPageRoute(),
      page: const ListeningHistoryPage()
    )
  };

  static String get currentLocation {
    final RouteMatch lastMatch =
        AppRouter.instance.router.routerDelegate.currentConfiguration.last;
    final RouteMatchList matchList = lastMatch is ImperativeRouteMatch
        ? lastMatch.matches
        : AppRouter.instance.router.routerDelegate.currentConfiguration;
    return matchList.uri.toString();
  }

  static ({BaseHomeScreenBodyRoute data, Widget page}) getInitialRoute(
      InitialPageOnStartup initialPageOnStartup) {
    return switch (initialPageOnStartup) {
      InitialPageOnStartup.exploreMusic => (
          data: ExplorePageRoute(),
          page: const ExplorePage()
        ),
      InitialPageOnStartup.myLibrary => (
          data: LibraryPageRoute(),
          page: const LibraryPage()
        ),
    };
  }

  static bool canPop() {
    RegExp exp = RegExp(r'/\w[^/]');
    return exp.allMatches(AppRouter.currentLocation).length != 1;
  }
}
