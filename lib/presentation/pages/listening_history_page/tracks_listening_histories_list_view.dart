import 'package:flutter/material.dart';

//
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

//
import 'package:dune/domain/audio/base_models/base_track.dart';
import 'package:dune/domain/audio/base_models/base_track_listening_history.dart';
import 'package:dune/presentation/controllers/selection_controller.dart';
import 'package:dune/presentation/custom_widgets/track_card.dart';
import 'package:dune/presentation/custom_widgets/track_card_pop_up_menu.dart';
import 'package:dune/presentation/custom_widgets/track_card_wrapper.dart';
import 'package:dune/presentation/providers/state_controllers.dart';
import 'package:dune/support/extensions/context_extensions.dart';
import 'package:dune/support/extensions/extensions.dart';

final trackListeningHistoryCardsSelectionControllerProvider =
    StateNotifierProvider<SelectionController<BaseTrack>,
        SelectionState<BaseTrack>>(
  (ref) => SelectionController<BaseTrack>(SelectionState.initialState()),
);

class TracksListeningHistoriesListView extends ConsumerWidget {
  final List<BaseTrackListeningHistory> tracksListeningHistories;
  final EdgeInsets? listPadding;
  final EdgeInsets? itemPadding;
  final bool compact;

  const TracksListeningHistoriesListView(
    this.tracksListeningHistories, {
    this.listPadding,
    this.itemPadding,
    this.compact = false,
    super.key,
  });

  @override
  Widget build(BuildContext context, ref) {
    final tracksRecords = tracksListeningHistories.reversed.toList();
    return AnimationLimiter(
      child: ListView.builder(
        shrinkWrap: true,
        itemExtent: 72,
        padding: listPadding ??
            (compact
                ? const EdgeInsets.only(top: 22)
                : const EdgeInsets.all(8)),
        itemCount: tracksRecords.length,
        itemBuilder: (context, index) {
          return AnimationConfiguration.staggeredList(
            position: index,
            duration: const Duration(milliseconds: 375),
            child: SlideAnimation(
              horizontalOffset: 50.0,
              child: FadeInAnimation(
                child: Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: TrackRecordCard(
                    trackListeningHistory: tracksRecords.elementAt(index),
                    color: context.colorScheme.background,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class TrackRecordCard extends ConsumerWidget {
  const TrackRecordCard({
    super.key,
    required this.trackListeningHistory,
    required this.color,
  });

  final BaseTrackListeningHistory trackListeningHistory;
  final Color color;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final BaseTrack? track = trackListeningHistory.track;
    if (track == null) return const Text("Track was not found");

    final textTheme = context.textTheme.bodyMedium?.copyWith(
      color: context.colorScheme.secondary,
    );
    final popupMenu = TrackCardPopupMenu(
      track,
      additionalItems: [
        (
          text: 'show Track listening history',
          icon: Icons.history,
          onPressed: () {},
        ),
      ],
    );
    return TrackCardWrapper(
      playOnTap: false,
      onPlayTrack: () => _playTrack(track, ref),
      track: track,
      selectionState:
          ref.watch(trackListeningHistoryCardsSelectionControllerProvider),
      onSelected: () {
        ref
            .read(
                trackListeningHistoryCardsSelectionControllerProvider.notifier)
            .toggleSelectionForItem(track.id, track);
      },
      cardColor: color,
      popupMenu: popupMenu,
      child: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SizedBox(
              height: 60,
              child: TrackCardMainContent(
                track: track,
                showAlbumName: false,
                showArtistsNames: false,
                showDuration: false,
                alwaysCenterTitle: true,
                crossAxisAlignment: CrossAxisAlignment.start,
                onThumbnailPressed: () => _playTrack(track, ref),
              ),
            ),
          ),
          Positioned(
            left: 100,
            bottom: 0,
            right: 8,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "complete listens: ${trackListeningHistory.completedListensCount}",
                  style: textTheme,
                ),
                // Spacer(),
                Text(
                  "uncompleted listens total: "
                  "${trackListeningHistory.uncompletedListensTotalDuration?.formatInHhMmSs ?? 0}",
                  style: textTheme,
                ),
                Tooltip(
                  message: "More",
                  child: GestureDetector(
                    onTapDown: (tapDetails) {
                      final isSelected = ref
                          .watch(
                              trackListeningHistoryCardsSelectionControllerProvider)
                          .selectedValues
                          .containsKey(track.id);

                      showTrackCardPopupMenu(
                        context,
                        isSelected,
                        tapDetails.localPosition,
                        popupMenu,
                      );
                    },
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.more_horiz_rounded, size: 20),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _playTrack(BaseTrack track, WidgetRef ref) {
    ref.read(playbackControllerProvider.notifier).player.playSingleTrack(track);
  }
}
