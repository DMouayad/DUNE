import 'package:dune/domain/audio/base_models/base_playlist.dart';
import 'package:dune/domain/audio/base_models/base_track.dart';
import 'package:dune/domain/audio/base_models/thumbnails_set.dart';
import 'package:dune/presentation/controllers/base_item_controller.dart';
import 'package:dune/presentation/controllers/selection_controller.dart';
import 'package:dune/presentation/custom_widgets/persistent_page_header.dart';
import 'package:dune/presentation/custom_widgets/tracks_list_view.dart';
import 'package:dune/presentation/providers/shared_providers.dart';
import 'package:dune/support/enums/music_source.dart';
import 'package:dune/support/extensions/context_extensions.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BaseItemWithTracksPage<ItemType extends Object>
    extends ConsumerStatefulWidget {
  final String itemId;
  final String? title;
  final String? description;
  final String? tracksCount;
  final ThumbnailsSet? thumbnails;
  final MusicSource? musicSource;
  final StateNotifierProvider<BaseItemPageController<ItemType>,
      AsyncValue<ItemType?>> itemControllerProvider;
  final String? Function(ItemType? item) idFromItem;
  final String? Function(ItemType? item) titleFromItem;
  final String? Function(ItemType? item) descriptionFromItem;
  final List<BaseTrack> Function(ItemType? item) tracksFromItem;
  final ThumbnailsSet? Function(ItemType? item) thumbnailsFromItem;

  const BaseItemWithTracksPage({
    Key? key,
    required this.itemId,
    required this.musicSource,
    required this.itemControllerProvider,
    required this.idFromItem,
    required this.titleFromItem,
    required this.descriptionFromItem,
    required this.tracksFromItem,
    required this.thumbnailsFromItem,
    this.title,
    this.description,
    this.tracksCount,
    this.thumbnails,
  }) : super(key: key);

  @override
  ConsumerState<BaseItemWithTracksPage> createState() =>
      _BaseItemWithTracksPageState<ItemType>();
}

class _BaseItemWithTracksPageState<ItemType extends Object>
    extends ConsumerState<BaseItemWithTracksPage<ItemType>>
    with AutomaticKeepAliveClientMixin<BaseItemWithTracksPage<ItemType>> {
  AsyncValue<ItemType?> itemState = const AsyncValue.loading();
  ItemType? item;

  /// Handles selection actions for this [item] tracks.
  ///
  /// Each [BaseItemWithTracksPage] has its [selectionController] in case we got multiple
  /// pages opened in different tabs.
  late final selectionController = TracksSelectionControllerProvider(
    (ref) => SelectionController<BaseTrack>(
      SelectionState.initial(itemToString: (track) => track.title),
    ),
  );

  @override
  Widget build(BuildContext context) {
    super.build(context);

    if (ref.watch(widget.itemControllerProvider).hasError) {
      itemState = ref.watch(widget.itemControllerProvider);
      item = null;
      updateKeepAlive();
    }
    if (ref.watch(widget.itemControllerProvider).hasValue) {
      final newItem = ref.watch(widget.itemControllerProvider).value;
      if (newItem != null && widget.idFromItem(newItem) == widget.itemId) {
        itemState = ref.watch(widget.itemControllerProvider);
        item = itemState.value;
        updateKeepAlive();
      }
    }

    final maxHeight = context.screenWidth > 500
        ? context.screenHeight * 0.27
        : context.screenHeight * 0.23;
    return CustomScrollView(
      primary: true,
      slivers: [
        SliverPersistentHeader(
          pinned: true,
          delegate: PersistentPageHeaderDelegate<BaseTrack>(
            minHeaderExtent: 70,
            maxHeaderExtent: maxHeight,
            isFetchingItems: itemState.hasValue && itemState.isLoading,
            title: widget.title ?? widget.titleFromItem(item) ?? '',
            description:
                widget.description ?? widget.descriptionFromItem(item) ?? '',
            thumbnailsSet: widget.thumbnails ?? widget.thumbnailsFromItem(item),
            itemsCount: (widget.tracksCount != null
                    ? int.tryParse(widget.tracksCount!)
                    : null) ??
                widget.tracksFromItem(item).length,
            onShuffle: itemState.valueOrNull != null ? () {} : null,
            selectionController: ref.read(selectionController.notifier),
            selectionState: ref.watch(selectionController),
            onSelectAll: () => selectionController.onSelectAllTracks(
                ref, widget.tracksFromItem(item)),
            trailingPositionBuilder: (headerMinimized, child) {
              return AnimatedPositioned(
                duration: const Duration(milliseconds: 150),
                bottom: headerMinimized ? 4 : 20,
                right: 0,
                left: 0,
                child: child,
              );
            },
          ),
        ),
        TracksListView(
          itemState.whenData((data) => widget.tracksFromItem(data)),
          isSliverList: true,
          physics: const NeverScrollableScrollPhysics(),
          selectionControllerProvider: selectionController,
          playlist: ItemType == BasePlaylist
              ? (itemState as AsyncValue<BasePlaylist?>)
                  .whenData((value) => value)
                  .valueOrNull
              : null,
          onRetryWhenErrorLoadingTracks: () {
            if (widget.musicSource != null) {
              ref
                  .read(widget.itemControllerProvider.notifier)
                  .get(widget.itemId, widget.musicSource!);
            }
          },
        ),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
