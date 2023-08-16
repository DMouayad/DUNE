import 'package:dune/data/audio/isar/data_sources/isar_album_data_source.dart';
import 'package:dune/data/audio/isar/data_sources/isar_artist_data_source.dart';
import 'package:dune/data/audio/isar/data_sources/isar_listening_history_month_summary_data_source.dart';
import 'package:dune/data/audio/isar/data_sources/isar_playlist_data_source.dart';
import 'package:dune/data/audio/isar/data_sources/isar_playlists_listening_history_data_source.dart';
import 'package:dune/data/audio/isar/data_sources/isar_track_data_source.dart';
import 'package:dune/data/audio/isar/data_sources/isar_track_listening_history_data_source.dart';
import 'package:dune/data/audio/isar/helpers/isar_models_relation_helper.dart';
import 'package:dune/data/audio/isar/repositories/isar_listening_history_month_summary_repository.dart';
import 'package:dune/data/audio/isar/repositories/isar_playlist_repository.dart';
import 'package:dune/data/audio/isar/repositories/isar_playlists_listening_history_repository.dart';
import 'package:dune/data/audio/isar/repositories/isar_tracks_listening_history_repository.dart';
import 'package:dune/domain/audio/repositories/base_music_repository.dart';
import 'package:dune/domain/audio/repositories/listening_history_repository.dart';
import 'package:dune/domain/audio/repositories/local_music_library_repository.dart';
import 'package:dune/domain/audio/repositories/playlist_repository.dart';
import 'package:isar/isar.dart';

import 'isar_album_repository.dart';
import 'isar_artist_repository.dart';
import 'isar_track_repository.dart';

final class IsarMusicRepository implements BaseLocalMusicRepository {
  IsarMusicRepository({required Isar isar}) {
    final trackDataSource = IsarTrackDataSource(isar);
    final artistDataSource = IsarArtistDataSource(isar);
    final playlistDataSource = IsarPlaylistDataSource(isar);
    final albumDataSource = IsarAlbumDataSource(isar);
    final tracksListeningHistoryDS = IsarTrackListeningHistoryDataSource(isar);
    final playlistsListeningHistoryDS =
        IsarPlaylistsListeningHistoryDataSource(isar);
    final listeningHistoryMonthSummaryDS =
        IsarListeningHistoryMonthSummaryDataSource(isar);
    _relationHelper = IsarModelsRelationHelper(
      trackDataSource,
      artistDataSource,
      albumDataSource,
      playlistDataSource,
    );
    _albums = IsarAlbumRepository(albumDataSource, _relationHelper);
    _artists = IsarArtistRepository(artistDataSource, _relationHelper);
    _tracks = IsarTrackRepository(
        _albums, _artists, trackDataSource, _relationHelper);
    _playlists =
        IsarPlaylistRepository(playlistDataSource, _tracks, _relationHelper);
    _listeningHistory = ListeningHistoryRepository(
      _playlists,
      _tracks,
      IsarTracksListeningHistoryRepository(
        tracksListeningHistoryDS,
        _relationHelper,
      ),
      IsarPlaylistsListeningHistoryRepository(
        playlistsListeningHistoryDS,
        _relationHelper,
      ),
      IsarListeningHistoryMonthSummaryRepository(
        tracksListeningHistoryDS,
        listeningHistoryMonthSummaryDS,
        _relationHelper,
        isar,
      ),
    );
    _localMusicLibrary =
        LocalMusicLibraryRepository(_tracks, _albums, _artists, _playlists);
  }

  late final IsarPlaylistRepository _playlists;
  late final IsarTrackRepository _tracks;
  late final IsarArtistRepository _artists;
  late final IsarAlbumRepository _albums;
  late final ListeningHistoryRepository _listeningHistory;
  late final LocalMusicLibraryRepository _localMusicLibrary;
  late final IsarModelsRelationHelper _relationHelper;

  @override
  SavablePlaylistRepository get playlists => _playlists;

  @override
  IsarTrackRepository get tracks => _tracks;

  ListeningHistoryRepository get listeningHistory => _listeningHistory;

  @override
  get albums => _albums;

  @override
  get artists => _artists;

  @override
  // TODO: implement search
  get search => throw UnimplementedError();

  @override
  LocalMusicLibraryRepository get localMusicLibrary => _localMusicLibrary;
}
