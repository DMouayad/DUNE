import 'package:dune/support/logger_service.dart';

final class TabsState {
  final int selectedTabIndex;
  final List<TabData> tabs;
  final List<int> pinnedTabs;

  TabsState({
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

  TabsState withTabRemoved(int index) {
    if (tabsCount == 1) return this;

    tabs.removeAt(index);
    final newSelectedTabIndex = _getNewIndex();
    return _copyWith(
      selectedTabIndex: newSelectedTabIndex,
      tabs: List<TabData>.from(tabs),
    );
  }

  TabsState withTabAdded(TabData tabData) {
    final newTabIndex = selectedTabIndex + 1;
    final updatedTabs = List<TabData>.from(tabs);
    updatedTabs.add(tabData);
    return _copyWith(selectedTabIndex: newTabIndex, tabs: updatedTabs);
  }

  int _getNewIndex() {
    // if it's the case where we only got one tab left (newTabs.length == 1)
    // then the new tab index is 0 since theres only one tab.
    // OR if it's the case where the last selectedIndex
    // is either (0 or 1) then the new tab index is also zero
    // (the first tab still the selected one).
    return tabsCount == 1 || selectedTabIndex < 1 ? 0 : selectedTabIndex - 1;
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
}

typedef TabPageData = ({String path, String title});

final class TabData {
  final int tabIndex;
  final List<TabPageData> pages;
  final int selectedPageIndex;

  TabPageData? get selectedPage =>
      pages.isEmpty ? null : pages.elementAt(selectedPageIndex);

  TabData({
    List<TabPageData> pages = const [],
    required this.tabIndex,
    this.selectedPageIndex = 0,
  }) : pages = <TabPageData>{
          (path: '/tabs/$tabIndex', title: 'New tab'),
          ...pages
        }.toList();

  TabData copyWithPageAdded({
    required String path,
    required String title,
  }) {
    return _copyWith(
      selectedPageIndex: selectedPageIndex + 1,
      pages: <TabPageData>{(path: path, title: title), ...pages}.toList(),
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
}
