import 'package:dune/navigation/navigation.dart';
import 'package:flutter/material.dart';

/// A helper class responsible for managing(updating) the app's [TabsState].
/// Changes can be listened to using the [stateNotifier].
/// For Listening to a specific change, use a callback defined in constructor.
class TabsHelper {
  final void Function(int oldIndex, int newIndex) onTabReordered;
  final void Function(int index) onTabRemovedAt;
  final void Function(int index) onSelectedTabIndexChanged;
  final void Function(TabData tab) onNewTabAdded;

  TabsHelper(
    TabsState initialState, {
    required this.onTabReordered,
    required this.onTabRemovedAt,
    required this.onSelectedTabIndexChanged,
    required this.onNewTabAdded,
  }) {
    stateNotifier = ValueNotifier(initialState);
  }

  late final ValueNotifier<TabsState> stateNotifier;

  TabsState get state => stateNotifier.value;

  void reorderTab(int oldIndex, int newIndex) {
    final movedToIndex =
        // NOTE: in some cases we need to check for [newIndex] value.
        newIndex == state.tabs.length ? newIndex - 1 : newIndex;
    final newIndexIsValid =
        movedToIndex < state.tabs.length && movedToIndex != oldIndex;
    if (newIndexIsValid) {
      stateNotifier.value = state
          .withTabsSwitched(oldIndex, movedToIndex)
          .withNewSelectedTab(movedToIndex);
      onTabReordered(oldIndex, movedToIndex);
      onSelectedTabIndexChanged(movedToIndex);
    }
  }

  void selectTabAt(int index) {
    if (state.selectedTabIndex != index) {
      stateNotifier.value = state.withNewSelectedTab(index);
      onSelectedTabIndexChanged(index);
    }
  }

  void addNewTab({TabPage? initialPage, bool selected = true}) {
    final newTab = initialPage != null
        ? TabData(page: initialPage, tabIndex: state.tabsCount)
        : TabData.withNewTab(tabIndex: state.tabsCount);
    // we call this b4 updating the state to acquire the current selected tab
    onNewTabAdded(newTab);
    onSelectedTabIndexChanged(
      selected ? newTab.tabIndex : state.selectedTabIndex,
    );
    stateNotifier.value = state.withTabAdded(newTab, selected: selected);
  }

  void removeTabAt(int index) {
    if (state.tabsCount < 2) return;
    stateNotifier.value = state.withTabRemoved(index);
    onTabRemovedAt(index);
    onSelectedTabIndexChanged(state.selectedTabIndex);
  }

  void updateSelectedTabPage(String path, [String? title]) {
    if (state.selectedTab?.page.path != path) {
      stateNotifier.value = state.withCurrentPageUpdated(
        path: path,
        title: title ?? _extractTitleFromPath(path),
      );
    }
  }

  String _extractTitleFromPath(String path) {
    final lastFrowardSlashIndex = path.lastIndexOf('/');
    return path.substring(lastFrowardSlashIndex + 1);
  }
}
