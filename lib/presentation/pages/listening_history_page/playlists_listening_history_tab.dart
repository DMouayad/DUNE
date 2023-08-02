import 'package:dune/domain/audio/base_models/base_playlists_listening_history.dart';
import 'package:dune/presentation/custom_widgets/custom_card.dart';
import 'package:dune/presentation/custom_widgets/placeholders.dart';
import 'package:dune/presentation/custom_widgets/scrollable_cards_view.dart';
import 'package:dune/presentation/providers/state_controllers.dart';
import 'package:dune/presentation/utils/navigation_helper.dart';
import 'package:dune/support/extensions/context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'listening_history_date_section.dart';

class PlaylistsListeningHistoryTab extends ConsumerWidget {
  const PlaylistsListeningHistoryTab({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final listeningHistoryState = ref.watch(
      listeningHistoryControllerProvider.select((state) =>
          state.whenData((value) => value.playlistsListeningHistory)),
    );
    return (listeningHistoryState.valueOrNull?.isEmpty ?? false)
        ? Center(
            child: Text(
              "You haven't played any playlists recently...",
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
              return _PlaylistsGridView(
                listeningHistoryState.whenData(
                  (playlistsHistoriesMap) =>
                      playlistsHistoriesMap.values.elementAt(index),
                ),
              );
            },
          );
  }
}

class _PlaylistsGridView extends ConsumerStatefulWidget {
  const _PlaylistsGridView(this.playlistsInfo);

  final AsyncValue<BasePlaylistsListeningHistory> playlistsInfo;

  @override
  ConsumerState<_PlaylistsGridView> createState() => _PlaylistsGridViewState();
}

class _PlaylistsGridViewState extends ConsumerState<_PlaylistsGridView> {
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
      titleWidget: widget.playlistsInfo.hasValue
          ? ListeningHistoryDateSectionHeader(
              date: widget.playlistsInfo.requireValue.date,
              trailing:
                  _contentDescription(widget.playlistsInfo.requireValue.items),
              alignment: MainAxisAlignment.start,
            )
          : null,
      itemsState: widget.playlistsInfo.whenData(
        (data) => (itemCount: data.items.length, title: null),
      ),
      childBuilder: (double cardWidth, int index) {
        final playlist =
            widget.playlistsInfo.requireValue.items.elementAt(index);
        return CustomCard(
          width: cardWidth,
          tag: playlist.id ?? playlist.title!,
          thumbnails: playlist.thumbnails,
          title: playlist.title!,
          shape: BoxShape.rectangle,
          thumbImagePlaceholder: const PlaylistCoverPlaceholder(),
          onTap: () {
            NavigationHelper.onPlaylistItemCardPressed(
              context,
              ref,
              playlist: playlist,
            );
          },
        );
      },
    );
  }

  String _contentDescription(List playlists) {
    return '(${playlists.length} ${playlists.length > 1 ? 'playlists' : 'playlist'})';
  }
}
