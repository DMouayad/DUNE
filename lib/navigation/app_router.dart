library app_router;

import 'package:collection/collection.dart';
import 'package:dune/domain/audio/base_models/thumbnails_set.dart';
import 'package:dune/presentation/custom_widgets/page_body_wrapper.dart';
import 'package:dune/presentation/custom_widgets/tab_new_page.dart';
import 'package:dune/navigation/tabs_state.dart';
import 'package:dune/presentation/pages/explore_music_category_page.dart';
import 'package:dune/presentation/pages/explore_page/explore_page.dart';
import 'package:dune/presentation/pages/library_page/library_albums_page.dart';
import 'package:dune/presentation/pages/library_page/library_artists_page.dart';
import 'package:dune/presentation/pages/library_page/library_folders_page.dart';
import 'package:dune/presentation/pages/library_page/library_tracks_page.dart';
import 'package:dune/presentation/pages/listening_history_page/listening_history_page.dart';
import 'package:dune/presentation/pages/playlist_page/playlist_page.dart';
import 'package:dune/presentation/screens/desktop_splash_screen.dart';
import 'package:dune/presentation/screens/home/home_screen.dart';
import 'package:dune/presentation/screens/home/wide_home_screen.dart';
import 'package:dune/support/context_builders/custom_builders.dart';
import 'package:dune/support/enums/initial_page_on_startup.dart';
import 'package:dune/support/enums/music_source.dart';
import 'package:dune/support/extensions/context_extensions.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:go_router/go_router.dart';

import '../env.dart';

part 'routes/home_screen_route.dart';

part 'routes/desktop_splash_screen_route.dart';

part 'routes/playlist_page_route.dart';

part 'routes/category_playlists_page_route.dart';

part 'routes/library_pages_routes.dart';

part 'constants.dart';

typedef InitialAppPage = ({String name, String path});

class AppRouter {
  static final GlobalKey<NavigatorState> rootNavigatorKey =
      GlobalKey<NavigatorState>();
  static late AppRouter _instance;
  static late final bool _tabsModeEnabled;
  static bool get tabsModeEnabled => _tabsModeEnabled;

  static bool get showAppBarBackButton => !_tabsModeEnabled && router.canPop();

  /// called when a Navigation button from the [SidePanel] is pressed
  static void onQuickNavDestinationSelected(
    QuickNavDestination dest,
    StatefulNavigationShell navigationShell,
  ) {
    final destinationIndex = dest.destinationIndex;
    if (_tabsModeEnabled) {
      final currentTab = navigationShell.currentIndex;

      final destinationPath = '/tabs/$currentTab${dest.path}';
      // the [router] will push [destinationPath] into the [currentTab]'s
      // [StatefulShellBranch]
      router.go(destinationPath);
    } else {
      if (navigationShell.currentIndex != destinationIndex) {
        // since we're not using a tabs-layout-router, we simply go
        // to the [StatefulShellBranch] at provided [index]
        navigationShell.goBranch(destinationIndex);
      }
    }
  }

  AppRouter._(this._router);

  final GoRouter _router;

  /// the initial page to go-to after initial location
  static late final InitialAppPage _initialAppPage;

  static InitialAppPage get initialAppPage => _tabsModeEnabled
      ? (path: '/tabs/0${_initialAppPage.path}', name: _initialAppPage.name)
      : _initialAppPage;

  static GoRouter get router => _instance._router;

  static GoRouter _getRouterInstanceForTabsLayout(
    TabsState tabsState,
    String? initialLocation,
  ) {
    return GoRouter(
      debugLogDiagnostics: kIsDebug,
      navigatorKey: AppRouter.rootNavigatorKey,
      initialLocation: initialLocation,
      routes: [
        StatefulShellRoute.indexedStack(
          builder: (context, _, navigationShell) =>
              WideHomeScreen(navigationShell),
          branches: List.generate(tabsState.tabsCount, (index) {
            final tabPath = 'tabs/$index';
            final tabName = 'Tab($index)';
            return StatefulShellBranch(
              initialLocation: tabsState.tabs[index].selectedPage!.path,
              routes: [
                GoRoute(
                  path: '/$tabPath',
                  name: tabName,
                  builder: (context, state) => const NewTabPage(),
                  routes: [
                    ExplorePageRoute(isSubRoute: true),
                    ListeningHistoryPageRoute(isSubRoute: true),
                    LibraryAlbumsPageRoute(isSubRoute: true),
                    LibraryTracksPageRoute(isSubRoute: true),
                    LibraryArtistsPageRoute(isSubRoute: true),
                    LibraryFoldersPageRoute(isSubRoute: true),
                    ExploreMusicCategoryPageRoute(),
                  ],
                ),
              ],
            );
          }),
        ),
        DesktopSplashScreenRoute(),
      ],
    );
  }

  static void init(
    String initialLocation,
    InitialAppPage initialAppPage, [
    TabsState? tabsState,
  ]) {
    _tabsModeEnabled = tabsState != null;
    _initialAppPage = initialAppPage;
    _instance = AppRouter._(
      _tabsModeEnabled
          ? _getRouterInstanceForTabsLayout(tabsState!, initialLocation)
          : GoRouter(
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
                        windowsChild: WideHomeScreen(navigationShell),
                      ),
                      responsiveBuilder: ResponsiveBuilder(
                        mobileChild: HomeScreen(navigationShell),
                        wideScreenChild: WideHomeScreen(navigationShell),
                      ),
                    ).of(context);
                  },
                  branches: _getBranches(),
                ),
                DesktopSplashScreenRoute(),
              ],
              debugLogDiagnostics: kIsDebug,
            ),
    );
  }

  /// Returns a list of shell branches sorted by their [QuickNavDestination].
  /// It's IMPORTANT  to sort the branches because we go to a specific branch
  /// by it's index in the branches list. so every branch must be in index of its
  /// [QuickNavDestination].
  static List<StatefulShellBranch> _getBranches() {
    final routes = [
      ExplorePageRoute(),
      ListeningHistoryPageRoute(),
      LibraryAlbumsPageRoute(),
      LibraryTracksPageRoute(),
      LibraryArtistsPageRoute(),
    ].sortedByCompare(
        (r) => r.index.destinationIndex, (a, b) => a.compareTo(b));
    return routes.map((route) => StatefulShellBranch(routes: [route])).toList();
  }

  static ({String name, String path}) getInitialAppPage(
    InitialPageOnStartup initialPageOnStartup,
  ) {
    return switch (initialPageOnStartup) {
      InitialPageOnStartup.exploreMusic => (
          path: RoutePath.explorePage,
          name: RouteName.explorePage
        ),
      InitialPageOnStartup.myLibrary => (
          path: RoutePath.libraryTracksPage,
          name: RouteName.libraryTracksPage
        ),
    };
  }

  static String get currentLocation => router.currentLocation;

  static void updateTabs(TabsState tabsState, String? initialLocation) {
    _instance = _instance._copyWith(
      router: _getRouterInstanceForTabsLayout(tabsState, initialLocation),
    );
  }

  AppRouter _copyWith({GoRouter? router}) {
    return AppRouter._(router ?? _router);
  }
}

extension GoRouterExtension on GoRouter {
  String get currentLocation {
    final RouteMatch lastMatch = routerDelegate.currentConfiguration.last;
    final RouteMatchList matchList = lastMatch is ImperativeRouteMatch
        ? lastMatch.matches
        : routerDelegate.currentConfiguration;
    return matchList.uri.toString();
  }
}
