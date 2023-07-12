import 'package:dune/domain/audio/base_models/base_track.dart';
import 'package:dune/domain/audio/base_models/base_track_record.dart';
import 'package:dune/presentation/custom_widgets/track_card.dart';
import 'package:dune/presentation/custom_widgets/track_card_wrapper.dart';
import 'package:dune/presentation/providers/state_controllers.dart';
import 'package:dune/support/extensions/context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class TracksRecordsListView extends ConsumerWidget {
  final List<BaseTrackRecord> tracksRecordsState;
  final EdgeInsets? listPadding;
  final EdgeInsets? itemPadding;
  final bool compact;

  const TracksRecordsListView(
    this.tracksRecordsState, {
    this.listPadding,
    this.itemPadding,
    this.compact = false,
    super.key,
  });

  @override
  Widget build(BuildContext context, ref) {
    final tracksRecords = tracksRecordsState.reversed.toList();
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
                child: TrackRecordCard(
                  trackRecord: tracksRecords.elementAt(index),
                  color: _getCardColor(index, context.colorScheme),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Color _getCardColor(int index, ColorScheme colorScheme) {
    return index % 2 != 0 ? Colors.transparent : colorScheme.background;
  }
}

class TrackRecordCard extends ConsumerWidget {
  const TrackRecordCard({
    super.key,
    required this.trackRecord,
    required this.color,
  });

  final BaseTrackRecord trackRecord;
  final Color color;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    print(trackRecord.track?.id);
    final BaseTrack? track = trackRecord.track;
    if (track == null) return const Text("Track was not found");

    final textTheme = context.textTheme.bodyMedium?.copyWith(
      color: context.colorScheme.secondary,
    );
    return TrackCardWrapper(
      track: track,
      cardColor: color,
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
                alwaysCenterTitle: true,
                crossAxisAlignment: CrossAxisAlignment.start,
                onThumbnailPressed: () {
                  ref
                      .read(playbackControllerProvider.notifier)
                      .player
                      .playSingleTrack(track);
                },
              ),
            ),
          ),
          // Divider(),
          Positioned(
            // top: 0,
            left: 100,
            bottom: 0,
            right: 8,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "complete listens: ${trackRecord.listeningHistory.first.completedListensCount}",
                  style: textTheme,
                ),
                // Spacer(),
                Text(
                  "uncompleted listens total: "
                  "${trackRecord.listeningHistory.first.uncompletedListensTotalDuration?.inMinutes ?? 0}(min)",
                  style: textTheme,
                ),
                Tooltip(
                  message: "More about this song listening history",
                  child: IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.more_horiz_rounded, size: 20),
                    // label: Text("more"),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
