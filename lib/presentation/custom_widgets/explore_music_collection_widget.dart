import 'dart:math';

import 'package:dune/domain/audio/base_models/base_explore_music_collection.dart';
import 'package:dune/domain/audio/base_models/base_explore_music_item.dart';
import 'package:dune/presentation/providers/state_controllers.dart';
import 'package:dune/presentation/utils/navigation_helper.dart';
import 'package:dune/support/extensions/context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'custom_card.dart';
import 'scrollable_cards_view.dart';

class ExploreMusicCollectionWidget extends ConsumerWidget {
  const ExploreMusicCollectionWidget({
    required this.collection,
    required this.scrollController,
    super.key,
    this.childBuilder,
    this.height,
    this.itemWidth,
    this.displayAsGrid = false,
  });

  final AsyncValue<BaseExploreMusicCollection> collection;
  final ScrollController? scrollController;
  final Widget Function(double cardWidth, BaseExploreMusicItem item)?
      childBuilder;
  final double? height;
  final double? itemWidth;
  final bool displayAsGrid;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double itemCardWidth;
    if (itemWidth != null) {
      itemCardWidth = itemWidth!;
    } else {
      itemCardWidth = min(
          220.0, context.screenWidth * (context.screenWidth < 750 ? .5 : .3));
      if (collection.hasValue) {
        itemCardWidth = collection.requireValue.items.first.type.isPlaylist
            ? itemCardWidth - 30
            : (itemCardWidth - 30) * (16 / 9);
      }
    }
    return ScrollableCardsView(
      displayAsGrid: displayAsGrid,
      itemWidth: itemCardWidth,
      scrollController: scrollController,
      height: height,
      itemsState: collection.map(
        data: (data) => AsyncData(
          (itemCount: data.value.items.length, title: data.value.title),
        ),
        error: (errorState) =>
            AsyncValue.error(errorState.error, errorState.stackTrace),
        loading: (_) => const AsyncValue.loading(),
      ),
      childBuilder: (double cardWidth, int index) {
        final item = collection.requireValue.items[index];

        return childBuilder != null
            ? childBuilder!(itemCardWidth, item)
            : ExploreMusicItemCard(
                itemBoxWidth: itemCardWidth,
                item: item,
              );
      },
    );
  }
}

class ExploreMusicItemCard extends ConsumerWidget {
  final BaseExploreMusicItem item;
  final double itemBoxWidth;

  const ExploreMusicItemCard({
    super.key,
    required this.item,
    required this.itemBoxWidth,
  });

  @override
  Widget build(BuildContext context, ref) {
    return CustomCard(
      tag: item.title,
      cacheImage: true,
      width: itemBoxWidth,
      title: item.title,
      subtitle: item.type.isVideo
          ? '${item.count} | ${item.description}'
          : '${item.count} Tracks | ${item.description}',
      shape: BoxShape.rectangle,
      thumbnails: item.thumbnails!,
      onTap: () {
        if (item.type.isVideo) {
          if (item.track != null) {
            ref
                .read(playbackControllerProvider.notifier)
                .player
                .playSingleTrack(item.track!);
          }
        } else {
          NavigationHelper.onPlaylistItemCardPressed(
            context,
            ref,
            exploreItem: item,
          );
        }
      },
    );
  }
}
