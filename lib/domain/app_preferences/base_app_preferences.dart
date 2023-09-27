import 'dart:ui';

import 'package:dune/domain/audio/base_models/base_explore_music_collection.dart';
import 'package:dune/domain/audio/base_models/thumbnails_set.dart';
import 'package:dune/support/enums/audio_streaming_quality.dart';
import 'package:dune/support/enums/initial_page_on_startup.dart';
import 'package:dune/support/enums/music_source.dart';
import 'package:dune/support/extensions/extensions.dart';
import 'package:equatable/equatable.dart';
part 'music_folder.dart';

/// Groups a collection of app settings & configurations set by the user.
class BaseAppPreferences extends Equatable {
  /// If set to [true], the [AppTheme.cardColor] will be a variant of
  /// [ColorScheme.primary] and otherwise it's the default.
  final bool usePrimaryColorInCardColor;

  /// Initial app route
  final InitialPageOnStartup initialPageOnStartup;

  /// The source from which a list of [BaseExploreMusicCollection] will be
  /// obtained for the explore page.
  final MusicSource exploreMusicSource;

  /// The source from which suggestions and search results will be obtained.
  final MusicSource searchEngine;

  final double volumeStep;

  /// Indicates the display mode of the tabs.
  ///
  /// when [tabsMode.isEnabled] is `ture`, the navigation will be somewhat
  /// similar to that of a web browser and if its `false`, it'll the
  /// default navigation behaviour.
  final TabsMode tabsMode;

  /// On a desktop platform, this indicates if last window size will be saved
  /// for the next time.
  final bool rememberLastWindowSize;
  final Size? lastWindowSize;

  /// Indicates if the [SidePanel] should be always visible or not.
  final bool sidePanelPinned;

  /// The order in which it's determined which quality to choose for online
  /// media (Tracks, Albums, Playlists, etc) thumbnail image.
  final ThumbnailQualitiesOrderOption thumbnailQualitiesOrder;

  /// Specifies the streaming quality for online-streamed tracks.
  final AudioStreamingQuality audioStreamingQuality;

  /// The paths to local folders which contains audio files.
  final Set<MusicFolder> localMusicFolders;

  const BaseAppPreferences({
    this.usePrimaryColorInCardColor = true,
    this.initialPageOnStartup = InitialPageOnStartup.exploreMusic,
    this.exploreMusicSource = MusicSource.youtube,
    this.searchEngine = MusicSource.youtube,
    this.volumeStep = 5.0,
    this.tabsMode = TabsMode.vertical,
    this.rememberLastWindowSize = true,
    this.lastWindowSize,
    this.sidePanelPinned = true,
    this.localMusicFolders = const {},
    this.audioStreamingQuality = AudioStreamingQuality.balanced,
    this.thumbnailQualitiesOrder = ThumbnailQualitiesOrderOption.balanced,
  });

  Map<String, dynamic> toMap() {
    return {
      'usePrimaryColorInCardColor': usePrimaryColorInCardColor,
      'initialPageOnStartup': initialPageOnStartup.name,
      'exploreMusicSource': exploreMusicSource.name,
      'searchEngine': searchEngine.name,
      'volumeStep': volumeStep,
      'rememberLastWindowSize': rememberLastWindowSize,
      'lastWindowSize': lastWindowSize,
      'sidePanelPinned': sidePanelPinned,
      'tabsMode': tabsMode.name,
      'audioStreamingQuality': audioStreamingQuality,
      'localMusicFolders': localMusicFolders,
      'thumbnailQualitiesOrder': thumbnailQualitiesOrder,
    };
  }

  @override
  String toString() {
    return 'BaseAppPreferences{usePrimaryColorInCardColor: $usePrimaryColorInCardColor, initialPageOnStartup: $initialPageOnStartup, exploreMusicSource: $exploreMusicSource, searchEngine: $searchEngine, volumeStep: $volumeStep, tabsMode: $tabsMode, rememberLastWindowSize: $rememberLastWindowSize, lastWindowSize: $lastWindowSize, sidePanelPinned: $sidePanelPinned, thumbnailQualitiesOrder: $thumbnailQualitiesOrder, audioStreamingQuality: $audioStreamingQuality, localMusicFolders: $localMusicFolders}';
  }

  @override
  List<Object?> get props => [
        usePrimaryColorInCardColor,
        initialPageOnStartup,
        exploreMusicSource,
        searchEngine,
        volumeStep,
        rememberLastWindowSize,
        lastWindowSize,
        sidePanelPinned,
        tabsMode,
        audioStreamingQuality,
        localMusicFolders,
        thumbnailQualitiesOrder,
      ];

  BaseAppPreferences copyWith({
    bool? usePrimaryColorInCardColor,
    InitialPageOnStartup? initialPageOnStartup,
    MusicSource? exploreMusicSource,
    MusicSource? searchEngine,
    double? volumeStep,
    TabsMode? tabsMode,
    bool? rememberLastWindowSize,
    Size? lastWindowSize,
    bool? sidePanelPinned,
    ThumbnailQualitiesOrderOption? thumbnailQualitiesOrder,
    AudioStreamingQuality? audioStreamingQuality,
    Set<MusicFolder>? localMusicFolders,
  }) {
    return BaseAppPreferences(
      usePrimaryColorInCardColor:
          usePrimaryColorInCardColor ?? this.usePrimaryColorInCardColor,
      initialPageOnStartup: initialPageOnStartup ?? this.initialPageOnStartup,
      exploreMusicSource: exploreMusicSource ?? this.exploreMusicSource,
      searchEngine: searchEngine ?? this.searchEngine,
      volumeStep: volumeStep ?? this.volumeStep,
      tabsMode: tabsMode ?? this.tabsMode,
      rememberLastWindowSize:
          rememberLastWindowSize ?? this.rememberLastWindowSize,
      lastWindowSize: lastWindowSize ?? this.lastWindowSize,
      sidePanelPinned: sidePanelPinned ?? this.sidePanelPinned,
      thumbnailQualitiesOrder:
          thumbnailQualitiesOrder ?? this.thumbnailQualitiesOrder,
      audioStreamingQuality:
          audioStreamingQuality ?? this.audioStreamingQuality,
      localMusicFolders: localMusicFolders ?? this.localMusicFolders,
    );
  }
}

enum ThumbnailQualitiesOrderOption {
  best({
    ThumbnailQuality.max,
    ThumbnailQuality.high,
    ThumbnailQuality.medium,
    ThumbnailQuality.standard,
    ThumbnailQuality.low
  }),
  balanced({
    ThumbnailQuality.medium,
    ThumbnailQuality.high,
    ThumbnailQuality.standard,
    ThumbnailQuality.low,
  }),
  lowest({
    ThumbnailQuality.low,
    ThumbnailQuality.standard,
    ThumbnailQuality.medium,
    ThumbnailQuality.high,
    ThumbnailQuality.max,
  });

  final Set<ThumbnailQuality> qualities;

  const ThumbnailQualitiesOrderOption(this.qualities);
}

/// Represent the current display mode of the tabs feature.
enum TabsMode {
  // Tabs are disabled(not shown).
  disabled,

  /// Tabs are enabled and displayed vertically in the side panel.
  vertical,

  /// Tabs are enabled and displayed horizontally below the title bar.
  horizontal;

  bool get isEnabled => this != disabled;

  bool get isVertical => this == vertical;

  bool get isHorizontal => this == horizontal;
}
