import 'package:dune/data/audio/isar/data_sources/isar_album_data_source.dart';
import 'package:dune/data/audio/isar/data_sources/isar_playlist_data_source.dart';
import 'package:dune/data/audio/isar/models/isar_album.dart';
import 'package:dune/data/audio/isar/models/isar_artist.dart';
import 'package:dune/data/audio/isar/models/isar_play_history.dart';
import 'package:dune/data/audio/isar/models/isar_playlist.dart';
import 'package:dune/data/audio/isar/models/isar_track.dart';
import 'package:dune/data/audio/isar/models/isar_track_record.dart';
import 'package:dune/support/logger_service.dart';
import 'package:dune/support/utils/result/result.dart';
import 'package:isar/isar.dart';

import '../data_sources/isar_artist_data_source.dart';
import '../data_sources/isar_play_history_data_source.dart';
import '../data_sources/isar_track_data_source.dart';

final class IsarModelsRelationHelper {
  final IsarTrackDataSource _trackDataSource;
  final IsarArtistDataSource _artistDataSource;
  final IsarPlaylistDataSource _playlistDataSource;
  final IsarAlbumDataSource _albumDataSource;
  final IsarListeningHistoryDataSource _listeningHistoryDataSource;
  final Isar _isar;

  IsarModelsRelationHelper(
    this._trackDataSource,
    this._artistDataSource,
    this._albumDataSource,
    this._playlistDataSource,
    this._listeningHistoryDataSource,
    this._isar,
  );

  FutureResult<List<IsarListeningHistory>> loadRelationsForPlayHistories(
    List<IsarListeningHistory> histories,
  ) async {
    return await _loadRelationsForMany(
      histories,
      loadRelationsForListeningHistory,
      itemRelationsAlreadyLoaded: (_) => false,
    );
  }

  FutureResult<IsarListeningHistory> loadRelationsForListeningHistory(
    IsarListeningHistory history, {
    List<int> ignoredTracksIds = const [],
    List<int> ignoredPlaylistsIds = const [],
  }) async {
    final playlistsIds = List<int>.from(history.isarPlaylistsIds);
    playlistsIds.removeWhere((e) => ignoredPlaylistsIds.contains(e));
    final fetchingPlaylistsResult =
        await _playlistDataSource.getWhereIsarId(playlistsIds);
    if (fetchingPlaylistsResult.isFailure) {
      return fetchingPlaylistsResult.mapFailure((error) => error);
    }

    final tracksRecordsIds = List<int>.from(history.isarTrackRecordsIds);
    tracksRecordsIds.removeWhere((e) => ignoredTracksIds.contains(e));

    final fetchingTracksRecordsResult =
        await _listeningHistoryDataSource.getTrackRecords(tracksRecordsIds);
    if (fetchingTracksRecordsResult.isFailure) {
      return fetchingTracksRecordsResult.mapFailure((error) => error);
    }
    final tracksRecords = fetchingTracksRecordsResult.requireValue;

    return (await loadRelationsForTracksRecords(tracksRecords)).mapSuccess(
      (value) => history.copyWith(
        tracks: value,
        playlists: fetchingPlaylistsResult.requireValue,
      ),
    );
  }

  FutureResult<List<IsarTrackRecord>> loadRelationsForTracksRecords(
    List<IsarTrackRecord> tracksRecords,
  ) async {
    return await _loadRelationsForMany(
      tracksRecords,
      loadRelationsForTrackRecord,
      itemRelationsAlreadyLoaded: (record) => record.track != null,
    );
  }

  FutureResult<List<IsarPlaylist>> loadRelationsForPlaylists(
      List<IsarPlaylist> playlists,
      {required bool loadTracksRelations}) async {
    return await _loadRelationsForMany(
      playlists,
      (e) => loadRelationsForPlaylist(e, loadTracksRelations),
      itemRelationsAlreadyLoaded: (p) => false,
    );
  }

  FutureResult<IsarTrackRecord> loadRelationsForTrackRecord(
    IsarTrackRecord trackRecord,
  ) async {
    return await Result.fromAnother(() async {
      final track = await _isar.isarTracks
          .where()
          .optional(trackRecord.trackId != null,
              (q) => q.idEqualTo(trackRecord.trackId!))
          .findFirst();

      if (track == null) {
        Log.e(
          "The [IsarTrack] with id ${trackRecord.trackId} associated with this [IsarTrackRecord] was not found!!",
        );
        return trackRecord.asResult;
      } else {
        return (await loadRelationsForTrack(track)).mapSuccess(
          (value) => trackRecord.copyWith(track: track),
        );
      }
    });
  }

  FutureResult<List<IsarArtist>> loadRelationsForArtists(
    List<IsarArtist> artists, {
    String? trackIdToIgnore,
  }) async {
    return _loadRelationsForMany(
      artists,
      (a) => loadRelationsForArtist(a, trackIdToIgnore: trackIdToIgnore),
      itemRelationsAlreadyLoaded: (a) => a.tracks.isNotEmpty,
    );
  }

