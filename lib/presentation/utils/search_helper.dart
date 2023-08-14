import 'package:dune/presentation/providers/shared_providers.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/state_controllers.dart';

mixin SearchHelper {
  void searchFor(String text, WidgetRef ref) {
    final source = ref.watch(searchBarMusicSourceFilterProvider);
    EasyDebounce.debounce('search', const Duration(milliseconds: 600), () {
      if (text.trim().isEmpty) {
        EasyDebounce.cancel('search');
        ref.read(searchControllerProvider.notifier).clearSearchState();
      } else {
        ref
            .read(searchControllerProvider.notifier)
            .getSearchResults(text, source);
      }
    });
  }
}
