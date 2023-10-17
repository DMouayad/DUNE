import 'package:dune/domain/app_preferences/base_app_preferences.dart';
import 'package:dune/dune_app.dart';
import 'package:dune/navigation/navigation.dart';
import 'package:dune/presentation/custom_widgets/new_tab_page.dart';
import 'package:dune/presentation/screens/home/components/side_panel/new_vertical_tab_button.dart';
import 'package:dune/presentation/screens/home/components/side_panel/vertical_tabs_list.dart';
import 'package:dune/presentation/utils/constants.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../utils/widget_test_helpers.dart';

void main() {
  const appPrefs = BaseAppPreferences(
    tabsMode: TabsMode.vertical,
    initialStartupDestination: QuickNavDestination.listeningHistoryPage,
    sidePanelPinned: true,
  );
  setUpAll(() async => await registerDependenciesForWidgetTest(appPrefs));
  testWidgets('Adding a new tab', (widgetTester) async {
    await widgetTester.pumpWidget(const ProviderScope(child: DuneApp()));
    await widgetTester.pumpAndSettle(const Duration(seconds: 1));

    // assert initially, we have one tab with the correct title
    expect(
      find.widgetWithText(
        VerticalTab,
        appPrefs.initialStartupDestination.title,
      ),
      findsOneWidget,
    );

    // add a new tab
    await widgetTester.tap(find.byType(NewVerticalTabButton));
    await widgetTester.pumpAndSettle();
    // assert it displays the new tab body.
    expect(find.byType(NewTabPage), findsOneWidget);
    expect(
        find.widgetWithText(VerticalTab, RouteName.newTabPage), findsOneWidget);
    // assert, in total, we have now 2 tabs.
    expect(find.byType(VerticalTab), findsNWidgets(2));

    // re-order tabs.
    await widgetTester.drag(
      find.byType(VerticalTab).last,
      const Offset(0, kVerticalTabHeight + 10),
    );
    await widgetTester.pumpAndSettle();
    expect(
      find.widgetWithText(VerticalTab, RouteName.newTabPage).first,
      findsOneWidget,
    );
  });
}
