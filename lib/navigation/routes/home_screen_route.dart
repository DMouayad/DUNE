part of app_router;

abstract class BaseHomeScreenBodyRoute extends GoRoute {
  final QuickNavigationDestination index;

  BaseHomeScreenBodyRoute({
    required String path,
    super.name,
    required this.index,
    bool isSubRoute = false,
    required Widget Function(BuildContext context, GoRouterState state) page,
    List<GoRoute> routes = const [],
  }) : super(
          path: isSubRoute ? path.replaceFirst('/', '') : path,
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
    // transitionDuration: const Duration(milliseconds: 600),
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
  ExplorePageRoute({
    super.name,
    super.isSubRoute,
    super.routes,
  }) : super(
          index: QuickNavigationDestination.explorePage,
          path: RoutePath.explorePage,
          page: (context, state) => const ExplorePage(),
        );
}

class ListeningHistoryPageRoute extends BaseHomeScreenBodyRoute {
  ListeningHistoryPageRoute({
    super.name,
    super.isSubRoute,
    super.routes,
  }) : super(
          index: QuickNavigationDestination.listeningHistoryPage,
          path: RoutePath.listeningHistoryPage,
          page: (context, state) => const ListeningHistoryPage(),
        );
}

class LibraryPageRoute extends BaseHomeScreenBodyRoute {
  LibraryPageRoute({
    super.name,
    super.isSubRoute,
    super.routes,
  }) : super(
          index: QuickNavigationDestination.libraryPage,
          path: RoutePath.libraryPage,
          page: (context, state) => const LibraryPage(),
        );
}

class SettingsPageRoute extends BaseHomeScreenBodyRoute {
  SettingsPageRoute({
    super.name,
    super.isSubRoute,
    super.routes,
  }) : super(
          index: QuickNavigationDestination.settingsPage,
          path: RoutePath.settingsPage,
          page: (context, state) => const SettingsPage(),
        );
}
