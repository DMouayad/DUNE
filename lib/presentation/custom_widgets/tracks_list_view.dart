import 'package:dune/domain/audio/base_models/base_playlist.dart';
import 'package:dune/domain/audio/base_models/base_track.dart';
import 'package:dune/presentation/custom_widgets/error_widget.dart';
import 'package:dune/presentation/custom_widgets/shimmer_widget.dart';
import 'package:dune/presentation/custom_widgets/track_card.dart';
import 'package:dune/presentation/providers/shared_providers.dart';
import 'package:dune/presentation/providers/state_controllers.dart';
import 'package:dune/support/extensions/context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'optional_parent_widget.dart';

class TracksListView extends ConsumerWidget {
  final AsyncValue<List<BaseTrack>> tracksState;
  final EdgeInsets? listPadding;
  final EdgeInsets? itemPadding;
  final BasePlaylist? playlist;
  final void Function()? onRetryWhenErrorLoadingTracks;
  final TracksSelectionControllerProvider selectionControllerProvider;
  final ScrollPhysics? physics;
  final bool isSliverList;

  const TracksListView(
    this.tracksState, {
    this.isSliverList = false,
    required this.selectionControllerProvider,
    this.listPadding,
    this.itemPadding,
    this.playlist,
    this.onRetryWhenErrorLoadingTracks,
    this.physics,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (tracksState.hasValue && !tracksState.isLoading) {
      final tracks = tracksState.requireValue.toList();
      Widget builder(BuildContext context, int index) {
        return Padding(
          padding: itemPadding ?? _getCardPadding(context),
          child: TrackCard(
            selectionState: ref.watch(selectionControllerProvider),
            onSelected: (track) {
              ref
                  .read(selectionControllerProvider.notifier)
                  .toggleSelectionForItem(track.id, track);
            },
            onPlayTrack: () {
              if (playlist != null) {
                ref
                    .read(playbackControllerProvider.notifier)
                    .player
                    .playPlaylist(
                      playlist!,
                      track: tracks.elementAt(index),
                    );
              } else {
                ref
                    .read(playbackControllerProvider.notifier)
                    .player
                    .playSingleTrack(tracks.elementAt(index));
              }
            },
            track: tracks.elementAt(index),
          ),
        );
      }

      return isSliverList
          ? SliverFixedExtentList.builder(
              itemExtent: 70,
              itemCount: tracks.length,
              itemBuilder: builder,
            )
          : ListView.builder(
              shrinkWrap: true,
              physics: physics,
              itemExtent: 70,
              itemCount: tracks.length,
              itemBuilder: builder,
            );
    } else if (tracksState.isLoading) {
      return isSliverList
          ? SliverPadding(
              padding: const EdgeInsets.all(8.0),
              sliver: SliverList.builder(
                itemCount: 6,
                itemBuilder: (context, index) => const Padding(
                  padding: EdgeInsets.symmetric(vertical: 5.0),
                  child: ShimmerWidget(
                    enabled: true,
                    shimmerSize: Size.fromHeight(50),
                  ),
                ),
              ),
            )
          : ListView.separated(
              shrinkWrap: true,
              padding: const EdgeInsets.all(8),
              itemCount: 6,
              itemBuilder: (context, index) => const ShimmerWidget(
                enabled: true,
                shimmerSize: Size.fromHeight(50),
              ),
              separatorBuilder: (BuildContext context, int index) {
                return const SizedBox(height: 10);
              },
            );
    } else if (tracksState.hasError) {
      return OptionalParentWidget(
        condition: isSliverList,
        parentWidgetBuilder: (child) => SliverFillRemaining(child: child),
        childWidget: DuneErrorWidget(
          tracksState.error,
          onRetry: onRetryWhenErrorLoadingTracks,
        ),
      );
    } else {
      return Center(
        child: Text(
          "Sorry! Could not load songs list...",
          style: context.textTheme.titleLarge,
        ),
      );
    }
  }

  EdgeInsets _getCardPadding(BuildContext context) {
    return (context.isPortraitTablet
        ? const EdgeInsets.fromLTRB(6, 12, 6, 0)
        : const EdgeInsets.fromLTRB(20, 6, 20, 0));
  }
}
