import 'package:dune/data/audio/isar/data_sources/isar_album_data_source.dart';
import 'package:dune/data/audio/isar/data_sources/isar_artist_data_source.dart';
import 'package:dune/data/audio/isar/data_sources/isar_play_history_data_source.dart';
import 'package:dune/data/audio/isar/data_sources/isar_playlist_data_source.dart';
import 'package:dune/data/audio/isar/data_sources/isar_track_data_source.dart';
import 'package:dune/data/audio/isar/helpers/isar_models_relation_helper.dart';
import 'package:dune/data/audio/isar/repositories/isar_playlist_repository.dart';
import 'package:dune/domain/audio/facades/music_facade.dart';
import 'package:dune/domain/audio/repositories/base_user_listening_history_repository.dart';
import 'package:dune/domain/audio/repositories/playlist_repository.dart';
import 'package:dune/domain/audio/repositories/track_repository.dart';
import 'package:isar/isar.dart';

import 'isar_album_repository.dart';
import 'isar_artist_repository.dart';
import 'isar_track_repository.dart';
import 'isar_user_listening_history_repository.dart';

final class IsarMusicRepository implements CacheMusicRepository {
  IsarMusicRepository({required Isar isar}) {
    final trackDataSource = IsarTrackDataSource(isar);
    final artistDataSource = IsarArtistDataSource(isar);
    final playlistDataSource = IsarPlaylistDataSource(isar);
    final albumDataSource = IsarAlbumDataSource(isar);
    final listeningHistoryDataSource = IsarListeningHistoryDataSource(isar);

    _relationHelper = IsarModelsRelationHelper(
      trackDataSource,
      artistDataSource,
      albumDataSource,
      playlistDataSource,
      listeningHistoryDataSource,
      isar,
    );
    _albums = IsarAlbumRepository(albumDataSource, _relationHelper);
    _artists = IsarArtistRepository(artistDataSource, _relationHelper);
    _tracks = IsarTrackRepository(
        _albums, _artists, trackDataSource, _relationHelper);
    _playlists =
        IsarPlaylistRepository(playlistDataSource, _tracks, _relationHelper);
    _listeningHistory = IsarUserListeningHistoryRepository(
        listeningHistoryDataSource, _relationHelper, _tracks, _playlists);
  }

  late final IsarPlaylistRepository _playlists;
  late final IsarTrackRepository _tracks;
  late final IsarArtistRepository _artists;
  late final IsarAlbumRepository _albums;
  late final IsarUserListeningHistoryRepository _listeningHistory;
  late final IsarModelsRelationHelper _relationHelper;

  @override
  SavablePlaylistRepository get playlists => _playlists;

  @override
  SavableTrackRepository get tracks => _tracks;

  BaseUserListeningHistoryRepository get listeningHistory => _listeningHistory;

  @override
  get albums => _albums;

  @override
  get artists => _artists;

  @override
  // TODO: implement search
  get search => throw UnimplementedError();
}
