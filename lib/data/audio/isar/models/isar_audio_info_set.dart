import 'package:dune/domain/audio/base_models/audio_info_set.dart';
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
}
