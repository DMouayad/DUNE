import 'package:dune/domain/audio/base_models/audio_info_set.dart';
import 'package:dune/support/extensions/extensions.dart';
import 'package:isar/isar.dart';

import 'isar_track_audio_info.dart';

part 'isar_audio_info_set.g.dart';

@Embedded(ignore: {'items', 'props', 'derived', 'hashCode', 'stringify', 'any'})
class IsarAudioInfoSet extends AudioInfoSet {
  final List<IsarTrackAudioInfo> isarAudioInfoList;

  @override
  Set<Type> get derived => {AudioInfoSet};

  @override
  List<IsarTrackAudioInfo> get items => isarAudioInfoList;

  IsarAudioInfoSet({this.isarAudioInfoList = const []})
      : super(items: isarAudioInfoList);

  factory IsarAudioInfoSet.fromMap(Map<String, dynamic> map) {
    return IsarAudioInfoSet(
      isarAudioInfoList: map.whereKey('items') is Iterable<Map<String, dynamic>>
          ? (map.whereKey('items') as Iterable<Map<String, dynamic>>)
              .map((e) => IsarTrackAudioInfo.fromMap(e))
              .toList()
          : [],
    );
  }

  static IsarAudioInfoSet? from(AudioInfoSet? audioInfo) {
    if (audioInfo == null) return null;
    final items = audioInfo.items
        .map((e) => IsarTrackAudioInfo(
              bitrateInKb: e.bitrateInKb,
              format: e.format,
              totalBytes: e.totalBytes,
              url: e.url,
              musicSource: e.musicSource,
              quality: e.quality,
            ))
        .toList();
    return IsarAudioInfoSet(isarAudioInfoList: items);
  }
}
