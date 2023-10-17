import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

//
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meta/meta.dart';
import 'package:fluent_ui/fluent_ui.dart' as fluent;

//
import 'package:dune/dune_app.dart';
import 'package:dune/navigation/navigation.dart';
import 'package:dune/presentation/pages/library_page/library_tracks_page.dart';
import 'package:dune/presentation/pages/listening_history_page/listening_history_page.dart';
import 'package:dune/presentation/screens/home/components/side_panel/library_dropdown_button.dart';
import 'package:dune/presentation/screens/home/components/side_panel/quick_nav_section.dart';
import 'package:dune/presentation/screens/home/components/side_panel/wide_app_bar_buttons.dart';

@isTest
void testNavigatingUsingQuickNavSection({bool panelIsNotPinned = false}) {
  testWidgets(
    'on pressing an item linked with a [QuickNavDestination], it navigates to the destination path',
    (widgetTester) async {
      await widgetTester.pumpWidget(const ProviderScope(child: DuneApp()));
      await widgetTester.pumpAndSettle(const Duration(milliseconds: 600));
      if (panelIsNotPinned) {
        // pin panel
        await widgetTester.tap(
          find.widgetWithIcon(AppBarIconButton, fluent.FluentIcons.side_panel),
        );
        await widgetTester.pumpAndSettle();
      }
      // Expand dropdown button
      await widgetTester.tap(find.byType(LibraryDropdownButton));
      await widgetTester.pumpAndSettle();

      const destination = QuickNavDestination.libraryTracksPage;
      const destinationPageType = LibraryTracksPage;

      await widgetTester.tap(find.widgetWithText(ListTile, 'Tracks'));
      await widgetTester.pump();

      expect(find.byType(destinationPageType), findsOneWidget);
      expect(AppNavigation.instance.currentLocation, destination.path);

      // Press another item with a new [QuickNavDestination].
      const secondDest = QuickNavDestination.listeningHistoryPage;
      const secondDestinationPageType = ListeningHistoryPage;

      await widgetTester.tap(
        find.widgetWithText(QuickNavDestinationButton, secondDest.title),
      );
      await widgetTester.pump();

      expect(find.byType(secondDestinationPageType), findsOneWidget);
      expectLater(AppNavigation.instance.currentLocation, secondDest.path);
    },
  );
}
