import 'package:dune/domain/audio/base_models/base_artist.dart';
import 'package:dune/presentation/controllers/base_paged_items_controller.dart';
import 'package:dune/presentation/controllers/library_controllers.dart';
import 'package:dune/presentation/controllers/selection_controller.dart';
import 'package:dune/presentation/custom_widgets/artist_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import 'library_items_page.dart';

final _selectionControllerProvider = StateNotifierProvider<
    SelectionController<BaseArtist>, SelectionState<BaseArtist>>(
  (ref) => SelectionController<BaseArtist>(
    SelectionState.initial(itemToString: (artist) => artist.name ?? ''),
  ),
);
final _artistsControllerProvider = StateNotifierProvider<
        LocalLibraryArtistsController, QueryOptionsPagedState<BaseArtist>>(
    (ref) => LocalLibraryArtistsController());

class LibraryArtistsPage extends ConsumerWidget {
  const LibraryArtistsPage({super.key});

  @override
  Widget build(BuildContext context, ref) {
    return LibraryItemsPage<BaseArtist>(
      pagedBuilder: (c, b) => PagedSliverGrid(
        pagingController: c,
        builderDelegate: b,
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 190,
          crossAxisSpacing: 10,
          mainAxisExtent: 210,
          mainAxisSpacing: 10,
        ),
        showNoMoreItemsIndicatorAsGridChild: false,
      ),
      title: 'Library artists',
      selectionControllerProvider: _selectionControllerProvider,
      itemsControllerProvider: _artistsControllerProvider,
      onSelectAll: () => _onSelectAll(ref),
      itemBuilder: (context, item, index) {
        return ArtistCard.selectable(
          artist: item,
          selectionState: ref.watch(_selectionControllerProvider),
          onSelected: (selectionKey) => ref
              .read(_selectionControllerProvider.notifier)
              .toggleSelectionForItem(selectionKey, item),
        );
      },
    );
  }

  void _onSelectAll(WidgetRef ref) {
    ref.read(_selectionControllerProvider.notifier).selectAll(
          Map.fromEntries(ref
                  .watch(_artistsControllerProvider)
                  .records
                  ?.asMap()
                  .entries
                  .map((entry) => MapEntry(
                        entry.value.id ?? entry.key.toString(),
                        entry.value,
                      )) ??
              []),
        );
  }
}
