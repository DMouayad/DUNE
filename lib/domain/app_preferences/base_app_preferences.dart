import 'dart:ui';

import 'package:dune/domain/audio/base_models/base_explore_music_collection.dart';
import 'package:dune/domain/audio/base_models/thumbnails_set.dart';
import 'package:dune/support/enums/audio_streaming_quality.dart';
import 'package:dune/support/enums/initial_page_on_startup.dart';
import 'package:dune/support/enums/music_source.dart';
import 'package:equatable/equatable.dart';

/// Groups a collection of app settings & configurations set by the user.
abstract class BaseAppPreferences extends Equatable {
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

  /// Indicates if last side panel size will be saved
  /// for the next time.
  final bool rememberLastSidePanelSize;
  final double? lastSidePanelWidth;

  /// The order in which it's determined which quality to choose for online
  /// media (Tracks, Albums, Playlists, etc) thumbnail image.
  final ThumbnailQualitiesOrderOption thumbnailQualitiesOrder;

  /// Specifies the streaming quality for online-streamed tracks.
  final AudioStreamingQuality audioStreamingQuality;

  const BaseAppPreferences({
    this.usePrimaryColorInCardColor = true,
    this.initialPageOnStartup = InitialPageOnStartup.exploreMusic,
    this.exploreMusicSource = MusicSource.youtube,
    this.searchEngine = MusicSource.youtube,
    this.volumeStep = 5.0,
    this.tabsMode = TabsMode.vertical,
    this.rememberLastWindowSize = true,
    this.lastWindowSize,
    this.rememberLastSidePanelSize = true,
    this.lastSidePanelWidth,
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
      'rememberLastSidePanelSize': rememberLastSidePanelSize,
      'lastSidePanelWidth': lastSidePanelWidth,
      'tabsMode': tabsMode.name,
      'audioStreamingQuality': audioStreamingQuality,
      'thumbnailQualitiesOrder': thumbnailQualitiesOrder,
    };
  }

  BaseAppPreferences copyWith({
    bool? usePrimaryColorInCardColor,
    InitialPageOnStartup? initialPageOnStartup,
    MusicSource? exploreMusicSource,
    MusicSource? searchEngine,
    double? volumeStep,
    TabsMode? tabsMode,
    Size? lastWindowSize,
    bool? rememberLastWindowSize,
    bool? rememberLastSidePanelSize,
    double? lastSidePanelWidth,
    ThumbnailQualitiesOrderOption? thumbnailQualitiesOrder,
    AudioStreamingQuality? audioStreamingQuality,
  });

  @override
  String toString() {
    return 'BaseAppPreferences{usePrimaryColorInCardColor: $usePrimaryColorInCardColor, initialPageOnStartup: $initialPageOnStartup, exploreMusicSource: $exploreMusicSource, searchEngine: $searchEngine, volumeStep: $volumeStep, tabsMode: $tabsMode, rememberLastWindowSize: $rememberLastWindowSize, lastWindowSize: $lastWindowSize, rememberLastSidePanelSize: $rememberLastSidePanelSize, lastSidePanelWidth: $lastSidePanelWidth, thumbnailQualitiesOrder: $thumbnailQualitiesOrder}';
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
        rememberLastSidePanelSize,
        lastSidePanelWidth,
        tabsMode,
        audioStreamingQuality,
        thumbnailQualitiesOrder,
      ];
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
