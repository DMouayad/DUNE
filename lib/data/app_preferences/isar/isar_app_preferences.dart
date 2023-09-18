import 'dart:ui';

import 'package:dune/domain/app_preferences/base_app_preferences.dart';
import 'package:dune/support/enums/audio_streaming_quality.dart';
import 'package:dune/support/enums/initial_page_on_startup.dart';
import 'package:dune/support/enums/music_source.dart';
import 'package:dune/support/enums/now_playing_section_display_mode.dart';
import 'package:isar/isar.dart';

part 'isar_app_preferences.g.dart';

@Collection(
    ignore: {'lastWindowSize', 'props', 'hashCode', 'stringify', 'derived'})
class IsarAppPreferences extends BaseAppPreferences {
  Id? id;

  @override
  Set<Type> get derived => {BaseAppPreferences};

  @override
  @enumerated
  InitialPageOnStartup get initialPageOnStartup => super.initialPageOnStartup;

  @override
  @enumerated
  MusicSource get exploreMusicSource => super.exploreMusicSource;

  @override
  @enumerated
  MusicSource get searchEngine => super.searchEngine;

  @override
  @enumerated
  ThumbnailQualitiesOrderOption get thumbnailQualitiesOrder =>
      super.thumbnailQualitiesOrder;

  @override
  @enumerated
  AudioStreamingQuality get audioStreamingQuality =>
      super.audioStreamingQuality;

  final double? lastWindowWidth;
  final double? lastWindowHeight;

  @override
  @enumerated
  TabsMode get tabsMode => super.tabsMode;

  @override
  Size? get lastWindowSize =>
      lastWindowWidth != null && lastWindowHeight != null
          ? Size(lastWindowWidth!, lastWindowHeight!)
          : null;

  IsarAppPreferences({
    this.id,
    this.lastWindowWidth,
    this.lastWindowHeight,
    super.exploreMusicSource,
    super.rememberLastWindowSize,
    super.initialPageOnStartup,
    super.usePrimaryColorInCardColor,
    super.searchEngine,
    super.volumeStep,
    super.tabsMode,
    super.thumbnailQualitiesOrder,
    super.rememberLastSidePanelSize,
    super.lastSidePanelWidth,
    super.audioStreamingQuality,
  });

  @override
  IsarAppPreferences copyWith({
    NowPlayingSectionDisplayMode? defaultNowPlayingSectionDisplayMode,
    bool? usePrimaryColorInCardColor,
    TabsMode? tabsMode,
    InitialPageOnStartup? initialPageOnStartup,
    MusicSource? exploreMusicSource,
    MusicSource? searchEngine,
    double? volumeStep,
    bool? rememberLastWindowSize,
    Size? lastWindowSize,
    ThumbnailQualitiesOrderOption? thumbnailQualitiesOrder,
    bool? rememberLastSidePanelSize,
    double? lastSidePanelWidth,
    AudioStreamingQuality? audioStreamingQuality,
  }) {
    return IsarAppPreferences(
      id: id,
      lastWindowWidth: lastWindowSize?.width ?? lastWindowWidth,
      lastWindowHeight: lastWindowSize?.height ?? lastWindowHeight,
      rememberLastWindowSize:
          rememberLastWindowSize ?? this.rememberLastWindowSize,
      usePrimaryColorInCardColor:
          usePrimaryColorInCardColor ?? this.usePrimaryColorInCardColor,
      initialPageOnStartup: initialPageOnStartup ?? this.initialPageOnStartup,
      exploreMusicSource: exploreMusicSource ?? this.exploreMusicSource,
      volumeStep: volumeStep ?? this.volumeStep,
      tabsMode: tabsMode ?? this.tabsMode,
      searchEngine: searchEngine ?? this.searchEngine,
      thumbnailQualitiesOrder:
          thumbnailQualitiesOrder ?? this.thumbnailQualitiesOrder,
      rememberLastSidePanelSize:
          rememberLastSidePanelSize ?? this.rememberLastSidePanelSize,
      lastSidePanelWidth: lastSidePanelWidth ?? this.lastSidePanelWidth,
      audioStreamingQuality:
          audioStreamingQuality ?? this.audioStreamingQuality,
    );
  }
}
