import 'package:dune/domain/app_preferences/base_app_preferences.dart';
import 'package:dune/dune_app.dart';
import 'package:dune/navigation/navigation.dart';
import 'package:dune/presentation/pages/listening_history_page/listening_history_page.dart';
import 'package:dune/support/helpers/dependencies_helper.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../utils/widget_test_helpers.dart';

void main() {
  const appPrefs = BaseAppPreferences(
    initialStartupDestination: QuickNavDestination.libraryAlbumsPage,
    sidePanelPinned: false,
  );
  setUpAll(() async => await registerDependenciesForWidgetTest(appPrefs));
  setUp(() => registerNavigationService(appPrefs));
  testWidgets(
    'it updates [NavigationHistory]',
    (widgetTester) async {
      await widgetTester.pumpWidget(const ProviderScope(child: DuneApp()));
      final initialRoute = AppNavigation.instance.currentLocation;

      // assert initial location was added to the history
      expect(
          AppNavigation.instance.history.currentLocation?.path, initialRoute);

      const locationB = RoutePath.listeningHistoryPage;
      const newLocationPageType = ListeningHistoryPage;

      // go to a new location
      AppNavigation.instance.currentRouter.go(locationB);
      await widgetTester.pump();
      expect(_isCurrentLocation(locationB), true);
      expect(find.byType(newLocationPageType), findsOneWidget);
      // Go to the previous route.
      AppNavigation.instance.onGoBack();
      await widgetTester.pump();
      // expect current page was popped
      expect(_isNextLocation(locationB), true);
      expect(_isCurrentLocation(locationB), false);
      expect(AppNavigation.instance.history.hasForward(), true);
      expect(find.byType(newLocationPageType), findsNothing);

      // Go forward
      AppNavigation.instance.onGoForward();
      await widgetTester.pump();
      expect(AppNavigation.instance.history.hasForward(), false);
      expect(_isCurrentLocation(locationB), true);

      // Again, go to the previous/initial route
      AppNavigation.instance.onGoBack();
      await widgetTester.pump();
      // assert next location is correct
      expect(_isNextLocation(locationB), true);
      expect(_isCurrentLocation(locationB), false);
      // Navigate to [locationB]
      // BUT without using [AppNavigation.instance.onGoForward()]
      // this simulates the user not using the backward/previous buttons
      AppNavigation.instance.currentRouter.go(locationB);
      await widgetTester.pump();
      // assert we navigated to [locationB]
      expect(AppNavigation.instance.history.hasForward(), false);
      expect(_isCurrentLocation(locationB), true);
      expect(find.byType(newLocationPageType), findsOneWidget);
    },
  );
}

bool _isCurrentLocation(String? path) {
  return AppNavigation.instance.history.currentLocation?.path == path;
}

bool _isNextLocation(String? path) {
  final nextLocation =
      AppNavigation.instance.history.getNextOfCurrentLocation();
  return nextLocation?.path == path;
}
