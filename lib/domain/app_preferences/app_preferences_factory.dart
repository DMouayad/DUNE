import 'dart:ui';

import 'package:dune/domain/app_preferences/base_app_preferences.dart';
import 'package:dune/support/enums/audio_streaming_quality.dart';
import 'package:dune/support/enums/initial_page_on_startup.dart';
import 'package:dune/support/enums/music_source.dart';
import 'package:faker/faker.dart';

import '../base_model_factory.dart';

final class AppPreferencesFactory extends BaseModelFactory<BaseAppPreferences> {
  late final bool? usePrimaryColorInCardColor;

  late final InitialPageOnStartup? initialPageOnStartup;

  late final MusicSource? exploreMusicSource;

  late final MusicSource? searchEngine;

  late final double? volumeStep;

  late final TabsMode? tabsMode;
  late final bool? rememberLastWindowSize;
  late final Size? lastWindowSize;

  late final bool? sidePanelPinned;
  late final double? lastSidePanelWidth;

  late final ThumbnailQualitiesOrderOption? thumbnailQualitiesOrder;

  late final AudioStreamingQuality? audioStreamingQuality;

  late final Set<MusicFolder>? localMusicFolders;

  AppPreferencesFactory() {
    usePrimaryColorInCardColor = initialPageOnStartup = exploreMusicSource =
        searchEngine = volumeStep = tabsMode = rememberLastWindowSize =
            lastWindowSize = sidePanelPinned = lastSidePanelWidth =
                thumbnailQualitiesOrder =
                    audioStreamingQuality = localMusicFolders = null;
  }

  @override
  BaseAppPreferences create() {
    return BaseAppPreferences(
      localMusicFolders: localMusicFolders ?? {},
      audioStreamingQuality: audioStreamingQuality ??
          faker.randomGenerator.element(AudioStreamingQuality.values),
      lastWindowSize: lastWindowSize ?? _getRandomSize(),
      sidePanelPinned: sidePanelPinned ?? faker.randomGenerator.boolean(),
      rememberLastWindowSize:
          rememberLastWindowSize ?? faker.randomGenerator.boolean(),
      exploreMusicSource: exploreMusicSource ??
          faker.randomGenerator.element(MusicSource.valuesWithoutUnknown),
      initialPageOnStartup:
          faker.randomGenerator.element(InitialPageOnStartup.values),
      searchEngine: searchEngine ??
          faker.randomGenerator.element(MusicSource.valuesWithoutUnknown),
      tabsMode: tabsMode ?? faker.randomGenerator.element(TabsMode.values),
      thumbnailQualitiesOrder: thumbnailQualitiesOrder ??
          faker.randomGenerator.element(ThumbnailQualitiesOrderOption.values),
      usePrimaryColorInCardColor:
          usePrimaryColorInCardColor ?? faker.randomGenerator.boolean(),
      volumeStep: volumeStep ?? faker.randomGenerator.integer(100).toDouble(),
    );
  }

  Size _getRandomSize() {
    final dimensions =
        faker.randomGenerator.numbers(2400, 2).map((e) => e.toDouble());
    return Size(dimensions.elementAt(0), dimensions.elementAt(1));
  }
}
