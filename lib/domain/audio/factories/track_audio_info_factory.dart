import 'package:dune/domain/audio/base_models/track_audio_info.dart';
import 'package:dune/support/enums/audio_streaming_quality.dart';
import 'package:dune/support/enums/music_source.dart';
import 'package:faker/faker.dart';

import 'base_model_factory.dart';

final class TrackAudioInfoFactory extends BaseModelFactory<TrackAudioInfo> {
  late final String? _url;
  late final String? _format;
  late final double? _bitrateInKb;
  late final int? _totalBytes;
  late final AudioStreamingQuality? _quality;
  late final MusicSource? _musicSource;

  @override
  TrackAudioInfo create() {
    return TrackAudioInfo(
      quality: _quality ??
          faker.randomGenerator.element(AudioStreamingQuality.values),
      url: _url ?? faker.internet.httpsUrl(),
      format: _format ?? faker.lorem.word(),
      musicSource: _musicSource ??
          faker.randomGenerator.element(MusicSource.valuesWithoutUnknown),
      bitsPerSecond:
          _bitrateInKb ?? faker.randomGenerator.integer(320).toDouble(),
      totalBytes:
          _totalBytes ?? faker.randomGenerator.integer(3000000, min: 20000),
    );
  }

  TrackAudioInfoFactory() {
    _url =
        _format = _bitrateInKb = _totalBytes = _quality = _musicSource = null;
  }

  TrackAudioInfoFactory setMusicSource(MusicSource source) {
    return _copyWith(musicSource: source);
  }

  TrackAudioInfoFactory._({
    required String? url,
    required String? format,
    required double? bitrateInKb,
    required int? totalBytes,
    required AudioStreamingQuality? quality,
    required MusicSource? musicSource,
  })  : _url = url,
        _format = format,
        _bitrateInKb = bitrateInKb,
        _totalBytes = totalBytes,
        _quality = quality,
        _musicSource = musicSource;

  TrackAudioInfoFactory _copyWith({
    String? url,
    String? format,
    double? bitrateInKb,
    int? totalBytes,
    AudioStreamingQuality? quality,
    MusicSource? musicSource,
  }) {
    return TrackAudioInfoFactory._(
      url: url ?? _url,
      format: format ?? _format,
      bitrateInKb: bitrateInKb ?? _bitrateInKb,
      totalBytes: totalBytes ?? _totalBytes,
      quality: quality ?? _quality,
      musicSource: musicSource ?? _musicSource,
    );
  }
}
