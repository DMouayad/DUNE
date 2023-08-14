import 'package:dune/presentation/pages/search_page/search_result_widgets/search_results_widget.dart';
import 'package:dune/presentation/providers/shared_providers.dart';
import 'package:dune/presentation/providers/state_controllers.dart';
import 'package:dune/presentation/utils/search_helper.dart';
import 'package:dune/support/extensions/context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'search_music_source_option_button.dart';

class SearchIconButton extends ConsumerWidget with SearchHelper {
  const SearchIconButton({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final searchState = ref.watch(searchControllerProvider);

    return SearchAnchor(
      searchController: ref.read(materialSearchBarControllerProvider),
      viewShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      isFullScreen: true,
      viewTrailing: const [SearchMusicSourceOptionButton()],
      viewElevation: 0,
      viewHintText: "Search",
      viewBackgroundColor: context.colorScheme.background,
      suggestionsBuilder: (context, controller) {
        if (controller.text != searchState.requireValue.query) {
          searchFor(controller.text, ref);
        }
        return [
          if (controller.text.isEmpty)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Start typing to search...",
                style: context.textTheme.bodySmall,
              ),
            )
          else
            const SearchResultsWidget(),
        ];
      },
      builder: (BuildContext context, SearchController controller) {
        return IconButton(
          onPressed: () => controller.openView(),
          icon: Icon(Icons.search, color: context.colorScheme.secondary),
        );
      },
    );
  }
}
