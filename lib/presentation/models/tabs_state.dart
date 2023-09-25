import 'package:dune/support/extensions/extensions.dart';
import 'package:dune/support/logger_service.dart';
import 'package:equatable/equatable.dart';

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

  TabsState withTabPageAdded({
    required int tabIndex,
    required String path,
    required String title,
    bool shouldSelectTab = true,
  }) {
    if (tabs.isEmpty || tabs.length <= tabIndex) {
      Log.f("You're trying to add a new page to a non-existing tab.\n"
          "Current tabs count: ${tabs.length}");
    }
    final updatedTab =
        tabs.removeAt(tabIndex).copyWithPageAdded(path: path, title: title);
    tabs.insert(tabIndex, updatedTab);
    return _copyWith(
      selectedTabIndex: shouldSelectTab ? tabIndex : null,
      tabs: tabs,
    );
  }

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

  TabsState withTabAdded(TabData tabData) {
    final newTabIndex = selectedTabIndex + 1;
    final updatedTabs = List<TabData>.from(tabs);
    updatedTabs.add(tabData);
    return _copyWith(selectedTabIndex: newTabIndex, tabs: updatedTabs);
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

  TabsState withPreviousPageSelected() {
    if (tabs.isEmpty ||
        tabs.elementAt(selectedTabIndex).selectedPageIndex == 0) {
      return this;
    }
    final updatedTab =
        tabs.removeAt(selectedTabIndex).copyWithPreviousPageSelected();
    tabs.insert(selectedTabIndex, updatedTab);
    return _copyWith(tabs: tabs);
  }

  @override
  List<Object?> get props => [tabs, selectedTabIndex, pinnedTabs];
}

typedef TabPageData = ({int index, String path, String title});

final class TabData extends Equatable {
  final int tabIndex;
  final List<TabPageData> pages;
  final int selectedPageIndex;

  TabPageData? get selectedPage => pages.isEmpty
      ? null
      : pages.firstWhereOrNull((p) => p.index == selectedPageIndex);

  const TabData({
    this.pages = const [],
    required this.tabIndex,
    this.selectedPageIndex = 0,
  });

  factory TabData.withEmptyPage({required int tabIndex}) {
    return TabData(
      tabIndex: tabIndex,
      pages: <TabPageData>[
        (index: 0, path: '/tabs/$tabIndex', title: 'New tab'),
      ],
    );
  }

  @override
  String toString() {
    return 'TabData{tabIndex: $tabIndex, pages: $pages, selectedPageIndex: $selectedPageIndex}';
  }

  TabData copyWithPageAdded({
    required String path,
    required String title,
  }) {
    final newPageIndex = pages.length;
    return _copyWith(
      selectedPageIndex: newPageIndex,
      pages: <TabPageData>{
        (index: newPageIndex, path: path, title: title),
        ...pages
      }.toList(),
    );
  }

  TabData _copyWith({
    int? tabIndex,
    List<TabPageData>? pages,
    int? selectedPageIndex,
  }) {
    return TabData(
      tabIndex: tabIndex ?? this.tabIndex,
      pages: pages ?? this.pages,
      selectedPageIndex: selectedPageIndex ?? this.selectedPageIndex,
    );
  }

  TabData copyWithPreviousPageSelected() {
    assert(selectedPageIndex - 1 >= 0,
        "You're already at the page with index (0)");
    return _copyWith(selectedPageIndex: selectedPageIndex - 1);
  }

  @override
  List<Object?> get props => [selectedPageIndex, pages, tabIndex];

  /// Returns a new [TabData] instance with the its index updated.
  /// **NOTE:** This also updates the index in every page path.
  TabData withNewIndex(int index) {
    return _copyWith(
      tabIndex: index,
      pages: pages
          .map((e) => (
                index: e.index,
                path: e.path.replaceAll('$tabIndex', '$index'),
                title: e.title,
              ))
          .toList(),
    );
  }
}