  /// Attaches a list of the [artist] tracks to [artist.tracks] and returns it.
  FutureResult<IsarArtist> loadRelationsForArtist(
    IsarArtist artist, {
    String? trackIdToIgnore,
  }) async {
    return await Result.fromAnother(() async {
      late List<IsarTrack> tracks;
      if (artist.tracks.isNotEmpty && artist.tracks is List<IsarTrack>) {
        tracks = artist.tracks.cast<IsarTrack>();
      } else {
        final artistTracksIds = List<String>.from(artist.tracksIds);
        artistTracksIds.remove(trackIdToIgnore);
        if (artistTracksIds.isEmpty) {
          return artist.asResult;
        }
        final fetchingTracksResult =
            await _trackDataSource.getWhereIds(artistTracksIds);
        if (fetchingTracksResult.isFailure) {
          return fetchingTracksResult.mapFailure((error) => error);
        }
        tracks = fetchingTracksResult.asSuccess.value;
      }
      return artist.copyWith(tracks: tracks).asResult;
    });
  }

  FutureResult<IsarPlaylist> loadRelationsForPlaylist(
    IsarPlaylist playlist,
    bool loadTracksRelations,
  ) async {
    return await Result.fromAnother(() async {
      final playlistTracksIds = playlist.tracksIds;
      if (playlistTracksIds.isNotEmpty) {
        final fetchingTracksResult =
            (await _trackDataSource.getWhereIds(playlistTracksIds));
        if (fetchingTracksResult.isFailure) {
          return fetchingTracksResult.mapFailure((error) => error);
        }
        final tracks = fetchingTracksResult.requireValue;
        if (loadTracksRelations) {
          final loadingTracksRelationsResult =
              await loadRelationsForTracks(tracks);
          if (loadingTracksRelationsResult.isFailure) {
            return loadingTracksRelationsResult.mapFailure((error) => error);
          }
          return playlist
              .copyWith(tracks: loadingTracksRelationsResult.requireValue)
              .asResult;
        }
        return playlist.copyWith(tracks: tracks).asResult;
      }
      return playlist.asResult;
    });
  }

  FutureResult<IsarTrack> loadRelationsForTrack(
    IsarTrack track, {
    String? artistIdToIgnore,
  }) async {
    return await Result.fromAnother(() async {
      final List<IsarArtist> artistsOfTrack;
      // check if artists relation has already been loaded
      if (track.artists.isNotEmpty) {
        artistsOfTrack = track.artists;
      } else {
        final artistsIds = List<String>.from(track.artistsIds);
        artistsIds.remove(artistIdToIgnore);
        if (artistsIds.isEmpty) {
          // no artists to load so the artists list is empty
          artistsOfTrack = const [];
        } else {
          final fetchingArtistsResult =
              await _artistDataSource.getWhereIds(artistsIds);
          if (fetchingArtistsResult.isFailure) {
            return fetchingArtistsResult.mapFailure((error) => error);
          }
          artistsOfTrack = fetchingArtistsResult.asSuccess.value;
        }
      }
      if (track.album != null || track.albumId == null) {
        return track.copyWith(artists: artistsOfTrack).asResult;
      }
      return (await _albumDataSource.find(track.albumId!)).mapSuccess((album) {
        // return the track with acquired artists and album.
        return track.copyWith(album: album, artists: artistsOfTrack);
      });
    });
  }

  FutureResult<List<IsarTrack>> loadRelationsForTracks(
    List<IsarTrack> tracks, {
    String? artistIdToIgnore,
  }) async {
    return await _loadRelationsForMany(
      tracks,
      (t) => loadRelationsForTrack(t, artistIdToIgnore: artistIdToIgnore),
      itemRelationsAlreadyLoaded: (track) => track.artists.isNotEmpty,
    );
  }

  FutureResult<List<T>> _loadRelationsForMany<T>(
    List<T> items,
    FutureResult<T> Function(T) relationLoader, {
    required bool Function(T item) itemRelationsAlreadyLoaded,
  }) async {
    return await Result.fromAnother(() async {
      List<T> itemsWithRelations = [];
      for (T item in items) {
        if (itemRelationsAlreadyLoaded(item)) {
          itemsWithRelations.add(item);
        } else {
          final loadingRelationsResult = await relationLoader(item);
          if (loadingRelationsResult.isFailure) {
            return loadingRelationsResult.mapFailure((error) => error);
          }
          itemsWithRelations.add(loadingRelationsResult.asSuccess.value);
        }
      }
      return itemsWithRelations.asResult;
    });
  }

  FutureResult<IsarAlbum> loadRelationsForAlbum(IsarAlbum value) async {
    throw UnimplementedError();
  }
}
