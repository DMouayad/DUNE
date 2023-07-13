import 'package:dune/domain/audio/base_models/track_audio_info.dart';
import 'package:dune/support/enums/audio_streaming_quality.dart';
import 'package:dune/support/enums/music_source.dart';
import 'package:dune/support/logger_service.dart';
import 'package:dune/support/extensions/extensions.dart';
import 'package:equatable/equatable.dart';

class AudioInfoSet extends Equatable {
  final List<TrackAudioInfo> items;

  const AudioInfoSet({this.items = const []});

  Map<String, dynamic> toMap() {
    return {'items': items.map((e) => e.toMap()).toList()};
  }

  factory AudioInfoSet.fromMap(Map<String, dynamic> map) {
    final infosList = map.whereKey('items');
    return AudioInfoSet(
        items: (infosList is Iterable<Map<String, dynamic>>)
            ? infosList.map((e) => TrackAudioInfo.fromMap(e)).toList()
            : []);
  }

  TrackAudioInfo? whereQuality(
    AudioStreamingQuality quality,
    MusicSource source,
  ) {
    final itemsWithSameSource = List<TrackAudioInfo>.from(
        items.where((value) => value.musicSource == source));
    if (itemsWithSameSource.isEmpty) return null;
    final itemWithSameQuality =
        itemsWithSameSource.firstWhereOrNull((e) => e.quality == quality);
    if (itemWithSameQuality != null) return itemWithSameQuality;
    return AudioStreamingQuality.lowQualityGroup.contains(quality)
        ? itemsWithSameSource.firstWhereAnyOrNull((element) => [
              element.quality == AudioStreamingQuality.low,
              element.quality == AudioStreamingQuality.lowest,
              element.quality == AudioStreamingQuality.balanced,
            ])
        : itemsWithSameSource.firstWhereAnyOrNull((element) => [
              element.quality == AudioStreamingQuality.high,
              element.quality == AudioStreamingQuality.best,
            ]);
  }

  factory AudioInfoSet.fromListWithUnknownQuality(
    List<TrackAudioInfo> list,
  ) {
    try {
      List<TrackAudioInfo> _audioInfo = [];
      TrackAudioInfo? lowQualityAudio;
      TrackAudioInfo? lowestQualityAudio;
      TrackAudioInfo? balancedQualityAudio;
      TrackAudioInfo? highQualityAudio;
      TrackAudioInfo bestQualityAudio = list.first;
      for (TrackAudioInfo item in list) {
        if (item.bitrateInKb == null) {
          _audioInfo.add(item);
          continue;
        }

        final isGreaterThanCurrentBest = bestQualityAudio.bitrateInKb != null &&
            item.bitrateInKb! > bestQualityAudio.bitrateInKb!;
        if (isGreaterThanCurrentBest) {
          // Assign high quality to the previous best quality
          // audio and update the best quality audio
          if (lowQualityAudio != null) {
            lowestQualityAudio =
                lowQualityAudio.copyWith(quality: AudioStreamingQuality.lowest);
          }
          if (balancedQualityAudio != null) {
            lowQualityAudio = balancedQualityAudio.copyWith(
                quality: AudioStreamingQuality.low);
          }
          if (highQualityAudio != null) {
            balancedQualityAudio = highQualityAudio.copyWith(
                quality: AudioStreamingQuality.balanced);
          }

          highQualityAudio =
              bestQualityAudio.copyWith(quality: AudioStreamingQuality.high);
          bestQualityAudio = item.copyWith(quality: AudioStreamingQuality.best);

          continue;
        }
        final isGreaterThanCurrentHigh =
            highQualityAudio?.bitrateInKb != null &&
                item.bitrateInKb! > highQualityAudio!.bitrateInKb!;
        if (isGreaterThanCurrentHigh) {
          if (lowQualityAudio != null) {
            lowestQualityAudio =
                lowQualityAudio.copyWith(quality: AudioStreamingQuality.lowest);
          }
          if (balancedQualityAudio != null) {
            lowQualityAudio = balancedQualityAudio.copyWith(
                quality: AudioStreamingQuality.low);
          }
          // Assign balanced quality to the previous high quality
          // audio and update the high quality audio
          balancedQualityAudio = highQualityAudio.copyWith(
              quality: AudioStreamingQuality.balanced);
          highQualityAudio = item.copyWith(quality: AudioStreamingQuality.high);
          continue;
        }
        final isGreaterThanCurrentBalanced =
            balancedQualityAudio?.bitrateInKb != null &&
                item.bitrateInKb! > balancedQualityAudio!.bitrateInKb!;
        if (isGreaterThanCurrentBalanced) {
          if (lowQualityAudio != null) {
            lowestQualityAudio =
                lowQualityAudio.copyWith(quality: AudioStreamingQuality.lowest);
          }
          // Assign low quality to the previous balanced quality
          // audio and update the balanced quality audio
          lowQualityAudio =
              balancedQualityAudio.copyWith(quality: AudioStreamingQuality.low);
          balancedQualityAudio =
              item.copyWith(quality: AudioStreamingQuality.balanced);
          continue;
        }
        final isGreaterThanCurrentLow = lowQualityAudio?.bitrateInKb != null &&
            item.bitrateInKb! > lowQualityAudio!.bitrateInKb!;
        if (isGreaterThanCurrentLow) {
          // Assign lowest quality to the current low quality
          // audio and update the low quality audio

          lowestQualityAudio =
              lowQualityAudio.copyWith(quality: AudioStreamingQuality.lowest);
          lowQualityAudio = item.copyWith(quality: AudioStreamingQuality.low);
          continue;
        }

        final isGreaterThanCurrentLowest =
            lowestQualityAudio?.bitrateInKb != null &&
                item.bitrateInKb! > lowestQualityAudio!.bitrateInKb!;
        if (isGreaterThanCurrentLowest) {
          lowQualityAudio = item.copyWith(quality: AudioStreamingQuality.low);
          continue;
        }
        if (lowestQualityAudio == null &&
            (item.bitrateInKb! < bestQualityAudio.bitrateInKb!)) {
          lowestQualityAudio =
              item.copyWith(quality: AudioStreamingQuality.lowest);
        } else {
          _audioInfo.add(item);
        }
      }
      return AudioInfoSet(
          items: {
        ..._audioInfo,
        if (balancedQualityAudio != null) balancedQualityAudio,
        if (highQualityAudio != null) highQualityAudio,
        if (lowestQualityAudio != null) lowestQualityAudio,
        if (lowQualityAudio != null) lowQualityAudio,
        bestQualityAudio,
      }.toList());
    } catch (e) {
      Log.e(e);
      return const AudioInfoSet();
    }
  }

  @override
  String toString() {
    return '$runtimeType: {items: [${items.map((e) => e.toString()).toList()}]}';
  }

  @override
  List<Object?> get props => [items];
}
