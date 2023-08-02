import 'package:dune/domain/audio/base_models/base_playlist.dart';
import 'package:dune/domain/audio/base_models/base_playlists_listening_history.dart';
import 'package:isar/isar.dart';

import 'isar_playlist.dart';

part 'isar_playlists_listening_history.g.dart';

@Collection(ignore: {'playlists', 'props', 'derived', 'stringify'})
class IsarPlaylistsListeningHistory
    extends BasePlaylistsListeningHistory<IsarPlaylist> {
  @override
  Set<Type> get derived => {BasePlaylistsListeningHistory};
  Id? id;
  final List<int> isarPlaylistsIds;

  @Index()
  @override
  DateTime get date => super.date;

  IsarPlaylistsListeningHistory({
    required super.date,
    this.id,
    this.isarPlaylistsIds = const [],
    super.items = const [],
  });

  @override
  IsarPlaylistsListeningHistory copyWith({
    Id? id,
    DateTime? date,
    List<IsarPlaylist>? items,
    List<int>? isarPlaylistsIds,
  }) {
    return IsarPlaylistsListeningHistory(
      id: id ?? this.id,
      date: date ?? this.date,
      items: items ?? this.items,
      isarPlaylistsIds: isarPlaylistsIds ?? this.isarPlaylistsIds,
    );
  }

  IsarPlaylistsListeningHistory copyWithAddedPlaylist(IsarPlaylist playlist) {
    return copyWith(
      items: {...items, playlist}.toList(),
      isarPlaylistsIds: <int>{
        ...isarPlaylistsIds,
        playlist.isarId!,
      }.toList(),
    );
  }

  @override
  BasePlaylistsListeningHistory copyWithAddedPlaylists(
    List<IsarPlaylist> items,
  ) {
    return copyWith(
      items: {...this.items, ...items}.toList(),
      isarPlaylistsIds: <int>{
        ...isarPlaylistsIds,
        ...items.map((e) => e.isarId!),
      }.toList(),
    );
  }
}
