import 'package:dune/navigation/app_router.dart';
import 'package:dune/support/logger_service.dart';
import 'package:dune/support/extensions/extensions.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../screens/home/components/app_tab_view.dart';
import '../providers/shared_providers.dart';

final class AppTabViewHelper {
  /// when the tab changes:
  /// - check if the now-current tab is for a NavigationRail Destination and
  /// notify the provider [navigationRailSelectedIndex].
  ///
  /// - if the current tab is for a StatefulShellBranch's page, then update
  /// [homeNavigationShellBranchIndexProvider] state.
  static void onCurrentTabKeyChange(String? key, WidgetRef ref) {
    if (key == null) return;

    /// If the current tab is for a [BaseHomeScreenBodyRoute], then
    /// call [_getShellBranchIndexFromCurrentTab] to retrieve
    /// the [HomeNavigationShellBranchIndex] for this route's page.
    /// Or else it'll be null
    final shellBranchIndex = _getShellBranchIndexFromCurrentTab(key, ref);
    if (shellBranchIndex != null) {
      ref
          .read(homeNavigationShellBranchIndexProvider.notifier)
          .update((state) => shellBranchIndex);

      // if [shellBranchIndex] is for a NavigationRailDestination, then update
      // current selected destination.
      final index = HomeNavigationShellBranchIndex.navigationRailDestinations
          .indexWhere((element) => element == shellBranchIndex);
      // if it's not for a nav-rail-destination, then no destination is selected
      ref
          .read(navigationRailSelectedIndex.notifier)
          .update((state) => index != -1 ? index : null);
    } else {
      ref.read(navigationRailSelectedIndex.notifier).update((state) => null);
      ref
          .read(homeNavigationShellBranchIndexProvider.notifier)
          .update((state) => null);
    }
  }

  /// This helper function is used to determine the branch index of
  /// the current tab by its [tabKey]
  static HomeNavigationShellBranchIndex? _getShellBranchIndexFromCurrentTab(
    String tabKey,
    WidgetRef ref,
  ) {
    try {
      return HomeNavigationShellBranchIndex.values
          .firstWhereOrNull((e) => e.name == tabKey);
    } catch (e) {
      Log.e(e);
    }
    return null;
  }

  static void onCurrentHomeNavigationShellBranchIndexChange(
    HomeNavigationShellBranchIndex? index,
    WidgetRef ref,
  ) {
    final tabs = ref.watch(homeScreenTabsProvider);
    final destinationTab =
        tabs.firstWhereOrNull((e) => e.tabKey == index?.name);
    final destinationAlreadyInTabs = destinationTab != null;
    if (destinationAlreadyInTabs) {
      // update the current [TabView]'s index
      ref
          .read(selectedTapIndexProvider.notifier)
          .update((state) => tabs.indexOf(destinationTab));
    } else {
      final routeData = AppRouter.homeNavigationShellBranches[index];
      if (routeData != null) {
        // add a new [Tab] with for the destination page.
        ref.read(homeScreenTabsProvider.notifier).update((state) => [
              ...state,
              TabData(
                title: routeData.route.path.replaceAll('/', ''),
                body: routeData.page,
                tabKey: index!.name,
                type: TabContentType.other,
              ),
            ]);
        // update the current [TabView]'s index to the last tab
        ref
            .read(selectedTapIndexProvider.notifier)
            .update((state) => tabs.length);
      }
    }
  }

  static void onCloseTab(TabData e, WidgetRef ref) {
    final lastSelectedTabIndex = ref.watch(selectedTapIndexProvider);
    late final int newSelectedTabIndex;
    if (ref.watch(homeScreenTabsProvider).length == 1) {
      return;
    }
    ref.read(homeScreenTabsProvider.notifier).update((state) {
      final List<TabData> newTabs = List<TabData>.from(state);
      newTabs.remove(e);
      newSelectedTabIndex =
          _getNewIndexBasedOnLastSelectedOne(newTabs, lastSelectedTabIndex);
      return newTabs;
    });
    ref
        .read(selectedTapIndexProvider.notifier)
        .update((state) => newSelectedTabIndex);
  }

  static int _getNewIndexBasedOnLastSelectedOne(
    List<TabData> newTabs,
    int lastSelectedTabIndex,
  ) {
    // if it's the case where we only got one tab left (newTabs.length == 1)
    // then the new tab index is 0 since theres only one tab.
    // OR if it's the case where the last selectedIndex
    // is either (0 or 1) then the new tab index is also zero
    // (the first tab still the selected one).
    return newTabs.length == 1 || lastSelectedTabIndex < 1
        ? 0
        : lastSelectedTabIndex - 1;
  }

  static void addNewTab(TabData newTab, WidgetRef ref) {
    final tabs = ref.watch(homeScreenTabsProvider);
    final existingTab = tabs.firstWhereOrNull((e) => e.tabKey == newTab.tabKey);
    if (existingTab != null) {
      ref
          .read(selectedTapIndexProvider.notifier)
          .update((state) => tabs.indexOf(existingTab));
    } else {
      ref
          .read(homeScreenTabsProvider.notifier)
          .update((state) => [...state, newTab]);
      ref
          .read(selectedTapIndexProvider.notifier)
          .update((state) => ref.watch(homeScreenTabsProvider).length - 1);
    }
  }
}
