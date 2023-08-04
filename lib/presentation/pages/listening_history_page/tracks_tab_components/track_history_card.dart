import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//
import 'package:dune/domain/audio/base_models/base_track.dart';
import 'package:dune/domain/audio/base_models/base_track_listening_history.dart';
import 'package:dune/presentation/custom_widgets/placeholders.dart';
import 'package:dune/presentation/custom_widgets/thumbnail_widget.dart';
import 'package:dune/presentation/custom_widgets/track_card_pop_up_menu.dart';
import 'package:dune/presentation/custom_widgets/track_card_wrapper.dart';
import 'package:dune/presentation/pages/listening_history_page/tracks_listening_histories_list_view.dart';
import 'package:dune/presentation/providers/state_controllers.dart';
import 'package:dune/support/extensions/context_extensions.dart';
import 'package:dune/support/extensions/extensions.dart';

class TrackHistoryCard extends ConsumerWidget {
  const TrackHistoryCard({
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

    final popupMenu = TrackCardPopupMenu(
      track,
      onSelectTrack: () => _onSelected(ref, track),
    );
    final selectionState =
        ref.watch(trackListeningHistoryCardsSelectionControllerProvider);

    return TrackCardWrapper(
      playOnTap: false,
      onPlayTrack: () => _playTrack(track, ref),
      track: track,
      selectionState: selectionState,
      onSelected: () => _onSelected(ref, track),
      cardColor: color,
      popupMenu: popupMenu,
      child: Flex(
        direction: Axis.horizontal,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: _TrackInfoPart(
              track: track,
              selectionEnabled: selectionState.selectionEnabled,
              playTrack: () => _playTrack(track, ref),
            ),
          ),
          Expanded(
            child: _ListeningHistoryInfoPart(trackListeningHistory),
          ),
          Expanded(
            flex: 0,
            child: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.history, size: 18),
            ),
          ),
          _MoreButton(
            selected: selectionState.selectedValues.containsKey(track.id),
            popupMenu: popupMenu,
          ),
          const SizedBox(width: 10),
        ],
      ),
    );
  }

  void _onSelected(WidgetRef ref, BaseTrack track) {
    ref
        .read(trackListeningHistoryCardsSelectionControllerProvider.notifier)
        .toggleSelectionForItem(track.id, track);
  }

  void _playTrack(BaseTrack track, WidgetRef ref) {
    ref.read(playbackControllerProvider.notifier).player.playSingleTrack(track);
  }
}

class _TrackInfoPart extends StatelessWidget {
  const _TrackInfoPart({
    required this.track,
    required this.selectionEnabled,
    required this.playTrack,
  });

  final BaseTrack track;
  final bool selectionEnabled;
  final void Function() playTrack;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: context.platformBorderRadius,
      onTap: selectionEnabled ? null : () => playTrack(),
      child: Tooltip(
        message: selectionEnabled ? 'Tap to toggle selection' : 'Tap to play',
        waitDuration: const Duration(milliseconds: 1000),
        child: Row(
          children: [
            Expanded(
              flex: 0,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 2.0,
                  horizontal: 6.0,
                ),
                child: ThumbnailWidget(
                  thumbnailsSet: track.thumbnails,
                  dimension: context.trackThumbnailDimension,
                  cacheNetworkImage: true,
                  placeholder: const TrackCoverPlaceholder(),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 6,
                  // vertical: 3,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  // mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      track.title,
                      overflow: TextOverflow.ellipsis,
                      style: context.textTheme.titleSmall?.copyWith(
                        color: context.colorScheme.onBackground,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      track.artistsNames,
                      overflow: TextOverflow.ellipsis,
                      style: context.textTheme.bodySmall?.copyWith(
                        color: context.colorScheme.onPrimaryContainer,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ListeningHistoryInfoPart extends StatelessWidget {
  const _ListeningHistoryInfoPart(this.trackListeningHistory);

  final BaseTrackListeningHistory trackListeningHistory;

  @override
  Widget build(BuildContext context) {
    final divider = VerticalDivider(
      color: context.colorScheme.onBackground.withOpacity(.05),
      thickness: 1.1,
    );
    return Tooltip(
      message:
          ''' Completed listens count: ${trackListeningHistory.completedListensCount ?? 0}
      \ntotal uncompleted listens duration: ${trackListeningHistory.uncompletedListensTotalDuration?.formatInHhMmSs} 
      \n Total listening duration for this day(in minutes): ${trackListeningHistory.totalListeningDuration?.inMinutes}
      ''',
      child: LayoutBuilder(builder: (context, constraints) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              // total listens duration in minutes //
              Expanded(
                flex: 0,
                child: _NumberCircle(
                  title: "Total minutes:  ",
                  number:
                      trackListeningHistory.totalListeningDuration?.inMinutes,
                ),
              ),
              Flexible(child: divider),
              if (constraints.maxWidth > 320) ...[
                // complete listens count
                Expanded(
                  flex: 0,
                  child: _NumberCircle(
                    title: "Completed listens count:  ",
                    number: trackListeningHistory.completedListensCount,
                  ),
                ),
                divider,
              ],
            ],
          ),
        );
      }),
    );
  }
}

class _MoreButton extends StatelessWidget {
  const _MoreButton({required this.selected, required this.popupMenu});

  final bool selected;
  final TrackCardPopupMenu popupMenu;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: "options",
      child: InkWell(
        hoverColor: Colors.transparent,
        onTapDown: (tapDetails) {
          showTrackCardPopupMenu(
            context,
            selected,
            Offset(
              tapDetails.globalPosition.dx,
              tapDetails.localPosition.dy,
            ),
            popupMenu,
          );
        },
        child: Center(
          child: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert_outlined, size: 18),
          ),
        ),
      ),
    );
  }
}

class _NumberCircle extends StatelessWidget {
  const _NumberCircle({required this.number, required this.title});

  final int? number;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      // mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          title,
          style: context.textTheme.bodySmall?.copyWith(
            color: context.colorScheme.onBackground.withOpacity(.95),
            fontWeight: FontWeight.w500,
          ),
        ),
        Container(
          width: 40,
          height: 40,
          decoration: ShapeDecoration(
            shape: CircleBorder(
              side: BorderSide(
                color: context.colorScheme.primaryContainer,
                width: 1.5,
              ),
            ),
          ),
          child: Center(
            child: Text(
              '${number ?? 0}',
              style: context.textTheme.titleSmall?.copyWith(
                color: context.colorScheme.primary,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
