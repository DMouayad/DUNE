import 'package:dune/domain/audio/base_models/track_audio_info.dart';
import 'package:dune/support/enums/audio_streaming_quality.dart';
import 'package:dune/support/enums/music_source.dart';
import 'package:dune/support/extensions/extensions.dart';
import 'package:isar/isar.dart';

part 'isar_track_audio_info.g.dart';

@Embedded(ignore: {'props', 'derived', 'hashCode', 'stringify'})
final class IsarTrackAudioInfo extends TrackAudioInfo {
  IsarTrackAudioInfo({
    super.bitrateInKb,
    super.format,
    super.totalBytes,
    super.url,
    super.quality,
    super.musicSource,
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
      url: map.whereKey('url'),
      format: map.whereKey('format'),
      bitrateInKb: map.whereKey('bitrateInKb'),
      totalBytes: map.whereKey('totalBytes'),
      musicSource: map.whereKey('musicSource') is String
          ? MusicSource.values.byName(map.whereKey('musicSource'))
          : MusicSource.unknown,
    );
    return instance;
  }
}
