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

  /// Whether to show newly opened pages in a tab view or use the default
  /// navigation methode.
  final bool tabsModeEnabled;

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
    this.tabsModeEnabled = true,
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
      'tabsModeEnabled': tabsModeEnabled,
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
    bool? tabsModeEnabled,
    Size? lastWindowSize,
    bool? rememberLastWindowSize,
    bool? rememberLastSidePanelSize,
    double? lastSidePanelWidth,
    ThumbnailQualitiesOrderOption? thumbnailQualitiesOrder,
    AudioStreamingQuality? audioStreamingQuality,
  });

  @override
  String toString() {
    return 'BaseAppPreferences{usePrimaryColorInCardColor: $usePrimaryColorInCardColor, initialPageOnStartup: $initialPageOnStartup, exploreMusicSource: $exploreMusicSource, searchEngine: $searchEngine, volumeStep: $volumeStep, tabsModeEnabled: $tabsModeEnabled, rememberLastWindowSize: $rememberLastWindowSize, lastWindowSize: $lastWindowSize, rememberLastSidePanelSize: $rememberLastSidePanelSize, lastSidePanelWidth: $lastSidePanelWidth, thumbnailQualitiesOrder: $thumbnailQualitiesOrder}';
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
        tabsModeEnabled,
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
