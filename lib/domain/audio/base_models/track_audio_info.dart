import 'package:dune/support/enums/audio_streaming_quality.dart';
import 'package:dune/support/enums/music_source.dart';
import 'package:dune/support/extensions/extensions.dart';
import 'package:equatable/equatable.dart';

base class TrackAudioInfo extends Equatable {
  /// This could be the [String] representation of an `Uri` or the
  /// relative/full path of the audio file on the device.
  final String? url;

  /// The sample format as string. This uses the same names as used in other places of mpv.
  final String? format;

  /// Sample bit rate in KiloBits/s.
  final double? bitrateInKb;

  /// The size of this audio file in Bytes.
  final int? totalBytes;
  final AudioStreamingQuality quality;

  /// The original source from which this audio info was obtained.
  /// Defaults to [MusicSource.unknown] but should be set accordingly.
  final MusicSource musicSource;

  const TrackAudioInfo({
    this.format,
    this.url,
    this.totalBytes,
    this.bitrateInKb,
    this.quality = AudioStreamingQuality.undefined,
    this.musicSource = MusicSource.unknown,
  });

  factory TrackAudioInfo.fromMap(Map<String, dynamic> map) {
    return TrackAudioInfo(
      url: map.whereKey('url') as String?,
      format: map.whereKey('format') as String?,
      bitrateInKb: map.whereKey('bitrateInKb') as double?,
      totalBytes: map.whereKey('totalBytes') as int?,
      musicSource: map.whereKey('musicSource') is String
          ? MusicSource.values.byName(map.whereKey('musicSource'))
          : MusicSource.unknown,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'url': url,
      'format': format,
      'bitrateInKb': bitrateInKb,
      'totalBytes': totalBytes,
      'musicSource': musicSource.name,
    };
  }

  @override
  List<Object?> get props =>
      [url, format, bitrateInKb, totalBytes, musicSource];

  TrackAudioInfo copyWith({
    String? url,
    String? format,
    double? bitrateInKb,
    int? totalBytes,
    AudioStreamingQuality? quality,
    MusicSource? musicSource,
  }) {
    return TrackAudioInfo(
      url: url ?? this.url,
      format: format ?? this.format,
      bitrateInKb: bitrateInKb ?? this.bitrateInKb,
      totalBytes: totalBytes ?? this.totalBytes,
      quality: quality ?? this.quality,
      musicSource: musicSource ?? this.musicSource,
    );
  }
}
