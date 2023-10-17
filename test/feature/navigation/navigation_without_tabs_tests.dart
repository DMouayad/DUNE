import 'package:dune/support/helpers/dependencies_helper.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//
import 'package:dune/domain/app_preferences/base_app_preferences.dart';
import 'package:dune/dune_app.dart';
import 'package:dune/navigation/navigation.dart';
import 'package:dune/presentation/pages/explore_page/explore_page.dart';
import 'package:dune/presentation/screens/home/components/horizontal_tabs_bar.dart';
import 'package:dune/presentation/screens/home/components/side_panel/vertical_tabs_list.dart';
import 'package:dune/presentation/screens/home/wide_home_screen.dart';

import '../../utils/widget_test_helpers.dart';
import 'common_tests.dart';

/* This is an integration test for navigating to different pages with
 tabs disabled.
 */
void main() {
  const appPrefs = BaseAppPreferences(
    tabsMode: TabsMode.disabled,
    initialStartupDestination: QuickNavDestination.explorePage,
    sidePanelPinned: true,
  );
  setUpAll(() async => await registerDependenciesForWidgetTest(appPrefs));
  setUp(() => registerNavigationService(appPrefs));

  testWidgets(
      'it navigates to correct initial route & display correct home screen',
      (widgetTester) async {
    await widgetTester.pumpWidget(const ProviderScope(child: DuneApp()));
    expect(
      AppNavigation.instance.currentLocation,
      appPrefs.initialStartupDestination.path,
    );
    expect(AppNavigation.instance.tabsEnabled, false);
    // assert not [WideHomeScreenWithTabs]
    expect(find.byType(WideHomeScreen), findsOneWidget);
    // assert it shows matching Widget with [appPrefs.initialStartupDestination]
    expect(find.byType(ExplorePage), findsOneWidget);
    expect(find.byType(VerticalTabsList), findsNothing);
    expect(find.byType(HorizontalTabsBar), findsNothing);
  });
  testNavigatingUsingQuickNavSection();
}
