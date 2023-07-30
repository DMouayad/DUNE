import 'package:dune/presentation/providers/state_controllers.dart';
import 'package:flutter/material.dart';
import 'package:fluent_ui/fluent_ui.dart' as fluent;
import 'package:flutter_riverpod/flutter_riverpod.dart';

//
import 'package:dune/support/extensions/context_extensions.dart';

import 'albums_listening_history_tab.dart';
import 'playlists_listening_history_tab.dart';
import 'listening_history_summary_tab.dart';
import 'tracks_listening_history_tab.dart';

class ListeningHistoryPage extends ConsumerStatefulWidget {
  const ListeningHistoryPage({super.key});

  @override
  ConsumerState<ListeningHistoryPage> createState() =>
      _ListeningHistoryPageState();
}

class _ListeningHistoryPageState extends ConsumerState<ListeningHistoryPage>
    with SingleTickerProviderStateMixin {
  final tabs = const [
    Tab(text: 'TOP'),
    Tab(text: 'TRACKS'),
    Tab(text: 'ALBUMS'),
    Tab(text: 'PLAYLISTS'),
  ];

  late final tabController = TabController(vsync: this, length: tabs.length);

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Your listening history",
                style: context.pageHeaderTextStyle,
              ),
              IconButton(
                onPressed: () {
                  ref
                      .read(listeningHistoryControllerProvider.notifier)
                      .loadListeningHistoryOverLastMonth();
                },
                icon: Icon(
                  Icons.refresh,
                  size: 20,
                  color: context.colorScheme.secondary,
                ),
              ),
            ],
          ),
        ),
        Positioned.fill(
          top: 40,
          left: 0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              fluent.SizedBox(
                height: 70,
                width: 350,
                child: Material(
                  type: MaterialType.transparency,
                  child: TabBar(
                    controller: tabController,
                    indicatorSize: TabBarIndicatorSize.label,
                    indicatorColor: Colors.transparent,
                    labelColor: context.colorScheme.onPrimaryContainer,
                    unselectedLabelColor:
                        context.colorScheme.onPrimaryContainer.withOpacity(.6),
                    labelStyle: context.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                    tabs: tabs,
                  ),
                ),
              ),
              // const Divider(),
              Expanded(
                child: TabBarView(
                  controller: tabController,
                  children: const [
                    ListeningHistorySummaryTab(),
                    TracksListeningHistoryTab(),
                    AlbumsListeningHistoryTab(),
                    PlaylistsListeningHistoryTab(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
