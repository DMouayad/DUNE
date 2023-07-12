import 'dart:math';

import 'package:dune/domain/audio/base_models/base_explore_music_collection.dart';
import 'package:dune/domain/audio/base_models/base_explore_music_item.dart';
import 'package:dune/presentation/custom_widgets/error_widget.dart';
import 'package:dune/presentation/custom_widgets/explore_music_collection_widget.dart';
import 'package:dune/presentation/providers/state_controllers.dart';
import 'package:dune/presentation/providers/shared_providers.dart';
import 'package:dune/presentation/utils/navigation_helper.dart';
import 'package:dune/support/extensions/context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MoodsAndCategoriesSection extends ConsumerStatefulWidget {
  const MoodsAndCategoriesSection({Key? key}) : super(key: key);

  @override
  MoodsAndCategoriesSectionState createState() =>
      MoodsAndCategoriesSectionState();
}

class MoodsAndCategoriesSectionState
    extends ConsumerState<MoodsAndCategoriesSection> {
  /// contains a [ScrollController] for each collection in `collections` list.
  List<ScrollController> _listViewControllers = [];

  @override
  void dispose() {
    for (var c in _listViewControllers) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final exploreMusicState = ref.watch(exploreMusicControllerProvider);

    final isLoading = exploreMusicState.isLoading;
    List<BaseExploreMusicCollection> collections = [];
    if (!isLoading && exploreMusicState.hasValue) {
      collections = exploreMusicState.requireValue.moodsAndGenresCollections;
      _listViewControllers =
          List.generate(collections.length, (index) => ScrollController());
    }
    if (exploreMusicState.hasError && !exploreMusicState.isLoading) {
      return Center(
        child: DuneErrorWidget(
          exploreMusicState.error,
          onRetry: () {
            ref
                .read(exploreMusicControllerProvider.notifier)
                .loadMoodsAndGenresCollections(
                    ref.watch(searchBarMusicSourceFilterProvider));
          },
        ),
      );
    } else {
      return Theme(
        data: ref.watch(appThemeControllerProvider).materialThemeData,
        child: ListView.builder(
          padding: const EdgeInsets.symmetric(vertical: 20),
          shrinkWrap: true,
          itemCount: isLoading ? 2 : collections.length,
          itemBuilder: (BuildContext context, int index) {
            return ExploreMusicCollectionWidget(
              displayAsGrid: true,
              height: min(200, context.screenHeight * .3),
              itemWidth: 130,
              collection: isLoading
                  ? const AsyncValue.loading()
                  : AsyncValue.data(collections[index]),
              scrollController: isLoading ? null : _listViewControllers[index],
              childBuilder: (width, item) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: Material(
                    color: context.colorScheme.secondaryContainer,
                    borderRadius: BorderRadius.circular(2),
                    child: InkWell(
                      hoverColor: context.colorScheme.primaryContainer,
                      borderRadius: BorderRadius.circular(2),
                      onTap: () => _onTap(item, context),
                      child: SizedBox(
                        width: width,
                        child: Center(
                          child: Text(
                            item.title,
                            textAlign: TextAlign.center,
                            style: context.textTheme.titleMedium?.copyWith(
                              color: context.colorScheme.secondary,
                              fontFamily: 'baloo2',
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      );
    }
  }

  void _onTap(BaseExploreMusicItem item, BuildContext context) {
    NavigationHelper.onExploreMusicCategoryCardPressed(
      context,
      ref,
      exploreItem: item,
    );
    if (ref.watch(materialSearchBarControllerProvider).isOpen) {
      ref.watch(materialSearchBarControllerProvider).closeView('');
    }
  }
}
