import 'package:dune/domain/audio/base_models/base_album.dart';
import 'package:dune/presentation/controllers/base_paged_items_controller.dart';
import 'package:dune/presentation/controllers/library_controllers.dart';
import 'package:dune/presentation/controllers/selection_controller.dart';
import 'package:dune/presentation/custom_widgets/album_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import 'library_items_page.dart';

final _selectionControllerProvider = StateNotifierProvider<
    SelectionController<BaseAlbum>, SelectionState<BaseAlbum>>(
  (ref) => SelectionController<BaseAlbum>(
    SelectionState.initial(itemToString: (album) => album.title),
  ),
);
final _albumsControllerProvider = StateNotifierProvider<
    LocalLibraryAlbumsController,
    QueryOptionsPagedState<BaseAlbum>>((ref) => LocalLibraryAlbumsController());

class LibraryAlbumsPage extends ConsumerWidget {
  const LibraryAlbumsPage({super.key});

  @override
  Widget build(BuildContext context, ref) {
    return LibraryItemsPage<BaseAlbum, BaseAlbum>(
      pagedBuilder: (c, b) => PagedSliverGrid(
        pagingController: c,
        builderDelegate: b,
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          crossAxisSpacing: 10,
          mainAxisExtent: 230,
          mainAxisSpacing: 10,
        ),
      ),
      title: 'Library albums',
      selectionControllerProvider: _selectionControllerProvider,
      itemsControllerProvider: _albumsControllerProvider,
      onSelectAll: () => _onSelectAll(ref),
      itemBuilder: (context, item, index) {
        return AlbumCard.selectable(
          album: item,
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
                  .watch(_albumsControllerProvider)
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
