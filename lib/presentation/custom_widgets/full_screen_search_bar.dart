import 'package:dune/presentation/providers/state_controllers.dart';
import 'package:dune/presentation/providers/shared_providers.dart';
import 'package:dune/support/enums/music_source.dart';
import 'package:dune/support/extensions/context_extensions.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:fluent_ui/fluent_ui.dart' as fluent;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../pages/search_page/search_result_widgets/search_results_widget.dart';

class FullScreenSearchBar extends ConsumerWidget {
  const FullScreenSearchBar({
    super.key,
    required this.parentSize,
  });

  final Size parentSize;

  @override
  Widget build(BuildContext context, ref) {
    final searchController = ref.watch(materialSearchBarControllerProvider);
    final searchState = ref.watch(searchControllerProvider);
    final acrylicEffectEnabled =
        ref.watch(appThemeControllerProvider).acrylicWindowEffectEnabled;
    final tabsModeEnabled = ref.watch(appPreferencesController).tabsModeEnabled;
    return tabsModeEnabled
        ? SearchAnchor(
            searchController: searchController,
            viewShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            isFullScreen: false,
            viewConstraints: BoxConstraints.expand(
              width: parentSize.width,
              height: parentSize.height,
            ),
            viewTrailing: const [_SearchMusicSourceOptionButton()],
            viewElevation: 0,
            viewHintText: "Search",
            viewBackgroundColor: context.colorScheme.background,
            suggestionsBuilder: (context, controller) {
              if (controller.text != searchState.requireValue.query) {
                _searchFor(controller.text, ref);
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
          )
        : SearchAnchor.bar(
            searchController: searchController,
            viewShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            isFullScreen: false,
            viewConstraints: BoxConstraints.expand(
              width: parentSize.width,
              height: parentSize.height,
            ),
            viewTrailing: const [_SearchMusicSourceOptionButton()],
            viewElevation: 0,
            barShape: MaterialStateProperty.resolveWith(
              (states) {
                return RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: BorderSide(color: context.colorScheme.surfaceVariant),
                );
              },
            ),
            viewHintText: "Search",
            barElevation: MaterialStateProperty.all(0),
            barBackgroundColor: MaterialStateProperty.resolveWith((states) {
              if (states.contains(MaterialState.hovered)) {
                return context.colorScheme.secondaryContainer.withOpacity(.2);
              }

              return acrylicEffectEnabled
                  ? context.colorScheme.background.withOpacity(.2)
                  : context.colorScheme.background;
            }),
            viewBackgroundColor: context.colorScheme.background,
            suggestionsBuilder: (context, controller) {
              if (controller.text != searchState.requireValue.query) {
                _searchFor(controller.text, ref);
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
          );
  }

  void _searchFor(String text, WidgetRef ref) {
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

class _SearchMusicSourceOptionButton extends ConsumerWidget {
  const _SearchMusicSourceOptionButton();

  @override
  Widget build(BuildContext context, ref) {
    return SizedBox(
      height: 38,
      child: fluent.ComboBox<MusicSource>(
        selectedItemBuilder: (context) {
          return MusicSource.values
              .map(
                (e) => Text(
                  'on: ${e.name}',
                  style: context.textTheme.titleSmall?.copyWith(),
                ),
              )
              .toList();
        },
        value: ref.watch(searchBarMusicSourceFilterProvider),
        onChanged: (value) {
          ref
              .read(searchBarMusicSourceFilterProvider.notifier)
              .update((state) => value!);
        },
        items: MusicSource.valuesWithoutUnknown
            .map(
              (e) => fluent.ComboBoxItem<MusicSource>(
                  value: e,
                  child: Text(
                    e.name,
                    style: context.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  )),
            )
            .toList(),
      ),
    );
  }
}
