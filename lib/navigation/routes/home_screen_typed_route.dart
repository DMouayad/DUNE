// part of app_router;
//
// /// A shell route that contains all pages which can be displayed as the
// /// body of the [HomeScreen].
// ///
// /// Its pushed using a separate navigator and not by the app-level navigator.
// ///
// /// To navigate to/push a specific route, you can do the following:
// ///
// /// ``` example
// /// ExplorePageRouteData().go(context)
// /// or
// /// ExplorePageRouteData().push(context)
// /// ```
// @TypedShellRoute<HomeScreenRouteData>(routes: [
//   CustomHomePageTypedGoRoute<ExplorePageRouteData>(path: RoutePath.explorePage),
//   CustomHomePageTypedGoRoute<ListeningHistoryRouteData>(
//       path: RoutePath.listeningHistoryPage),
//   CustomHomePageTypedGoRoute<SearchPageRouteData>(path: RoutePath.searchPage),
//   TypedGoRoute<SettingsPageRouteData>(path: RoutePath.settingsPage),
//   CustomHomePageTypedGoRoute<LibraryPageRouteData>(path: RoutePath.libraryPage),
// ])
// @immutable
// class HomeScreenRouteData extends ShellRouteData {
//   const HomeScreenRouteData();
//
//   static final GlobalKey<NavigatorState> $navigatorKey =
//       AppRouter.homeScreenBodyNavigatorKey;
//
//   @override
//   Widget builder(BuildContext context, GoRouterState state, Widget navigator) {
//     return CustomBuilder(
//       defaultChild: HomeScreen(navigator),
//       mobileScreenChild: HomeScreen(navigator),
//       windowsChild: DesktopHomeScreen(body: navigator),
//       wideScreenChild: WideHomeScreen(navigator),
//     ).getCurrentContextChild(context);
//   }
// }
//
// @immutable
// abstract class BaseHomeScreenBodyRouteData extends GoRouteData {
//   final int index;
//   final String path;
//   final Widget page;
//   const BaseHomeScreenBodyRouteData(
//     this.index,
//     this.path,
//     this.page,
//   );
//   @override
//   Page<void> buildPage(BuildContext context, GoRouterState state) {
//     return _buildPageWithTransition(
//       // [PageBodyWrapper] is used for all home screen pages. so we get a
//       // consistent UI.
//       PageBodyWrapper(child: page),
//       state.pageKey,
//       context.theme.scaffoldBackgroundColor,
//     );
//   }
// }
//
// class ExplorePageRouteData extends BaseHomeScreenBodyRouteData {
//   const ExplorePageRouteData()
//       : super(HomeScreenPagesIndex.explorePage, RoutePath.explorePage,
//             const ExplorePage());
// }
//
// class SearchPageRouteData extends BaseHomeScreenBodyRouteData {
//   const SearchPageRouteData()
//       : super(HomeScreenPagesIndex.searchPage, RoutePath.searchPage,
//             const SearchPage());
// }
//
// class ListeningHistoryRouteData extends BaseHomeScreenBodyRouteData {
//   const ListeningHistoryRouteData()
//       : super(HomeScreenPagesIndex.listeningHistoryPage,
//             RoutePath.listeningHistoryPage, const ListeningHistoryPage());
// }
//
// class LibraryPageRouteData extends BaseHomeScreenBodyRouteData {
//   const LibraryPageRouteData()
//       : super(HomeScreenPagesIndex.libraryPage, RoutePath.libraryPage,
//             const SizedBox());
// }
//
// class SettingsPageRouteData extends BaseHomeScreenBodyRouteData {
//   const SettingsPageRouteData()
//       : super(HomeScreenPagesIndex.settingsPage, RoutePath.settingsPage,
//             const SettingsPage());
// }
//
// Page<void> _buildPageWithTransition(
//   Widget page,
//   LocalKey? pageKey,
//   Color barrierColor,
// ) {
//   return CustomTransitionPage<void>(
//     key: pageKey,
//     child: page,
//     transitionDuration: const Duration(milliseconds: 300),
//     transitionsBuilder: (
//       BuildContext context,
//       Animation<double> animation,
//       Animation<double> secondaryAnimation,
//       Widget child,
//     ) {
//       return SlideTransition(
//         position: Tween<Offset>(begin: const Offset(-.25, 0), end: Offset.zero)
//             .chain(CurveTween(curve: Curves.easeOutQuad))
//             .animate(animation),
//         child: FadeTransition(
//           opacity: CurveTween(curve: Curves.easeInOutCubic).animate(animation),
//           child: child,
//         ),
//       );
//     },
//   );
// }
//
// class CustomHomePageTypedGoRoute<T extends GoRouteData>
//     extends TypedGoRoute<T> {
//   const CustomHomePageTypedGoRoute({required super.path})
//       : super(
//           routes: const [
//             TypedGoRoute<PlaylistPageRouteData>(path: 'playlist/:playlistId'),
//           ],
//         );
// }
