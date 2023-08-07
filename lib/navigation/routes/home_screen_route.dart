part of app_router;

abstract class BaseHomeScreenBodyRoute extends GoRoute {
  final HomeNavigationShellBranchIndex index;

  BaseHomeScreenBodyRoute({
    required super.path,
    required super.name,
    required this.index,
    required Widget Function(BuildContext context, GoRouterState state) page,
    List<GoRoute> routes = const [],
  }) : super(
          pageBuilder: (BuildContext context, GoRouterState state) {
            return _buildPageWithTransition(
              page(context, state),
              state.pageKey,
              context.theme.scaffoldBackgroundColor,
            );
          },
          routes: [PlaylistPageRoute(), ...routes],
        );
}

Page<void> _buildPageWithTransition(
  Widget page,
  LocalKey? pageKey,
  Color barrierColor,
) {
  return CustomTransitionPage<void>(
    key: pageKey,
    child: PageBodyWrapper(child: page),
    transitionDuration: const Duration(milliseconds: 1200),
    transitionsBuilder: (
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child,
    ) {
      return DrillInPageTransition(animation: animation, child: child);
      // return SlideTransition(
      //   position: Tween<Offset>(begin: const Offset(-.25, 0), end: Offset.zero)
      //       .chain(CurveTween(curve: Curves.easeOutQuad))
      //       .animate(animation),
      //   child: FadeTransition(
      //     opacity: CurveTween(curve: Curves.easeInOutCubic).animate(animation),
      //     child: child,
      //   ),
      // );
    },
  );
}

//
class ExplorePageRoute extends BaseHomeScreenBodyRoute {
  ExplorePageRoute()
      : super(
          index: HomeNavigationShellBranchIndex.explorePage,
          name: RouteName.explorePage,
          path: RoutePath.explorePage,
          page: (context, state) => const ExplorePage(),
        );
}

class SearchPageRoute extends BaseHomeScreenBodyRoute {
  SearchPageRoute()
      : super(
          index: HomeNavigationShellBranchIndex.searchPage,
          name: RouteName.searchPage,
          path: RoutePath.searchPage,
          page: (context, state) => const SearchPage(),
          routes: [ExploreMusicCategoryPageRoute()],
        );
}

class ListeningHistoryPageRoute extends BaseHomeScreenBodyRoute {
  ListeningHistoryPageRoute()
      : super(
          index: HomeNavigationShellBranchIndex.listeningHistoryPage,
          name: RouteName.listeningHistoryPage,
          path: RoutePath.listeningHistoryPage,
          page: (context, state) => const ListeningHistoryPage(),
        );
}

class LibraryPageRoute extends BaseHomeScreenBodyRoute {
  LibraryPageRoute()
      : super(
          index: HomeNavigationShellBranchIndex.libraryPage,
          name: RouteName.libraryPage,
          path: RoutePath.libraryPage,
          page: (context, state) => const LibraryPage(),
        );
}

class SettingsPageRoute extends BaseHomeScreenBodyRoute {
  SettingsPageRoute()
      : super(
          index: HomeNavigationShellBranchIndex.settingsPage,
          name: RouteName.settingsPage,
          path: RoutePath.settingsPage,
          page: (context, state) => const SettingsPage(),
        );
}
