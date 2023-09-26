import 'package:dune/domain/audio/base_models/base_playlist.dart';
import 'package:dune/domain/audio/base_models/base_track.dart';
import 'package:dune/domain/audio/base_models/thumbnails_set.dart';
import 'package:dune/presentation/controllers/base_paged_items_controller.dart';
import 'package:dune/presentation/controllers/library_controllers.dart';
import 'package:dune/presentation/controllers/selection_controller.dart';
import 'package:dune/presentation/custom_widgets/track_card.dart';
import 'package:dune/presentation/providers/shared_providers.dart';
import 'package:dune/presentation/providers/state_controllers.dart';
import 'package:dune/support/enums/music_source.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import 'library_items_page.dart';

final _selectionControllerProvider = TracksSelectionControllerProvider(
  (ref) => SelectionController<BaseTrack>(
    SelectionState.initial(itemToString: (track) => track.title),
  ),
);
final _tracksControllerProvider = StateNotifierProvider<
    LocalLibraryTracksController,
    QueryOptionsPagedState<BaseTrack>>((ref) => LocalLibraryTracksController());

class LibraryTracksPage extends ConsumerWidget {
  const LibraryTracksPage({super.key});

  @override
  Widget build(BuildContext context, ref) {
    return LibraryItemsPage<BaseTrack, BaseTrack>(
      pagedBuilder: (c, b) =>
          PagedSliverList(pagingController: c, builderDelegate: b),
      title: 'Library tracks',
      selectionControllerProvider: _selectionControllerProvider,
      itemsControllerProvider: _tracksControllerProvider,
      onSelectAll: () => _selectionControllerProvider.onSelectAllTracks(
          ref, ref.watch(_tracksControllerProvider).records),
      onShuffleItems: () {
        ref.read(playbackControllerProvider.notifier).player.playPlaylist(
            _getPlaylist(ref.watch(_tracksControllerProvider).records ?? []));
      },
      itemBuilder: (context, item, index) {
        return TrackCard(
          track: item,
          onPlayTrack: () {
            ref.read(playbackControllerProvider.notifier).player.playPlaylist(
                  _getPlaylist(
                      ref.watch(_tracksControllerProvider).records ?? []),
                  track: item,
                );
          },
          selectionState: ref.watch(_selectionControllerProvider),
          onSelected: (track) => ref
              .read(_selectionControllerProvider.notifier)
              .toggleSelectionForItem(track.id, track),
        );
      },
    );
  }
}

/// Returns a playlist with all library tracks.
BasePlaylist _getPlaylist(List<BaseTrack> tracks) {
  return BasePlaylist(
    tracks: tracks,
    musicSource: MusicSource.local,
    id: DateTime.now().hashCode.toString(),
    author: const PlaylistAuthor(name: ''),
    description: '',
    duration: null,
    durationSeconds: null,
    thumbnails: const ThumbnailsSet(),
    title: null,
    createdAt: null,
  );
}
