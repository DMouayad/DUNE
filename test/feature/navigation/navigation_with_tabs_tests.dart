import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//
import 'package:dune/presentation/pages/library_page/library_albums_page.dart';
import 'package:dune/presentation/screens/home/components/side_panel/new_vertical_tab_button.dart';
import 'package:dune/presentation/pages/listening_history_page/listening_history_page.dart';
import 'package:dune/presentation/screens/home/wide_home_screen_with_tabs.dart';
import 'package:dune/presentation/screens/home/components/horizontal_tabs_bar.dart';
import 'package:dune/presentation/screens/home/components/side_panel/vertical_tabs_list.dart';
import 'package:dune/domain/app_preferences/base_app_preferences.dart';
import 'package:dune/navigation/navigation.dart';
import 'package:dune/dune_app.dart';
import 'package:dune/support/helpers/dependencies_helper.dart';

import '../../utils/widget_test_helpers.dart';

/* This is an integration test for navigating to different pages with
 tabs enabled.
 */
void main() {
  const initialRoutePageType = ListeningHistoryPage;
  const appPrefs = BaseAppPreferences(
    tabsMode: TabsMode.vertical,
    initialStartupDestination: QuickNavDestination.listeningHistoryPage,
    autoHideWideScreenAppBarButtons: false,
    // always set to [false], when it's [true] tests fails due to [RenderFlex]
    // exceptions.
    sidePanelPinned: false,
  );
  setUpAll(() async => await registerDependenciesForWidgetTest(appPrefs));
  setUp(() => registerNavigationService(appPrefs));

  testWidgets(
    'it navigates to correct initial route & display correct home screen',
    (widgetTester) async {
      await widgetTester.pumpWidget(const ProviderScope(child: DuneApp()));
      await widgetTester.pumpAndSettle(const Duration(milliseconds: 600));

      expect(
        AppNavigation.instance.currentLocation,
        appPrefs.initialStartupDestination.path,
      );
      expect(AppNavigation.instance.tabsEnabled, appPrefs.tabsMode.isEnabled);

      // assert not [WideHomeScreenWithTabs]
      expect(find.byType(WideHomeScreenWithTabs), findsOneWidget);

      // assert it shows a matching Widget with [appPrefs.initialStartupDestination]
      expect(find.byType(ListeningHistoryPage), findsOneWidget);

      expect(find.byType(VerticalTabsList),
          appPrefs.tabsMode.isVertical ? findsOneWidget : findsNothing);
      expect(find.byType(HorizontalTabsBar),
          appPrefs.tabsMode.isHorizontal ? findsOneWidget : findsNothing);
    },
    variant: TargetPlatformVariant.only(TargetPlatform.windows),
  );
  //TODO:: FIX THIS TEST WHEN TABS ARE ENABLED
  // testNavigatingUsingQuickNavSection(panelIsNotPinned: true);
  //
  testWidgets(
    'in each tab, it navigates to the specified route',
    (widgetTester) async {
      await widgetTester.pumpWidget(const ProviderScope(child: DuneApp()));
      // add new tab
      await widgetTester.tap(find.byType(NewVerticalTabButton));
      await widgetTester.pump();

      // assert we're in the new tab
      expect(AppNavigation.instance.currentLocation, RoutePath.newTabPage);

      // navigate to a new route
      const newRoutePageType = LibraryAlbumsPage;
      AppNavigation.instance.currentRouter.go(RoutePath.libraryAlbumsPage);
      await widgetTester.pump();

      expect(
          AppNavigation.instance.currentLocation, RoutePath.libraryAlbumsPage);
      expect(find.byType(newRoutePageType), findsOneWidget);

      // select the previous tab
      await widgetTester.tap(find.byType(VerticalTab).first);
      await widgetTester.pump();
      // assert the first-tab-route has not been changed
      expect(find.byType(initialRoutePageType), findsOneWidget);
      expect(
        AppNavigation.instance.currentLocation,
        appPrefs.initialStartupDestination.path,
      );
    },
    variant: const TargetPlatformVariant(
        {TargetPlatform.windows, TargetPlatform.android}),
  );
  testWidgets(
    'Adding & removing tabs',
    (widgetTester) async {
      await widgetTester.pumpWidget(const ProviderScope(child: DuneApp()));
      await widgetTester.pumpAndSettle();

      // assert, initially, we have one [LocationGroup]
      expect(AppNavigation.instance.history.groupsCount, 1);
      // assert current location is the initial destination
      expect(
        AppNavigation.instance.history.currentLocation?.path,
        appPrefs.initialStartupDestination.path,
      );
      //
      await widgetTester.tap(find.byType(NewVerticalTabButton));
      await widgetTester.pump();
      // assert a new [LocationGroup] was created for the new tab
      expect(AppNavigation.instance.history.groupsCount, 2);
      // assert current location was updated
      expect(
        AppNavigation.instance.history.currentLocation?.path,
        RoutePath.newTabPage,
      );
      expect(find.byType(VerticalTab), findsNWidgets(2));
    },
    variant: const TargetPlatformVariant(
        {TargetPlatform.windows, TargetPlatform.android}),
  );
}
