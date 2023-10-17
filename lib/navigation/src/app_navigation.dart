import 'package:dune/domain/audio/base_models/base_album.dart';
import 'package:dune/domain/audio/base_models/base_artist.dart';
import 'package:dune/domain/audio/base_models/base_explore_music_collection.dart';
import 'package:dune/domain/audio/base_models/base_explore_music_item.dart';
import 'package:dune/domain/audio/base_models/base_playlist.dart';
import 'package:dune/domain/audio/base_models/base_track.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:collection/collection.dart';

//
import 'package:dune/support/logger_service.dart';
import 'package:dune/navigation/navigation.dart';

import 'helpers/go_router_helpers.dart';
import 'helpers/tabs_helper.dart';
import 'helpers/tabs_routers_helper.dart';

part 'helpers/navigation_history_helper.dart';

class AppNavigation with PagesNavigationHelper, _RouterChangeListener {
  late final GoRouter appRouter;
  late final TabsHelper? tabs;
  late final NavigationHistoryHelper _historyHelper;
  late final TabsRoutersHelper? tabsRouters;

  GoRouter get currentRouter =>
      tabsRouters != null ? tabsRouters!.currentRouter! : appRouter;

  /// The current navigation history.
  /// when [tabsEnabled],
  NavigationHistory get history => _historyHelper._state;

  String? get currentLocation => currentRouter.currentLocation;

  bool get tabsEnabled => tabs != null && tabsRouters != null;

  late final ValueNotifier<bool> hasPrevious;
  late final ValueNotifier<bool> hasForward;

  AppNavigation._({
    required Location initialLocation,
    required this.appRouter,
    required NavigationHistory navigationHistory,
    required TabsState? tabsState,
  }) {
    hasPrevious = ValueNotifier(navigationHistory.hasPrevious());
    hasForward = ValueNotifier(false);

    _historyHelper =
        NavigationHistoryHelper(navigationHistory, initialLocation);
    if (tabsState == null) {
      tabs = tabsRouters = null;
    } else {
      tabsRouters = TabsRoutersHelper(
          tabsState.selectedTab!.page.path, tabsState.selectedTabIndex);
      tabs = TabsHelper(
        tabsState,
        onTabReordered: (oldIndex, newIndex) {
          tabsRouters?.reorderRouters(oldIndex, newIndex);
          _historyHelper.reorderNavigationStack(oldIndex, newIndex);
        },
        onTabRemovedAt: (index) {
          _historyHelper.removeLocationGroupAt(index);
          tabsRouters?.removeRouterAt(index);
        },
        onSelectedTabIndexChanged: (index) {
          _historyHelper.updateCurrentLocationGroupIndex(index);
          tabsRouters?.updateCurrentRouterIndex(index);
        },
        onNewTabAdded: (tab) {
          _historyHelper.addNewGroup(
            tab.tabIndex,
            Location(name: tab.page.title, path: tab.page.path),
          );
          tabsRouters?.addNewRouter(tab.page.path);
        },
      );
    }
    _updateTabPageOnNavigationHistoryChanged();
    _addRoutersListeners();
  }

  void _addRoutersListeners() {
    // add a listener for [appRouter] or the first tab router in case of tabs mode.
    _addListenerToUpdateNavHistory(currentRouter, _historyHelper);

    if (tabsEnabled) {
      // add a listener for each new tab(GoRouter)
      tabsRouters?.notifier.addListener(() {
        for (var router in tabsRouters!.routers) {
          _addListenerToUpdateNavHistory(router, _historyHelper);
        }
      });
    }
  }

  void _updateTabPageOnNavigationHistoryChanged() {
    _historyHelper.addListener((state) {
      hasForward.value = state.hasForward();
      hasPrevious.value = state.hasPrevious();
      final currentLocation = state.currentLocation;
      if (currentLocation != null) {
        tabs?.updateSelectedTabPage(currentLocation.path, currentLocation.name);
      }
    });
  }

  /// Called when we want to go to a [QuickNavDestination]
  void onGoToQuickNavDestination(
    QuickNavDestination dest, [
    StatefulNavigationShell? navigationShell,
  ]) {
    if (tabsEnabled) {
      tabsRouters?.currentRouter?.go(dest.path);
    } else {
      assert(navigationShell != null);
      // it's important to notify the navigation history controller
      // with the change before actually navigation to the new
      // [StatefulBranch] so it'll be added to the correct
      // history stack
      _historyHelper.onCurrentStatefulBranchChanged(dest);
      final destinationIndex = dest.destinationIndex;
      if (navigationShell!.currentIndex == destinationIndex) return;
      // since we're not using a tabs-layout-router, we simply go
      // to the [StatefulShellBranch] at provided [index]
      navigationShell.goBranch(destinationIndex);
    }
  }

  void onGoBack() {
    if (currentRouter.canPop()) {
      _historyHelper.onPrevious();
      currentRouter.pop();
    } else {
      final previousLocation = history.getPreviousOfCurrentLocation();
      if (previousLocation != null) {
        // if any, go to current tab's last-visited-location
        _historyHelper.onPrevious();
        currentRouter.go(previousLocation.path, extra: previousLocation.extra);
      }
    }
  }

  void onGoForward() {
    if (_historyHelper._state.hasForward()) {
      final forwardLocation = _historyHelper.onForward();
      if (forwardLocation != null && forwardLocation.path != currentLocation) {
        currentRouter.go(forwardLocation.path, extra: forwardLocation.extra);
      }
    }
  }

  static late AppNavigation instance;

  static void registerInstance(
    QuickNavDestination initialDestination,
    TabsState? tabsState,
  ) {
    instance = AppNavigation._(
      initialLocation: Location(
        path: initialDestination.path,
        name: initialDestination.name,
      ),
      tabsState: tabsState,
      navigationHistory: AppNavigationUtils.getInitialNavigationHistory(
        tabsState,
        initialDestination,
      ),
      appRouter: tabsState != null
          ? GoRouterHelpers.getTabsAppRouter(initialDestination.path, tabsState)
          : GoRouterHelpers.getNoTabsAppRouter(initialDestination.path),
    );
  }
}

mixin _RouterChangeListener {
  final Set<int> _listenedToRouters = {};

  void _addListenerToUpdateNavHistory(
    GoRouter router,
    NavigationHistoryHelper historyHelper,
  ) {
    final routerKey = router.hashCode;
    if (_listenedToRouters.contains(routerKey)) return;

    _listenedToRouters.add(routerKey);
    router.routerDelegate.addListener(() {
      historyHelper.onRouterLocationChanged();
    });
    router.routeInformationProvider.addListener(() {
      historyHelper.onRouterLocationChanged();
    });
  }
}
