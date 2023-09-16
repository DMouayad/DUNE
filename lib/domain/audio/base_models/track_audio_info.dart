import 'package:dune/support/enums/audio_streaming_quality.dart';
import 'package:dune/support/enums/music_source.dart';
import 'package:dune/support/extensions/extensions.dart';
import 'package:equatable/equatable.dart';

/// The metadata of an "audio track".
base class TrackAudioInfo extends Equatable {
  /// This could be the [String] representation of an `Uri` or the
  /// relative/absolute path of the audio file on the device.
  final String? url;

  /// The sample format as string. This uses the same names as used in other places of mpv.
  final String? format;

  /// The sample bitrate per second.
  final double? bitsPerSecond;

  /// The sample kB rate per second.
  double? get kiloBitsPerSecond =>
      bitsPerSecond == null ? null : bitsPerSecond! / 1024;

  /// Overall bits per second.
  final int? overallBitrate;

  /// The number of samples we take per second of this audio.
  /// Note: a sample is a measurement, in kilohertz (kHz),
  /// of a sound wave’s amplitude (signal strength)
  final int? samplingRate;
  final int? bitDepth;

  /// The number of audio channels.
  final int? channels;
  final int? channelMask;

  /// The size of this audio file in Bytes.
  final int? totalBytes;
  final AudioStreamingQuality quality;

  /// The original source from which this audio info was obtained.
  /// Defaults to [MusicSource.unknown] but should be set accordingly.
  final MusicSource musicSource;

  const TrackAudioInfo({
    this.bitsPerSecond,
    this.overallBitrate,
    this.samplingRate,
    this.format,
    this.url,
    this.totalBytes,
    this.bitDepth,
    this.channels,
    this.channelMask,
    this.quality = AudioStreamingQuality.undefined,
    this.musicSource = MusicSource.unknown,
  });

  factory TrackAudioInfo.fromMap(Map<String, dynamic> map) {
    return TrackAudioInfo(
      url: map.whereKey('url') as String?,
      format: map.whereKey('format') as String?,
      bitsPerSecond: map.whereKey('bitsPerSecond') as double?,
      overallBitrate: map.whereKey('overallBitrate') as int?,
      samplingRate: map.whereKey('samplingRate') as int?,
      bitDepth: map.whereKey('bitDepth') as int?,
      channels: map.whereKey('channels') as int?,
      channelMask: map.whereKey('channelMask') as int?,
      totalBytes: map.whereKey('totalBytes') as int?,
      quality: map.whereKey('quality') is String
          ? AudioStreamingQuality.values.byName(map.whereKey('quality'))
          : AudioStreamingQuality.undefined,
      musicSource: map.whereKey('musicSource') is String
          ? MusicSource.values.byName(map.whereKey('musicSource'))
          : MusicSource.unknown,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'url': url,
      'format': format,
      'bitsPerSecond': bitsPerSecond,
      'overallBitrate': overallBitrate,
      'channels': channels,
      'channelMask': channelMask,
      'samplingRate': samplingRate,
      'bitDepth': bitDepth,
      'totalBytes': totalBytes,
      'quality': quality.name,
      'musicSource': musicSource.name,
    };
  }

  @override
  List<Object?> get props => [
        url,
        format,
        bitsPerSecond,
        overallBitrate,
        samplingRate,
        bitDepth,
        quality,
        channels,
        channelMask,
        totalBytes,
        musicSource,
      ];

  TrackAudioInfo copyWith({
    String? url,
    String? format,
    double? bitsPerSecond,
    int? overallBitrate,
    int? samplingRate,
    int? bitDepth,
    int? channels,
    int? channelMask,
    int? totalBytes,
    AudioStreamingQuality? quality,
    MusicSource? musicSource,
  }) {
    return TrackAudioInfo(
      url: url ?? this.url,
      format: format ?? this.format,
      bitsPerSecond: bitsPerSecond ?? this.bitsPerSecond,
      overallBitrate: overallBitrate ?? this.overallBitrate,
      samplingRate: samplingRate ?? this.samplingRate,
      bitDepth: bitDepth ?? this.bitDepth,
      channels: channels ?? this.channels,
      channelMask: channelMask ?? this.channelMask,
      totalBytes: totalBytes ?? this.totalBytes,
      quality: quality ?? this.quality,
      musicSource: musicSource ?? this.musicSource,
    );
  }
}
