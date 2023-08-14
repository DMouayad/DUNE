import 'package:dune/presentation/pages/search_page/moods_genres_section.dart';
import 'package:dune/presentation/providers/state_controllers.dart';
import 'package:dune/presentation/providers/shared_providers.dart';
import 'package:dune/presentation/utils/search_helper.dart';
import 'package:dune/support/extensions/context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../pages/search_page/search_result_widgets/search_results_widget.dart';
import 'search_music_source_option_button.dart';

class FullScreenSearchBar extends ConsumerWidget with SearchHelper {
  const FullScreenSearchBar({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final searchController = ref.watch(materialSearchBarControllerProvider);
    final searchState = ref.watch(searchControllerProvider);
    return SearchAnchor.bar(
      constraints: BoxConstraints.loose(Size(context.screenWidth * .8, 40)),
      searchController: searchController,
      viewShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
      ),
      isFullScreen: false,
      viewConstraints: BoxConstraints.expand(
        width: context.screenWidth * .8,
        height: context.screenWidth * .7,
      ),
      viewTrailing: const [SearchMusicSourceOptionButton()],
      viewElevation: 3,
      barShape: MaterialStateProperty.resolveWith(
        (states) {
          return const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(8)),
          );
        },
      ),
      viewHintText: "Search",
      barElevation: MaterialStateProperty.all(0),
      barBackgroundColor: MaterialStateProperty.resolveWith((states) {
        final color = (context.isDarkMode ? Colors.white : Colors.black87);
        if (states.contains(MaterialState.hovered)) {
          return color.withOpacity(.04);
        }

        return color.withOpacity(.02);
      }),
      viewBackgroundColor: context.colorScheme.background,
      suggestionsBuilder: (context, controller) {
        if (controller.text != searchState.requireValue.query) {
          searchFor(controller.text, ref);
        }
        return [
          if (controller.text.isEmpty)
            const MoodsAndCategoriesSection()
          else
            const SearchResultsWidget(),
        ];
      },
    );
  }
}
