import 'package:dune/domain/audio/base_models/base_playlist.dart';
import 'package:dune/domain/audio/base_models/base_track.dart';
import 'package:dune/presentation/controllers/selection_controller.dart';
import 'package:dune/presentation/custom_widgets/error_widget.dart';
import 'package:dune/presentation/custom_widgets/shimmer_widget.dart';
import 'package:dune/presentation/custom_widgets/track_card.dart';
import 'package:dune/presentation/providers/state_controllers.dart';
import 'package:dune/support/extensions/context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class TracksListView extends ConsumerWidget {
  final AsyncValue<List<BaseTrack>> tracksState;
  final EdgeInsets? listPadding;
  final EdgeInsets? itemPadding;
  final BasePlaylist? playlist;
  final void Function()? onRetryWhenErrorLoadingTracks;
  final TracksSelectionControllerProvider selectionControllerProvider;

  const TracksListView(
    this.tracksState, {
    required this.selectionControllerProvider,
    this.listPadding,
    this.itemPadding,
    this.playlist,
    this.onRetryWhenErrorLoadingTracks,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (tracksState.hasValue && !tracksState.isLoading) {
      final tracks = tracksState.requireValue.toList();
      return Column(
        children: [
          AnimationLimiter(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: tracks.length,
              itemBuilder: (context, index) {
                return AnimationConfiguration.staggeredList(
                  position: index,
                  duration: const Duration(milliseconds: 375),
                  child: SlideAnimation(
                    verticalOffset: 50.0,
                    child: FadeInAnimation(
                      child: Padding(
                        padding: itemPadding ?? _getCardPadding(context),
                        child: TrackCard(
                          selectionState:
                              ref.watch(selectionControllerProvider),
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
                          color: _getCardColor(index, context.colorScheme),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      );
    } else if (tracksState.isLoading) {
      return AnimationLimiter(
        child: ListView.separated(
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
        ),
      );
    } else if (tracksState.hasError) {
      return DuneErrorWidget(
        tracksState.error,
        onRetry: onRetryWhenErrorLoadingTracks,
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

  Color _getCardColor(int index, ColorScheme colorScheme) {
    return index % 2 != 0
        ? colorScheme.surfaceVariant.withOpacity(.5)
        : colorScheme.background;
  }
}
