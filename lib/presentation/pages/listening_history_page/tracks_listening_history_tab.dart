import 'package:dune/domain/audio/base_models/base_play_history.dart';
import 'package:dune/domain/audio/base_models/base_track_record.dart';
import 'package:dune/presentation/custom_widgets/selection_tool_bar.dart';
import 'package:dune/presentation/providers/state_controllers.dart';
import 'package:dune/support/extensions/context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'listening_history_date_section.dart';
import 'listening_history_section_shimmer.dart';
import 'tracks_records_list_view.dart';

class TracksListeningHistoryTab extends ConsumerWidget {
  const TracksListeningHistoryTab({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final listeningHistoryState = ref
        .watch(listeningHistoryControllerProvider)
        .whenData(
            (value) => value.where((history) => history.tracks.isNotEmpty));
    if (!listeningHistoryState.isLoading && !listeningHistoryState.hasValue) {
      return const Center(
          child: Text("Failed Loading songs listening history"));
    }
    if (listeningHistoryState.hasValue &&
        (listeningHistoryState.value?.isEmpty ?? false)) {
      return Center(
        child: Text(
          "You haven't played any playlists recently...",
          style: context.textTheme.titleSmall?.copyWith(
            color: context.colorScheme.secondary,
          ),
        ),
      );
    }
    return Column(
      children: [
        Consumer(builder: (context, ref, _) {
          return SelectionToolBar(
            controller:
                ref.read(tracksRecordsSelectionControllerProvider.notifier),
            selectionState: ref.watch(tracksRecordsSelectionControllerProvider),
            onSelectAll: () => _onSelectAllTracks(
                ref, listeningHistoryState.valueOrNull?.toList()),
          );
        }),
        Expanded(
          flex: 0,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: listeningHistoryState.isLoading
                ? 1
                : listeningHistoryState.valueOrNull?.length ?? 0,
            itemBuilder: (BuildContext context, int index) {
              if (listeningHistoryState.isLoading) {
                return const ListeningHistorySectionShimmer();
              } else if (listeningHistoryState.hasValue) {
                final listeningHistory =
                    listeningHistoryState.requireValue.elementAt(index);
                final List<BaseTrackRecord> tracksRecords =
                    listeningHistory.tracks;
                return Column(
                  children: [
                    ListeningHistoryDateSectionHeader(
                      date: listeningHistory.date,
                      trailing: _contentDescription(tracksRecords),
                    ),
                    TracksRecordsListView(tracksRecords),
                  ],
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ),
      ],
    );
  }

  String _contentDescription(List<BaseTrackRecord> tracksRecords) {
    return tracksRecords.length > 1
        ? '(${tracksRecords.length} tracks)'
        : '1 track';
  }

  _onSelectAllTracks(
    WidgetRef ref,
    List<BaseListeningHistory>? histories,
  ) {
    ref.read(tracksRecordsSelectionControllerProvider.notifier).selectAll(
          Map.fromEntries(
            histories
                    ?.map((e) => e.tracks)
                    .expand((element) => element)
                    .map((e) => MapEntry(e.track!.id, e.track!)) ??
                [],
          ),
        );
  }
}
