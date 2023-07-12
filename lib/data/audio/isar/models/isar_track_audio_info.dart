import 'package:dune/domain/audio/base_models/track_audio_info.dart';
import 'package:dune/support/enums/audio_streaming_quality.dart';
import 'package:dune/support/enums/music_source.dart';
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
  });

  @override
  @enumerated
  AudioStreamingQuality get quality => super.quality;

  @override
  @enumerated
  MusicSource get musicSource => super.musicSource;

  @override
  Set<Type> get derived => {TrackAudioInfo};
}
