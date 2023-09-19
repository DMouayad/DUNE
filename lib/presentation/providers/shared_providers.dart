import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//
import 'package:dune/domain/audio/base_models/base_track.dart';
import 'package:dune/presentation/controllers/selection_controller.dart';
import 'package:dune/presentation/models/tabs_state.dart';
import 'package:dune/support/enums/music_source.dart';
import 'package:dune/support/enums/now_playing_section_display_mode.dart';

import 'state_controllers.dart';

/// Provide whether a back button should be visible or not.
final showBackButtonProvider = StateProvider((_) => false);

/// used to determine the current display mode of the [NowPlayingCard] widget.
final nowPlayingSectionDisplayModeProvider =
    StateProvider((_) => NowPlayingSectionDisplayMode.hidden);

final materialSearchBarControllerProvider = Provider((_) => SearchController());

late final StateProvider<TabsState> tabsStateProvider;

final StateProvider<double?> navigationRailSizeProvider =
    StateProvider((_) => null);

final StateProvider<MusicSource> explorePageMusicSourceProvider =
    StateProvider((ref) {
  return ref.read(appPreferencesController).exploreMusicSource;
});

final searchBarMusicSourceFilterProvider =
    StateProvider((ref) => ref.watch(appPreferencesController).searchEngine);

typedef TracksSelectionControllerProvider = StateNotifierProvider<
    SelectionController<BaseTrack>, SelectionState<BaseTrack>>;
