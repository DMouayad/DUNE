import 'package:dune/domain/audio/base_models/base_album.dart';
import 'package:dune/presentation/custom_widgets/custom_card.dart';
import 'package:dune/presentation/custom_widgets/placeholders.dart';
import 'package:dune/presentation/custom_widgets/scrollable_cards_view.dart';
import 'package:dune/presentation/providers/state_controllers.dart';
import 'package:dune/support/extensions/context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'listening_history_date_section.dart';

class AlbumsListeningHistoryTab extends ConsumerWidget {
  const AlbumsListeningHistoryTab({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final listeningHistoryState = ref
        .watch(listeningHistoryControllerProvider)
        .whenData(
            (value) => value.where((history) => history.albums.isNotEmpty));
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
            itemExtent: 360.0,
            scrollDirection: Axis.vertical,
            itemCount: listeningHistoryState.isLoading
                ? 1
                : listeningHistoryState.valueOrNull?.length ?? 0,
            itemBuilder: (BuildContext context, int index) {
              return _AlbumsGridView(
                listeningHistoryState.map(
                  data: (state) =>
                      AsyncData(state.value.elementAt(index).albums),
                  error: (state) =>
                      AsyncValue.error(state.error, state.stackTrace),
                  loading: (_) => const AsyncValue.loading(),
                ),
                listeningHistoryState
                    .whenData((value) => value.elementAt(index).date),
              );
            },
          );
  }
}

class _AlbumsGridView extends ConsumerStatefulWidget {
  const _AlbumsGridView(this.albums, this.date);

  final AsyncValue<List<BaseAlbum>> albums;
  final AsyncValue<DateTime> date;

  @override
  ConsumerState<_AlbumsGridView> createState() => _AlbumsGridViewState();
}

class _AlbumsGridViewState extends ConsumerState<_AlbumsGridView> {
  late final scrollController = ScrollController();

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScrollableCardsView(
      scrollController: scrollController,
      titleWidget: widget.date.hasValue && widget.albums.hasValue
          ? ListeningHistoryDateSectionHeader(
              date: widget.date.requireValue,
              trailing: _contentDescription(widget.albums.requireValue),
              alignment: MainAxisAlignment.start,
            )
          : null,
      itemsState: widget.albums.map(
        data: (s) => AsyncData((itemCount: s.requireValue.length, title: null)),
        error: (s) => AsyncError(s.error, s.stackTrace),
        loading: (state) => const AsyncLoading(),
      ),
      childBuilder: (double cardWidth, int index) {
        final album = widget.albums.value!.elementAt(index);
        return CustomCard(
          tag: album.id ?? album.title,
          thumbnails: album.thumbnails,
          width: cardWidth,
          thumbImagePlaceholder: const AlbumCoverPlaceholder(),
          title: album.title,
          subtitle: album.artists.map((e) => e.name).join(", "),
          shape: BoxShape.rectangle,
          onTap: () {
            // NavigationHelper.onPlaylistItemCardPressed(
            //   context,
            //   ref,
            //   playlist: playlist,
            // );
          },
        );
      },
    );
  }

  String _contentDescription(List albums) {
    return '(${albums.length} ${albums.length > 1 ? 'albums' : 'album'})';
  }
}
