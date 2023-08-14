import 'package:dune/domain/audio/base_models/base_playlist.dart';
import 'package:dune/domain/audio/base_models/base_track.dart';
import 'package:dune/domain/audio/base_models/thumbnails_set.dart';
import 'package:dune/presentation/controllers/selection_controller.dart';
import 'package:dune/presentation/custom_widgets/tracks_list_view.dart';
import 'package:dune/presentation/providers/shared_providers.dart';
import 'package:dune/presentation/providers/state_controllers.dart';
import 'package:dune/support/enums/music_source.dart';
import 'package:dune/support/extensions/context_extensions.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'playlist_page_header.dart';

class PlaylistPage extends ConsumerStatefulWidget {
  final String playlistId;
  final String? title;
  final String? description;
  final String? tracksCount;
  final ThumbnailsSet? thumbnails;
  final MusicSource? musicSource;

  const PlaylistPage({
    Key? key,
    required this.playlistId,
    required this.musicSource,
    this.title,
    this.description,
    this.tracksCount,
    this.thumbnails,
  }) : super(key: key);

  @override
  ConsumerState<PlaylistPage> createState() => _PlaylistPageState();
}

class _PlaylistPageState extends ConsumerState<PlaylistPage>
    with AutomaticKeepAliveClientMixin<PlaylistPage> {
  AsyncValue<BasePlaylist?> playlistState = const AsyncValue.loading();
  BasePlaylist? playlist;

  /// [Provider] for a [SelectionController] for this [playlist]'s tracks.
  ///
  /// Each [PlaylistPage] has its [selectionController]
  /// in case of the tabs-mode is enabled.
  late final selectionController = TracksSelectionControllerProvider(
    (ref) => SelectionController<BaseTrack>(
      SelectionState.initial(itemToString: (track) => track.title),
    ),
  );

  @override
  Widget build(BuildContext context) {
    super.build(context);

    if (ref.watch(playlistControllerProvider).hasError) {
      playlistState = ref.watch(playlistControllerProvider);
      playlist = null;
      updateKeepAlive();
    }
    if (ref.watch(playlistControllerProvider).hasValue) {
      final newPlaylist = ref.watch(playlistControllerProvider).value;
      if (newPlaylist != null && newPlaylist.id == widget.playlistId) {
        if ((playlist?.hasSameTracksAsOther(newPlaylist) ?? false)) {
          playlistState = AsyncData(playlistState.value);
          updateKeepAlive();
        } else {
          playlistState = ref.watch(playlistControllerProvider);
          playlist = playlistState.value;
          updateKeepAlive();
        }
      }
    }

    final maxHeight = context.screenWidth > 500
        ? context.screenHeight * 0.27
        : context.screenHeight * 0.23;
    return Padding(
      padding: const EdgeInsets.only(top: 24),
      child: CustomScrollView(
        primary: true,
        slivers: [
          SliverPersistentHeader(
            pinned: true,
            delegate: PersistentPlaylistPageHeaderDelegate(
              minHeaderExtent: 70,
              maxHeaderExtent: maxHeight,
              isFetchingPlaylistInfo:
                  playlistState.hasValue && playlistState.isLoading,
              title: widget.title ?? playlist?.title ?? '',
              description: widget.description ?? playlist?.description ?? '',
              cardColor: context.colorScheme.background,
              thumbnailsSet: widget.thumbnails ?? playlist?.thumbnails,
              tracksCount: (widget.tracksCount != null
                      ? int.tryParse(widget.tracksCount!)
                      : null) ??
                  playlist?.tracks.length,
              onShuffle: playlistState.valueOrNull != null ? () {} : null,
              controller: ref.read(selectionController.notifier),
              selectionState: ref.watch(selectionController),
              onSelectAll: () => _onSelectAllTracks(ref, playlist?.tracks),
            ),
          ),
          TracksListView(
            isSliverList: true,
            physics: const NeverScrollableScrollPhysics(),
            selectionControllerProvider: selectionController,
            playlistState.whenData((data) => data?.tracks ?? []),
            playlist: playlistState.whenData((value) => value).valueOrNull,
            onRetryWhenErrorLoadingTracks: () {
              if (widget.musicSource != null) {
                ref.read(playlistControllerProvider.notifier).get(
                      widget.playlistId,
                      widget.musicSource!,
                    );
              }
            },
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;

  void _onSelectAllTracks(WidgetRef ref, List<BaseTrack>? tracks) {
    ref.read(selectionController.notifier).selectAll(
          Map.fromEntries(tracks?.map((e) => MapEntry(e.id, e)) ?? []),
        );
  }
}
