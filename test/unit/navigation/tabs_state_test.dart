import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:dune/navigation/navigation.dart';

import '../../utils/test_with_datasets.dart';

void main() {
  test('switching two tabs updates their indices', () {
    final firstTab = TabDataFactory().create(tabIndex: 0);
    final secondTab = TabDataFactory().create(tabIndex: 1);
    final initialState = TabsState(tabs: [firstTab, secondTab]);

    // act - switch between tabs
    final stateWithSwitchedTabs = initialState.withTabsSwitched(
      firstTab.tabIndex,
      secondTab.tabIndex,
    );
    // assert the tab at the previous [firstTab] index is now the [secondTab]
    // BUT with new index
    expect(
      stateWithSwitchedTabs.tabs.elementAt(firstTab.tabIndex),
      secondTab.withNewIndex(firstTab.tabIndex),
    );
    // the same for the other tab
    expect(
      stateWithSwitchedTabs.tabs.elementAt(secondTab.tabIndex),
      firstTab.withNewIndex(secondTab.tabIndex),
    );
  });

  group('updating [TabData.tabIndex]', () {
    const newIndex = 1;
    final initialTab = TabDataFactory().create(tabIndex: 0);
    late final TabData updatedTab;
    setUpAll(() => updatedTab = initialTab.withNewIndex(newIndex));

    test('it updates [tabIndex]', () => expect(updatedTab.tabIndex, newIndex));
    test('it DOESNT change tab page title', () {
      expect(updatedTab.page.title, initialTab.page.title);
    });
  });

  testWithDatasets<TabDataset>(
    'Adding new tab',
    datasets: [
      (initialySelectedTab: 0, initialTabsCount: 1, shouldSelectNewTab: true),
      (initialySelectedTab: 0, initialTabsCount: 1, shouldSelectNewTab: false),
      (initialySelectedTab: 1, initialTabsCount: 2, shouldSelectNewTab: true),
      (initialySelectedTab: 1, initialTabsCount: 2, shouldSelectNewTab: false),
    ],
    testBody: (data) {
      TabsState initialState = TabsState(
        selectedTabIndex: data.initialySelectedTab,
        tabs: TabDataFactory().createMany(data.initialTabsCount),
      );
      final newTab = TabDataFactory()
          .create(tabIndex: initialState.selectedTab!.tabIndex + 1);
      TabsState updatedState = initialState.withTabAdded(
        newTab,
        selected: data.shouldSelectNewTab,
      );
      // it append the new [TabData] to [TabsState.tabs]
      expect(updatedState.tabsCount, initialState.tabsCount + 1);

      if (data.shouldSelectNewTab) {
        expect(updatedState.selectedTabIndex, newTab.tabIndex);
      } else {
        expect(updatedState.selectedTabIndex, initialState.selectedTabIndex);
      }
    },
  );
  testWithDatasets<TabDataset>(
    'Removing a tab',
    datasets: [
      (initialySelectedTab: 0, initialTabsCount: 1, shouldSelectNewTab: true),
      (initialySelectedTab: 0, initialTabsCount: 1, shouldSelectNewTab: false),
      (initialySelectedTab: 1, initialTabsCount: 2, shouldSelectNewTab: true),
      (initialySelectedTab: 1, initialTabsCount: 2, shouldSelectNewTab: false),
    ],
    testBody: (data) {
      TabsState initialState = TabsState(
        selectedTabIndex: data.initialySelectedTab,
        tabs: TabDataFactory().createMany(data.initialTabsCount),
      );
      final newTab = TabDataFactory()
          .create(tabIndex: initialState.selectedTab!.tabIndex + 1);
      // act
      TabsState updatedState = initialState.withTabAdded(
        newTab,
        selected: data.shouldSelectNewTab,
      );
      // assert it appended the new [TabData] to [TabsState.tabs]
      expect(updatedState.tabsCount, initialState.tabsCount + 1);

      if (data.shouldSelectNewTab) {
        expect(updatedState.selectedTabIndex, newTab.tabIndex);
      } else {
        expect(updatedState.selectedTabIndex, initialState.selectedTabIndex);
      }
    },
  );
  group('Updating selected tab current page', () {
    test('it updates [TabData.page]', () {
      final initState = TabsState(
        selectedTabIndex: 0,
        tabs: [TabDataFactory().create(tabIndex: 0)],
      );
      final newPage = TabPageFactory().create();
      // act
      final updatedState = initState.withCurrentPageUpdated(
        path: newPage.path,
        title: newPage.title,
      );
      // assert
      expect(updatedState.selectedTab?.page, newPage);
    });
  });
}

typedef TabDataset = ({
  int initialySelectedTab,
  int initialTabsCount,
  bool shouldSelectNewTab,
});

class TabDataFactory {
  TabDataFactory();

  List<TabData> createMany(int count) {
    return List.generate(count, (index) => create(tabIndex: index));
  }

  TabData create({
    required int tabIndex,
    String? currentTitle,
    String? currentPath,
  }) {
    return TabData(
      tabIndex: tabIndex,
      page: TabPageFactory().create(path: currentPath, title: currentTitle),
    );
  }
}

class TabPageFactory {
  TabPageFactory();

  TabPage create({String? path, String? title}) {
    return (
      title: title ?? faker.lorem.word(),
      path: path ?? faker.lorem.sentence(),
    );
  }
}
