import 'package:dune/domain/audio/base_models/base_playlist.dart';
import 'package:dune/presentation/custom_widgets/custom_card.dart';
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
    final listeningHistoryState = ref
        .watch(listeningHistoryControllerProvider)
        .whenData((value) =>
            value.takeWhile((history) => history.playlists.isNotEmpty));
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
                listeningHistoryState.map(
                  data: (state) =>
                      AsyncData(state.value.elementAt(index).playlists),
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

class _PlaylistsGridView extends ConsumerStatefulWidget {
  const _PlaylistsGridView(this.playlists, this.date);

  final AsyncValue<List<BasePlaylist>> playlists;
  final AsyncValue<DateTime> date;

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
      titleWidget: widget.date.hasValue && widget.playlists.hasValue
          ? ListeningHistoryDateSectionHeader(
              date: widget.date.requireValue,
              trailing: _contentDescription(widget.playlists.requireValue),
              alignment: MainAxisAlignment.start,
            )
          : null,
      itemsState: widget.playlists.map(
        data: (s) => AsyncData((itemCount: s.requireValue.length, title: null)),
        error: (s) => AsyncError(s.error, s.stackTrace),
        loading: (state) => const AsyncLoading(),
      ),
      childBuilder: (double cardWidth, int index) {
        final playlist = widget.playlists.value!.elementAt(index);
        return CustomCard(
          tag: playlist.id ?? playlist.title!,
          thumbnails: playlist.thumbnails,
          title: playlist.title!,
          shape: BoxShape.rectangle,
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
