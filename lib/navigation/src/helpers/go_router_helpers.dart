import 'package:go_router/go_router.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

//
import 'package:dune/navigation/navigation.dart';
import 'package:dune/presentation/screens/home/home_screen.dart';
import 'package:dune/presentation/screens/home/wide_home_screen.dart';
import 'package:dune/presentation/screens/home/wide_home_screen_with_tabs.dart';
import 'package:dune/support/context_builders/custom_builders.dart';
import 'package:dune/env.dart';

import '../models/custom_go_router.dart';

class GoRouterHelpers {
  static final GlobalKey<NavigatorState> _rootNavigatorKey =
      GlobalKey<NavigatorState>();

  static GoRouter getNoTabsAppRouter(String initialLocation) {
    return GoRouter(
      navigatorKey: _rootNavigatorKey,
      initialLocation: initialLocation,
      routes: [
        StatefulShellRoute.indexedStack(
          builder: (context, state, navigationShell) {
            return CustomBuilder<Widget>(
              adaptiveBuilder: AdaptiveBuilder(
                  windowsChild: WideHomeScreen(navigationShell)),
              responsiveBuilder: ResponsiveBuilder(
                mobileChild: HomeScreen(navigationShell),
                wideScreenChild: WideHomeScreen(navigationShell),
              ),
            ).of(context);
          },
          branches: _getBranches(),
        ),
      ],
      debugLogDiagnostics: kIsDebug,
    );
  }

  static GoRouter getTabsAppRouter(
    String initialLocation,
    TabsState tabsState,
  ) {
    return CustomGoRouter(
      debugLogDiagnostics: kIsDebug,
      navigatorKey: _rootNavigatorKey,
      initialLocation: RoutePath.tabsLayoutHome,
      routes: [
        GoRoute(
          path: RoutePath.tabsLayoutHome,
          name: 'Home',
          builder: (context, state) => const WideHomeScreenWithTabs(),
        ),
      ],
    );
  }

  /// Returns a list of shell branches sorted by their [QuickNavDestination].
  ///
  /// It's **IMPORTANT**  to sort the branches because we call [StatefulNavigationShell.goBranch()]
  /// with an index which is the route (index\position) in the branches list.
  /// so every branch must be at the position of its [QuickNavDestination.destinationIndex].
  static List<StatefulShellBranch> _getBranches() {
    final routes = [
      ExplorePageRoute(),
      ListeningHistoryPageRoute(),
      LibraryAlbumsPageRoute(),
      LibraryTracksPageRoute(),
      LibraryArtistsPageRoute(),
    ].sortedByCompare(
        (r) => r.index.destinationIndex, (a, b) => a.compareTo(b));
    return routes
        .map((route) => StatefulShellBranch(routes: [
              route,
              ExploreMusicCategoryPageRoute(),
              PlaylistPageRoute(),
              ArtistPageRoute(),
              AlbumPageRoute(),
            ]))
        .toList();
  }

  static GoRouter getCustomRouterInstance(String initialLocation) {
    return CustomGoRouter(
      debugLogDiagnostics: kIsDebug,
      initialLocation: initialLocation,
      routes: [
        NewTabPageRoute(),
        ExplorePageRoute(),
        ListeningHistoryPageRoute(),
        LibraryAlbumsPageRoute(),
        LibraryTracksPageRoute(),
        LibraryArtistsPageRoute(),
        LibraryFoldersPageRoute(),
        ExploreMusicCategoryPageRoute(),
        ArtistPageRoute(),
        AlbumPageRoute(),
        PlaylistPageRoute(),
      ],
    );
  }
}
