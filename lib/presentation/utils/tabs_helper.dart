import 'package:dune/presentation/providers/shared_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TabsHelper {
  static void onTabsReorder(int oldIndex, int newIndex, WidgetRef ref) {
    final tabsState = ref.watch(tabsStateProvider);
    final movedToIndex =
        newIndex == tabsState.tabs.length ? newIndex - 1 : newIndex;
    if (movedToIndex < tabsState.tabs.length && movedToIndex != oldIndex) {
      ref.read(tabsStateProvider.notifier).state =
          tabsState.withTabsSwitched(oldIndex, movedToIndex);
    }
  }
}
