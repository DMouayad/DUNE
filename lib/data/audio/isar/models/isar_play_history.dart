import 'package:dune/domain/audio/base_models/base_album.dart';
import 'package:dune/domain/audio/base_models/base_artist.dart';
import 'package:dune/domain/audio/base_models/base_play_history.dart';
import 'package:isar/isar.dart';

import 'isar_playlist.dart';
import 'isar_track_record.dart';

part 'isar_play_history.g.dart';

@Collection(ignore: {'tracks', 'playlists', 'artists', 'albums'})
class IsarListeningHistory
    extends BaseListeningHistory<IsarTrackRecord, IsarPlaylist> {
  Id? id;
  final List<int> isarTrackRecordsIds;
  final List<int> isarPlaylistsIds;

  late final List<BaseAlbum> _albums;
  late final List<BaseArtist> _artists;

  IsarListeningHistory({
    required super.date,
    this.id,
    this.isarPlaylistsIds = const [],
    this.isarTrackRecordsIds = const [],
    super.tracks = const [],
    super.playlists = const [],
  }) {
    _albums = ListeningHistoryDataExtractor.getAlbumsFromTracks(tracks);
    _artists = ListeningHistoryDataExtractor.getArtistsFromTracks(tracks);
  }

  IsarListeningHistory copyWith({
    Id? id,
    DateTime? date,
    List<IsarTrackRecord>? tracks,
    List<IsarPlaylist>? playlists,
    List<int>? isarTrackRecordsIds,
    List<int>? isarPlaylistsIds,
  }) {
    return IsarListeningHistory(
      id: id ?? this.id,
      date: date ?? this.date,
      tracks: tracks ?? this.tracks,
      playlists: playlists ?? this.playlists,
      isarTrackRecordsIds: isarTrackRecordsIds ?? this.isarTrackRecordsIds,
      isarPlaylistsIds: isarPlaylistsIds ?? this.isarPlaylistsIds,
    );
  }

  IsarListeningHistory copyWithAddedPlaylist(IsarPlaylist playlist) {
    return copyWith(playlists: {...playlists, playlist}.toList());
  }

  IsarListeningHistory copyWithAddedTrack(
    IsarTrackRecord trackRecord,
  ) {
    return copyWith(tracks: {...tracks, trackRecord}.toList());
  }

  @override
  List<BaseAlbum> get albums => _albums;

  @override
  List<BaseArtist> get artists => _artists;
}
