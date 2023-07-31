import 'package:dune/domain/audio/base_models/base_track.dart';
import 'package:dune/navigation/app_router.dart';
import 'package:dune/presentation/controllers/selection_controller.dart';
import 'package:dune/presentation/screens/home/components/app_tab_view.dart';
import 'package:dune/support/enums/music_source.dart';
import 'package:dune/support/enums/now_playing_section_display_mode.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'state_controllers.dart';

/// used to determine the current display mode of the [NowPlayingCard] widget.
final nowPlayingSectionDisplayModeProvider =
    StateProvider((_) => NowPlayingSectionDisplayMode.hidden);

final materialSearchBarControllerProvider = Provider((_) => SearchController());

late final StateProvider<HomeNavigationShellBranchIndex?>
    homeNavigationShellBranchIndexProvider;

final StateProvider<int> selectedTapIndexProvider =
    StateProvider<int>((_) => 0);

final StateProvider<String?> selectedTabKeyProvider = StateProvider(
  (ref) => ref
      .watch(homeScreenTabsProvider)[ref.watch(selectedTapIndexProvider)]
      .tabKey,
);

late final StateProvider<List<TabData>> homeScreenTabsProvider;

final StateProvider<double?> navigationRailSizeProvider = StateProvider((ref) {
  return ref.watch(appPreferencesController).lastSidePanelWidth;
});

late final StateProvider<int?> navigationRailSelectedIndex;

final StateProvider<MusicSource> explorePageMusicSourceProvider =
    StateProvider((ref) {
  return ref.read(appPreferencesController).exploreMusicSource;
});

final searchBarMusicSourceFilterProvider =
    StateProvider((ref) => ref.watch(appPreferencesController).searchEngine);

typedef TracksSelectionControllerProvider = StateNotifierProvider<
    SelectionController<BaseTrack>, SelectionState<BaseTrack>>;
