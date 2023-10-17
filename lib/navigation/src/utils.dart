import 'package:go_router/go_router.dart';
import 'package:dune/navigation/navigation.dart';

extension GoRouterExtension on GoRouter {
  String? get currentLocation {
    if (routerDelegate.currentConfiguration.isEmpty) return null;
    final RouteMatch lastMatch = routerDelegate.currentConfiguration.last;
    final RouteMatchList matchList = lastMatch is ImperativeRouteMatch
        ? lastMatch.matches
        : routerDelegate.currentConfiguration;
    return matchList.uri.toString();
  }
}

class AppNavigationUtils {
  static TabsState getInitialTabsState(QuickNavDestination startupDestination) {
    return TabsState(tabs: [
      TabData.withNewTab(tabIndex: 0).withNewPage(
        path: startupDestination.path,
        title: startupDestination.title,
      ),
    ]);
  }

  static NavigationHistory getInitialNavigationHistory(
    TabsState? initialTabsState,
    QuickNavDestination initialDestination,
  ) {
    final tabsEnabled = initialTabsState != null;
    final initGroupIndex =
        tabsEnabled ? 0 : initialDestination.destinationIndex;

    return NavigationHistory(
      initialGroupIndex: initGroupIndex,
      groups: LocationGroups.fromEntries(
        [
          MapEntry(
            initGroupIndex,
            LocationGroup(
              currentLocationIndex: tabsEnabled ? 1 : 0,
              locations: <Location>[
                if (tabsEnabled)
                  Location(
                    path: RoutePath.newTabPage,
                    name: RouteName.newTabPage,
                  ),
                _locationFromDestination(initialDestination),
              ],
            ),
          )
        ],
      ),
    );
  }

  static Location _locationFromDestination(QuickNavDestination dest) {
    return Location(path: dest.path, name: dest.title);
  }
}
