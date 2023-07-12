import 'package:dune/domain/audio/base_models/base_user_playlist.dart';
import 'package:isar/isar.dart';

import 'isar_duration.dart';

part 'isar_user_playlist.g.dart';

@Collection(ignore: {'tracks', 'length'})
class IsarUserPlaylist extends BaseUserPlaylist {
  Id? id;
  final int? playlistId;
  final DateTime? createdAtDate;
  final IsarDuration isarLength;

  IsarUserPlaylist({
    this.playlistId,
    this.createdAtDate,
    this.isarLength = const IsarDuration(),
    super.title = '',
    super.tracks = const {},
  }) : super(
          createdAt: createdAtDate ?? DateTime.now(),
          length: Duration(seconds: isarLength.inSeconds),
        );
}
