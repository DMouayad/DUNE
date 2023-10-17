import 'dart:ui';

import 'package:dune/domain/app_preferences/base_app_preferences.dart';
import 'package:dune/support/enums/audio_streaming_quality.dart';
import 'package:dune/support/enums/music_source.dart';
import 'package:dune/support/enums/now_playing_section_display_mode.dart';
import 'package:dune/support/enums/quick_nav_destination.dart';
import 'package:isar/isar.dart';

import 'isar_music_folder.dart';

part 'isar_app_preferences.g.dart';

@Collection(ignore: {
  'lastWindowSize',
  'props',
  'hashCode',
  'stringify',
  'derived',
  'localMusicFolders'
})
class IsarAppPreferences extends BaseAppPreferences {
  Id? id;

  @override
  Set<Type> get derived => {BaseAppPreferences};

  @override
  @enumerated
  QuickNavDestination get initialStartupDestination =>
      super.initialStartupDestination;

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

  final List<IsarMusicFolder> localMusicFoldersList;

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
    this.localMusicFoldersList = const [],
    super.exploreMusicSource,
    super.rememberLastWindowSize,
    super.initialStartupDestination,
    super.usePrimaryColorInCardColor,
    super.searchEngine,
    super.volumeStep,
    super.tabsMode,
    super.thumbnailQualitiesOrder,
    super.sidePanelPinned,
    super.audioStreamingQuality,
    super.autoHideWideScreenAppBarButtons,
  }) : super(localMusicFolders: localMusicFoldersList.toSet());

  @override
  IsarAppPreferences copyWith({
    Set<MusicFolder>? localMusicFolders,
    NowPlayingSectionDisplayMode? defaultNowPlayingSectionDisplayMode,
    bool? usePrimaryColorInCardColor,
    TabsMode? tabsMode,
    QuickNavDestination? initialStartupDestination,
    MusicSource? exploreMusicSource,
    MusicSource? searchEngine,
    double? volumeStep,
    bool? rememberLastWindowSize,
    bool? autoHideWideScreenAppBarButtons,
    Size? lastWindowSize,
    ThumbnailQualitiesOrderOption? thumbnailQualitiesOrder,
    bool? sidePanelPinned,
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
      initialStartupDestination:
          initialStartupDestination ?? this.initialStartupDestination,
      exploreMusicSource: exploreMusicSource ?? this.exploreMusicSource,
      volumeStep: volumeStep ?? this.volumeStep,
      tabsMode: tabsMode ?? this.tabsMode,
      searchEngine: searchEngine ?? this.searchEngine,
      thumbnailQualitiesOrder:
          thumbnailQualitiesOrder ?? this.thumbnailQualitiesOrder,
      sidePanelPinned: sidePanelPinned ?? this.sidePanelPinned,
      autoHideWideScreenAppBarButtons: autoHideWideScreenAppBarButtons ??
          this.autoHideWideScreenAppBarButtons,
      localMusicFoldersList:
          localMusicFolders?.map((e) => IsarMusicFolder.fromBase(e)).toList() ??
              localMusicFoldersList,
      audioStreamingQuality:
          audioStreamingQuality ?? this.audioStreamingQuality,
    );
  }

  factory IsarAppPreferences.fromBase(BaseAppPreferences base) {
    return IsarAppPreferences(
      exploreMusicSource: base.exploreMusicSource,
      sidePanelPinned: base.sidePanelPinned,
      rememberLastWindowSize: base.rememberLastWindowSize,
      usePrimaryColorInCardColor: base.usePrimaryColorInCardColor,
      initialStartupDestination: base.initialStartupDestination,
      autoHideWideScreenAppBarButtons: base.autoHideWideScreenAppBarButtons,
      volumeStep: base.volumeStep,
      tabsMode: base.tabsMode,
      thumbnailQualitiesOrder: base.thumbnailQualitiesOrder,
      lastWindowHeight: base.lastWindowSize?.height,
      lastWindowWidth: base.lastWindowSize?.width,
      audioStreamingQuality: base.audioStreamingQuality,
      searchEngine: base.searchEngine,
      localMusicFoldersList: base.localMusicFolders
          .map((e) => IsarMusicFolder.fromBase(e))
          .toList(),
    );
  }
}
