import 'package:dune/domain/audio/base_models/base_track_listening_history.dart';
import 'package:dune/presentation/custom_widgets/selection_tool_bar.dart';
import 'package:dune/presentation/providers/state_controllers.dart';
import 'package:dune/support/extensions/context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'listening_history_date_section.dart';
import 'listening_history_section_shimmer.dart';
import 'tracks_listening_histories_list_view.dart';

class TracksListeningHistoryTab extends ConsumerWidget {
  const TracksListeningHistoryTab({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final listeningHistoryState = ref.watch(
      listeningHistoryControllerProvider.select(
          (value) => value.whenData((value) => value.tracksListeningHistory)),
    );
    if (!listeningHistoryState.isLoading && !listeningHistoryState.hasValue) {
      return const Center(
          child: Text("Failed Loading songs listening history"));
    }
    if (listeningHistoryState.hasValue &&
        (listeningHistoryState.value?.isEmpty ?? false)) {
      return Center(
        child: Text(
          "You haven't played any tracks recently...",
          style: context.textTheme.titleSmall?.copyWith(
            color: context.colorScheme.secondary,
          ),
        ),
      );
    }
    return CustomScrollView(
      primary: true,
      slivers: [
        SliverPersistentHeader(
          pinned: true,
          floating: true,
          delegate: PersistentSelectionToolBar(
            controller: ref.read(
                trackListeningHistoryCardsSelectionControllerProvider.notifier),
            selectionState: ref
                .watch(trackListeningHistoryCardsSelectionControllerProvider),
            onSelectAll: () => _onSelectAllTracks(
              ref,
              listeningHistoryState.valueOrNull?.values
                  .expand((e) => e)
                  .toList(),
            ),
          ),
        ),
        SliverList.builder(
          // shrinkWrap: true,
          itemCount: listeningHistoryState.isLoading
              ? 1
              : listeningHistoryState.valueOrNull?.length ?? 0,
          itemBuilder: (BuildContext context, int index) {
            if (listeningHistoryState.isLoading) {
              return const ListeningHistorySectionShimmer();
            } else if (listeningHistoryState.hasValue) {
              final item =
                  listeningHistoryState.requireValue.entries.elementAt(index);
              return Column(
                children: [
                  ListeningHistoryDateSectionHeader(
                    date: item.key,
                    trailing: _contentDescription(item.value),
                  ),
                  TracksListeningHistoriesListView(item.value),
                ],
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ],
    );
  }

  String _contentDescription(List<BaseTrackListeningHistory> tracksRecords) {
    return tracksRecords.length > 1
        ? '(${tracksRecords.length} tracks)'
        : '1 track';
  }

  _onSelectAllTracks(
    WidgetRef ref,
    List<BaseTrackListeningHistory>? histories,
  ) {
    ref
        .read(trackListeningHistoryCardsSelectionControllerProvider.notifier)
        .selectAll(
          Map.fromEntries(
            histories
                    ?.map((e) => e)
                    .map((e) => MapEntry(e.track!.id, e.track!)) ??
                [],
          ),
        );
  }
}
