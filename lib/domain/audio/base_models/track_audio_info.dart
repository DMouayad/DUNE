import 'package:dune/support/enums/audio_streaming_quality.dart';
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

  const TrackAudioInfo({
    this.format,
    this.url,
    this.totalBytes,
    this.bitrateInKb,
    this.quality = AudioStreamingQuality.undefined,
  });

  Map<String, dynamic> toMap() {
    return {
      'url': url,
      'format': format,
      'bitrateInKb': bitrateInKb,
      'totalBytes': totalBytes,
    };
  }

  factory TrackAudioInfo.fromMap(Map<String, dynamic> map) {
    return TrackAudioInfo(
      url: map['url'] as String?,
      format: map['format'] as String?,
      bitrateInKb: map['bitrateInKb'] as double?,
      totalBytes: map['totalBytes'] as int?,
    );
  }

  @override
  List<Object?> get props => [url, format, bitrateInKb, totalBytes];

  TrackAudioInfo copyWith({
    String? url,
    String? format,
    double? bitrateInKb,
    int? totalBytes,
    AudioStreamingQuality? quality,
  }) {
    return TrackAudioInfo(
      url: url ?? this.url,
      format: format ?? this.format,
      bitrateInKb: bitrateInKb ?? this.bitrateInKb,
      totalBytes: totalBytes ?? this.totalBytes,
      quality: quality ?? this.quality,
    );
  }
}
