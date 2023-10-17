import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

///
final class TabsState extends Equatable {
  final int selectedTabIndex;
  final List<TabData> tabs;
  final List<int> pinnedTabs;

  const TabsState({
    this.selectedTabIndex = 0,
    this.pinnedTabs = const [],
    required this.tabs,
  });

  int get tabsCount => tabs.length;

  TabData? get selectedTab => tabs.isEmpty ? null : tabs[selectedTabIndex];

  @override
  String toString() {
    return 'TabsState{selectedTabIndex: $selectedTabIndex, tabs: $tabs, pinnedTabs: $pinnedTabs}';
  }

  TabsState withTabRemoved(int index) {
    if (tabsCount == 1) return this;
    return _copyWith(
      selectedTabIndex: _getNewSelectedIndex(),
      tabs: _tabsWithRemovedAt(index),
    );
  }

  List<TabData> _tabsWithRemovedAt(int index) {
    final newTabs = List<TabData>.from(tabs);
    newTabs.removeAt(index);
    return _decreaseTabsIndices(newTabs);
  }

  List<TabData> _decreaseTabsIndices(List<TabData> tabs) {
    return tabs
        .map((e) => e.withNewIndex(e.tabIndex < 1 ? 0 : e.tabIndex - 1))
        .toList();
  }

  int _getNewSelectedIndex() {
    // if it's the case where we only got one tab left (newTabs.length == 1)
    // then the new tab index is 0 since theres only one tab.
    // OR if it's the case where the currently selectedIndex
    // is either (0 or 1) then the new tab index is also zero
    // (the first tab still the selected one).
    return tabsCount == 1 || selectedTabIndex < 1 ? 0 : selectedTabIndex - 1;
  }

  /// Appends the given [tabData] to the current [tabs].
  /// if [selected] is true, [selectedTabIndex] will be set to [tabData.tabIndex].
  TabsState withTabAdded(TabData tabData, {bool selected = true}) {
    return _copyWith(
      selectedTabIndex: selected ? tabData.tabIndex : null,
      tabs: [...tabs, tabData],
    );
  }

  TabsState withNewSelectedTab(int index) {
    return _copyWith(selectedTabIndex: index);
  }

  TabsState pinTabAt(int index) {
    return _copyWith(pinnedTabs: {...pinnedTabs, index}.toList());
  }

  TabsState unpinTabAt(int index) {
    final updatedPinnedTabs = List<int>.from(pinnedTabs);
    updatedPinnedTabs.remove(index);
    return _copyWith(pinnedTabs: updatedPinnedTabs);
  }

  TabsState _copyWith({
    int? selectedTabIndex,
    List<TabData>? tabs,
    List<int>? pinnedTabs,
  }) {
    return TabsState(
      selectedTabIndex: selectedTabIndex ?? this.selectedTabIndex,
      tabs: tabs ?? this.tabs,
      pinnedTabs: pinnedTabs ?? this.pinnedTabs,
    );
  }

  TabsState withTabsSwitched(int firstIndex, int secondIndex) {
    final newTabAtFirstIndex =
        tabs.elementAt(secondIndex).withNewIndex(firstIndex);
    final newTabAtSecondIndex =
        tabs.elementAt(firstIndex).withNewIndex(secondIndex);
    final newTabs = List<TabData>.from(tabs);
    newTabs[firstIndex] = newTabAtFirstIndex;
    newTabs[secondIndex] = newTabAtSecondIndex;
    return _copyWith(tabs: newTabs);
  }

  /// Updates [selectedTab.page] with the given data.
  /// Returns a copy of this instance with
  TabsState withCurrentPageUpdated(
      {required String path, required String title}) {
    final updatedTab =
        tabs.removeAt(selectedTabIndex).withNewPage(path: path, title: title);
    tabs.insert(selectedTabIndex, updatedTab);
    return _copyWith(tabs: tabs);
  }

  @override
  List<Object?> get props => [tabs, selectedTabIndex, pinnedTabs];
}

typedef TabPage = ({String path, String title});

/// Holds the information about an opened tab.
final class TabData extends Equatable {
  final int tabIndex;
  final ValueNotifier<TabPage> pageNotifier;

  TabPage get page => pageNotifier.value;

  TabData({required TabPage page, required this.tabIndex})
      : pageNotifier = ValueNotifier(page);

  /// Creates an instance with a page that represents the [NewTab].
  factory TabData.withNewTab({required int tabIndex}) {
    return TabData(
      tabIndex: tabIndex,
      page: (path: RoutePath.newTabPage, title: RouteName.newTabPage),
    );
  }

  @override
  String toString() {
    return 'TabData{tabIndex: $tabIndex, page: $page}';
  }

  /// Returns a copy of this instance with its [page] updated.
  TabData withNewPage({required String path, required String title}) {
    pageNotifier.value = (path: path, title: title);
    return this;
  }

  /// Returns a copy of this instance with its [tabIndex] updated.
  TabData withNewIndex(int index) => _copyWith(tabIndex: index);

  TabData _copyWith({int? tabIndex}) {
    return TabData(
      tabIndex: tabIndex ?? this.tabIndex,
      page: page,
    );
  }

  @override
  List<Object?> get props => [page, tabIndex];
}
