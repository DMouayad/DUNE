import 'package:dune/domain/audio/base_models/audio_info_set.dart';
import 'package:dune/domain/audio/base_models/track_audio_info.dart';
import 'package:dune/support/enums/music_source.dart';

import 'base_model_factory.dart';
import 'track_audio_info_factory.dart';

final class AudioInfoSetFactory extends BaseModelFactory<AudioInfoSet> {
  late final List<TrackAudioInfo>? _items;

  AudioInfoSetFactory() {
    _items = [];
  }

  @override
  AudioInfoSet create() {
    return AudioInfoSet.fromListWithUnknownQuality(_items ?? []);
  }

  AudioInfoSetFactory setItems(int count, MusicSource source) {
    return _copyWith(
      items: TrackAudioInfoFactory().setMusicSource(source).createCount(count),
    );
  }

  AudioInfoSetFactory._({required List<TrackAudioInfo>? items})
      : _items = items;

  AudioInfoSetFactory _copyWith({
    List<TrackAudioInfo>? items,
  }) {
    return AudioInfoSetFactory._(
      items: items ?? _items,
    );
  }
}
