import 'package:dune/domain/audio/base_models/base_album.dart';
import 'package:dune/presentation/controllers/selection_controller.dart';
import 'package:dune/presentation/custom_widgets/album_card.dart';
import 'package:dune/presentation/custom_widgets/scrollable_cards_view.dart';
import 'package:dune/presentation/providers/state_controllers.dart';
import 'package:dune/support/extensions/context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'listening_history_date_section.dart';

const _kCardHeight = 260.0;

class AlbumsListeningHistoryTab extends ConsumerWidget {
  const AlbumsListeningHistoryTab({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final listeningHistoryState = ref.watch(
      listeningHistoryControllerProvider.select(
          (state) => state.whenData((value) => value.albumsListeningHistory)),
    );

    return (listeningHistoryState.valueOrNull?.isEmpty ?? false)
        ? Center(
            child: Text(
              "You haven't played any albums recently...",
              style: context.textTheme.titleSmall?.copyWith(
                color: context.colorScheme.secondary,
              ),
            ),
          )
        : ListView.builder(
            itemExtent: _kCardHeight,
            scrollDirection: Axis.vertical,
            itemCount: listeningHistoryState.isLoading
                ? 1
                : listeningHistoryState.valueOrNull?.length ?? 0,
            itemBuilder: (BuildContext context, int index) {
              return _AlbumsGridView(
                listeningHistoryState.whenData(
                  (value) {
                    final entry = value.entries.elementAt(index);
                    return (date: entry.key, items: entry.value);
                  },
                ),
              );
            },
          );
  }
}

class _AlbumsGridView extends StatefulWidget {
  const _AlbumsGridView(this.albumsInfo);

  final AsyncValue<({DateTime date, List<BaseAlbum> items})> albumsInfo;

  @override
  State<_AlbumsGridView> createState() => _AlbumsGridViewState();
}

class _AlbumsGridViewState extends State<_AlbumsGridView> {
  late final ScrollController scrollController;
  late final selectionController = StateNotifierProvider<
      SelectionController<BaseAlbum>, SelectionState<BaseAlbum>>(
    (ref) => SelectionController(
      SelectionState.initial(itemToString: (album) => album.title),
    ),
  );

  @override
  void initState() {
    scrollController = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScrollableCardsView(
      itemWidth: 180,
      scrollController: scrollController,
      titleWidget: widget.albumsInfo.hasValue
          ? ListeningHistoryDateSectionHeader(
              date: widget.albumsInfo.requireValue.date,
              trailing:
                  _contentDescription(widget.albumsInfo.requireValue.items),
              alignment: MainAxisAlignment.start,
            )
          : null,
      itemsState: widget.albumsInfo.whenData(
        (value) => (itemCount: value.items.length, title: null),
      ),
      childBuilder: (double cardWidth, int index) {
        final album = widget.albumsInfo.value!.items.elementAt(index);
        return Consumer(builder: (context, ref, _) {
          return AlbumCard.selectable(
            album: album,
            selectionState: ref.watch(selectionController),
            onSelected: (selectionKey) => ref
                .read(selectionController.notifier)
                .toggleSelectionForItem(selectionKey, album),
          );
        });
      },
    );
  }

  String _contentDescription(List albums) {
    return '(${albums.length} ${albums.length > 1 ? 'albums' : 'album'})';
  }
}
