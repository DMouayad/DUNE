import 'package:dune/navigation/tabs_state.dart';
import 'package:dune/support/extensions/extensions.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('switching two tabs updates their indices', () {
    final firstTab = TabDataFactory().create(tabIndex: 0);
    final secondTab = TabDataFactory().create(tabIndex: 1, pagesCount: 3);
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
  group('updating tab index', () {
    const newIndex = 1;
    final initialTab = TabDataFactory().create(tabIndex: 0, pagesCount: 4);
    late final TabData updatedTab;
    setUpAll(() => updatedTab = initialTab.withNewIndex(newIndex));

    test('it updates [tabIndex]', () => expect(updatedTab.tabIndex, newIndex));
    test('it DOESNT change tab page title or index', () {
      for (var page in updatedTab.pages) {
        final initialTabPage =
            initialTab.pages.firstWhereOrNull((e) => e.index == page.index)!;
        expect(page.title, initialTabPage.title);
        expect(page.index, initialTabPage.index);
      }
    });
    test('it updates the index in the pages path', () {
      for (var page in updatedTab.pages) {
        final initialTabPage =
            initialTab.pages.firstWhereOrNull((e) => e.index == page.index)!;
        expect(
          page.path,
          initialTabPage.path.replaceAll('${initialTab.tabIndex}', '$newIndex'),
        );
      }
    });
  });
}

class TabDataFactory {
  TabDataFactory();

  List<TabData> createMany(int count) {
    return List.generate(count, (index) => create(tabIndex: index));
  }

  TabData create(
      {required int tabIndex, int pagesCount = 1, selectedPage = 0}) {
    return TabData(
      tabIndex: tabIndex,
      selectedPageIndex: selectedPage,
      pages: List.generate(
        pagesCount,
        (index) => (
          index: index,
          title: 'new page ($index)',
          path: 'tabs/$tabIndex/page$index',
        ),
      ),
    );
  }
}
