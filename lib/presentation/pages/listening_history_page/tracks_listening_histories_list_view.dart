import 'package:flutter/material.dart';

//
import 'package:flutter_riverpod/flutter_riverpod.dart';

//
import 'package:dune/presentation/providers/shared_providers.dart';
import 'package:dune/domain/audio/base_models/base_track.dart';
import 'package:dune/domain/audio/base_models/base_track_listening_history.dart';
import 'package:dune/presentation/controllers/selection_controller.dart';
import 'package:dune/support/extensions/context_extensions.dart';

import 'tracks_tab_components/track_history_card.dart';

final trackListeningHistoryCardsSelectionControllerProvider =
    TracksSelectionControllerProvider(
  (ref) => SelectionController<BaseTrack>(
    SelectionState<BaseTrack>.initial(itemToString: (track) => track.title),
  ),
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
    return ListView.builder(
      shrinkWrap: true,
      itemExtent: 60,
      padding: listPadding ??
          (compact ? const EdgeInsets.only(top: 22) : const EdgeInsets.all(8)),
      itemCount: tracksListeningHistories.length,
      itemBuilder: (context, index) {
        return TrackHistoryCard(
          trackListeningHistory: tracksListeningHistories.elementAt(index),
          color: context.colorScheme.secondary.withOpacity(.04),
        );
      },
    );
  }
}
