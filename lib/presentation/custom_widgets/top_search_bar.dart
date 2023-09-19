import 'package:dune/presentation/pages/search_page/moods_genres_section.dart';
import 'package:dune/presentation/providers/state_controllers.dart';
import 'package:dune/presentation/providers/shared_providers.dart';
import 'package:dune/presentation/utils/search_helper.dart';
import 'package:dune/support/extensions/context_extensions.dart';
import 'package:dune/support/themes/theme_constants.dart';
import 'package:fluent_ui/fluent_ui.dart' as fluent;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../pages/search_page/search_result_widgets/search_results_widget.dart';
import 'search_music_source_option_button.dart';

class TopSearchBar extends ConsumerWidget with SearchHelper {
  const TopSearchBar({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final searchController = ref.watch(materialSearchBarControllerProvider);
    final searchState = ref.watch(searchControllerProvider);
    return SearchAnchor.bar(
      barLeading: Icon(
        fluent.FluentIcons.search,
        size: 18,
        color: context.colorScheme.secondary,
      ),
      searchController: searchController,
      viewShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
      ),
      isFullScreen: false,
      viewConstraints: BoxConstraints.expand(
        width: context.screenWidth * .6,
        height: context.screenHeight * .8,
      ),
      viewTrailing: const [SearchMusicSourceOptionButton()],
      viewElevation: 20,
      barShape: MaterialStateProperty.resolveWith(
        (states) {
          return const RoundedRectangleBorder(
            borderRadius: kBorderRadius,
          );
        },
      ),
      viewHintText: "Search",
      barElevation: MaterialStateProperty.all(0),
      barBackgroundColor: MaterialStateProperty.resolveWith((states) {
        return context.colorScheme.background;
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
