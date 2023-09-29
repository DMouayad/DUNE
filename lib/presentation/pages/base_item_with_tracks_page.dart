import 'package:dune/domain/audio/base_models/base_album.dart';
import 'package:dune/domain/audio/base_models/base_artist.dart';
import 'package:dune/domain/audio/base_models/base_explore_music_item.dart';
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

typedef ItemWithTracksControllerProvider<ItemType extends Object>
    = StateNotifierProvider<BaseItemPageController<ItemType>,
        AsyncValue<ItemType?>>;

class BaseItemWithTracksPage<ItemType extends Object>
    extends ConsumerStatefulWidget {
  final ItemType item;
  final ItemWithTracksControllerProvider<ItemType> itemControllerProvider;

  const BaseItemWithTracksPage({
    Key? key,
    required this.item,
    required this.itemControllerProvider,
  }) : super(key: key);

  @override
  ConsumerState<BaseItemWithTracksPage> createState() =>
      _BaseItemWithTracksPageState<ItemType>();
}

class _BaseItemWithTracksPageState<ItemType extends Object>
    extends ConsumerState<BaseItemWithTracksPage<ItemType>>
    with AutomaticKeepAliveClientMixin<BaseItemWithTracksPage<ItemType>> {
  AsyncValue<ItemType?> itemState = const AsyncData(null);
  late ItemWithTracks itemData;

  @override
  void initState() {
    itemData = ItemWithTracks.from(widget.item);
    super.initState();
  }

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
    if (itemData.tracks.isEmpty &&
        !ref.watch(widget.itemControllerProvider).isLoading) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        ref
            .read(widget.itemControllerProvider.notifier)
            .get(itemData.id, itemData.musicSource);
      });
    }
    if (ref.watch(widget.itemControllerProvider).hasError) {
      itemState = ref.watch(widget.itemControllerProvider);
      updateKeepAlive();
    }
    if (ref.watch(widget.itemControllerProvider).hasValue) {
      final newItemData = ItemWithTracks.tryFrom(
          ref.watch(widget.itemControllerProvider).requireValue);

      if (newItemData != null && newItemData.id == itemData.id) {
        itemState = ref.watch(widget.itemControllerProvider);
        itemData = newItemData;
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
            title: itemData.title ?? '',
            description: itemData.description,
            thumbnailsSet: itemData.thumbnails,
            itemsCount: (itemData.tracksCount != null
                    ? int.tryParse(itemData.tracksCount!)
                    : null) ??
                itemData.tracks.length,
            onShuffle: itemState.valueOrNull != null ? () {} : null,
            selectionController: ref.read(selectionController.notifier),
            selectionState: ref.watch(selectionController),
            onSelectAll: () =>
                selectionController.onSelectAllTracks(ref, itemData.tracks),
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
          itemState.whenData((data) => itemData.tracks),
          isSliverList: true,
          physics: const NeverScrollableScrollPhysics(),
          selectionControllerProvider: selectionController,
          playlist: ItemType == BasePlaylist
              ? (itemState as AsyncValue<BasePlaylist?>)
                  .whenData((value) => value)
                  .valueOrNull
              : null,
          onRetryWhenErrorLoadingTracks: () {
            ref
                .read(widget.itemControllerProvider.notifier)
                .get(itemData.id, itemData.musicSource);
          },
        ),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class ItemWithTracks {
  final String id;
  final String? title;
  final String? tracksCount;
  final String? description;
  final ThumbnailsSet? thumbnails;
  final List<BaseTrack> tracks;
  final MusicSource musicSource;

  const ItemWithTracks({
    required this.id,
    required this.title,
    required this.musicSource,
    this.tracks = const [],
    this.description,
    this.tracksCount,
    this.thumbnails = const ThumbnailsSet(),
  });

  static ItemWithTracks? tryFrom(Object? object) {
    if (object == null) return null;
    return from(object);
  }

  static ItemWithTracks from(Object object) {
    if (object is BasePlaylist) {
      return ItemWithTracks(
        id: object.id!,
        title: object.title ?? '',
        description: object.description,
        thumbnails: object.thumbnails,
        tracks: object.tracks,
        musicSource: object.musicSource,
      );
    }
    if (object is BaseArtist) {
      return ItemWithTracks(
        id: object.id!,
        title: object.name,
        description: object.description,
        thumbnails: object.thumbnails,
        tracks: object.tracks,
        musicSource: object.musicSource,
      );
    }
    if (object is BaseAlbum) {
      return ItemWithTracks(
        id: object.id!,
        title: object.title,
        thumbnails: object.thumbnails,
        tracks: object.tracks,
        musicSource: object.musicSource,
      );
    }
    if (object is BaseExploreMusicItem) {
      return ItemWithTracks(
        id: object.sourceId,
        title: object.title,
        thumbnails: object.thumbnails,
        tracks: [],
        musicSource: object.source,
        tracksCount: object.count,
      );
    }
    throw UnimplementedError();
  }
}
