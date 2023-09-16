import 'package:dune/domain/audio/base_models/track_audio_info.dart';
import 'package:dune/support/enums/audio_streaming_quality.dart';
import 'package:dune/support/enums/music_source.dart';
import 'package:dune/support/extensions/extensions.dart';
import 'package:isar/isar.dart';

part 'isar_track_audio_info.g.dart';

@Embedded(ignore: {'props', 'derived', 'hashCode', 'stringify'})
final class IsarTrackAudioInfo extends TrackAudioInfo {
  IsarTrackAudioInfo({
    super.bitsPerSecond,
    super.format,
    super.totalBytes,
    super.overallBitrate,
    super.url,
    super.quality,
    super.musicSource,
    super.bitDepth,
    super.samplingRate,
    super.channelMask,
    super.channels,
  });

  @override
  @enumerated
  AudioStreamingQuality get quality => super.quality;

  @override
  @enumerated
  MusicSource get musicSource => super.musicSource;

  @override
  Set<Type> get derived => {TrackAudioInfo};

  factory IsarTrackAudioInfo.fromMap(Map<String, dynamic> map) {
    final instance = IsarTrackAudioInfo(
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
    return instance;
  }
}
