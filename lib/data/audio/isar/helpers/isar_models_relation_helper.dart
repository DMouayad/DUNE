import 'package:dune/data/audio/isar/data_sources/isar_album_data_source.dart';
import 'package:dune/data/audio/isar/data_sources/isar_playlist_data_source.dart';
import 'package:dune/data/audio/isar/models/isar_album.dart';
import 'package:dune/data/audio/isar/models/isar_artist.dart';
import 'package:dune/data/audio/isar/models/isar_playlists_listening_history.dart';
import 'package:dune/data/audio/isar/models/isar_playlist.dart';
import 'package:dune/data/audio/isar/models/isar_track.dart';
import 'package:dune/data/audio/isar/models/isar_track_listening_history.dart';
import 'package:dune/domain/audio/base_models/base_listening_history_month_summary.dart';
import 'package:dune/support/logger_service.dart';
import 'package:dune/support/utils/result/result.dart';

import '../data_sources/isar_artist_data_source.dart';
import '../data_sources/isar_track_data_source.dart';

final class IsarModelsRelationHelper {
  final IsarTrackDataSource _trackDataSource;
  final IsarArtistDataSource _artistDataSource;
  final IsarPlaylistDataSource _playlistDataSource;
  final IsarAlbumDataSource _albumDataSource;

  IsarModelsRelationHelper(
    this._trackDataSource,
    this._artistDataSource,
    this._albumDataSource,
    this._playlistDataSource,
  );

  FutureResult<List<IsarPlaylistsListeningHistory>>
      loadRelationsForPlaylistsListeningHistories(
    List<IsarPlaylistsListeningHistory> histories,
  ) async {
    return await _loadRelationsForMany(
      histories,
      loadRelationsForPlaylistsListeningHistory,
      itemRelationsAlreadyLoaded: (_) => false,
    );
  }

  FutureResult<IsarPlaylistsListeningHistory>
      loadRelationsForPlaylistsListeningHistory(
    IsarPlaylistsListeningHistory history, {
    List<int> ignoredPlaylistsIds = const [],
  }) async {
    final List<IsarPlaylist> playlists;
    final playlistsIds = List<int>.from(history.isarPlaylistsIds);

    for (var id in ignoredPlaylistsIds) {
      playlistsIds.remove(id);
    }
    if (playlistsIds.isNotEmpty) {
      final fetchingPlaylistsResult =
          await _playlistDataSource.getWhereIsarId(playlistsIds);
      if (fetchingPlaylistsResult.isFailure) {
        return fetchingPlaylistsResult.mapFailure((error) => error);
      }
      playlists = fetchingPlaylistsResult.requireValue;
    } else {
      playlists = const [];
    }
    return (await loadRelationsForPlaylists(playlists,
            loadTracksRelations: true))
        .mapSuccess((value) => history.copyWith(items: value));
  }

  FutureResult<List<IsarTrackListeningHistory>>
      loadRelationsForTrackListeningHistories(
    List<IsarTrackListeningHistory> histories,
  ) async {
    return await _loadRelationsForMany(
      histories,
      loadRelationsForTrackListeningHistory,
      itemRelationsAlreadyLoaded: (_) => false,
    );
  }

  FutureResult<IsarTrackListeningHistory> loadRelationsForTrackListeningHistory(
    IsarTrackListeningHistory history,
  ) async {
    return await Result.fromAnother(() async {
      final IsarTrack? track;
      if (history.track is IsarTrack) {
        track = history.track!;
      } else {
        final fetchingTrackResult =
            await _trackDataSource.find(history.trackId!);
        if (fetchingTrackResult.isSuccess) {
          track = fetchingTrackResult.requireValue;
        } else {
          track = null;
          Log.e(fetchingTrackResult.asFailure.error);
        }
      }
      if (track == null) {
        return history.asResult;
      } else {
        return (await loadRelationsForTrack(track)).mapSuccess(
          (trackWithRelations) {
            return history.copyWith(track: trackWithRelations);
          },
        );
      }
    });
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
    String? albumIdToIgnore,
  }) async {
    return await Result.fromAnother(() async {
      final List<IsarArtist> artistsOfTrack;
      // check if artists relation has already been loaded
      IsarTrack trackWithArtists;
      if (track.artists.isNotEmpty &&
          track.artists.length == track.artistsIds.length) {
        artistsOfTrack = track.artists;
        trackWithArtists = track.copyWith(artists: artistsOfTrack);
      } else {
        final artistsIds = List<String>.from(track.artistsIds);
        artistsIds.remove(artistIdToIgnore);
        if (artistsIds.isEmpty) {
          // no artists to load so the artists list is empty
          artistsOfTrack = const [];
          trackWithArtists = track;
        } else {
          final fetchingArtistsResult =
              await _artistDataSource.getWhereIds(artistsIds);
          if (fetchingArtistsResult.isFailure) {
            return fetchingArtistsResult.mapFailure((error) => error);
          }
          artistsOfTrack = fetchingArtistsResult.requireValue;

          trackWithArtists = track.copyWith(artists: artistsOfTrack);
        }
      }
      if (track.albumId == null || track.albumId == albumIdToIgnore) {
        return trackWithArtists.asResult;
      }
      return (await _albumDataSource.find(track.albumId!))
          .flatMapSuccessAsync((album) async {
        if (album == null) {
          return trackWithArtists.asResult;
        }
        return (await loadRelationsForAlbum(
          album,
          withArtists: false,
          withTracks: false,
        ))
            .mapSuccess((albumWithRelations) {
          return trackWithArtists.copyWith(
            album: albumWithRelations,
            artists: artistsOfTrack,
          );
        });
      });
    });
  }

  FutureResult<List<IsarTrack>> loadRelationsForTracks(
    List<IsarTrack> tracks, {
    String? artistIdToIgnore,
    String? albumIdToIgnore,
  }) async {
    return await _loadRelationsForMany(
      tracks,
      (t) => loadRelationsForTrack(t,
          artistIdToIgnore: artistIdToIgnore, albumIdToIgnore: albumIdToIgnore),
      itemRelationsAlreadyLoaded: (track) =>
          track.artists.isNotEmpty && track.album != null,
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

  FutureResult<IsarAlbum> loadRelationsForAlbum(
    IsarAlbum album, {
    bool withArtists = true,
    bool withTracks = true,
    String? artistIdToIgnore,
    String? trackIdToIgnore,
  }) async {
    return await Result.fromAnother(() async {
      if (!withArtists && !withArtists) return album.asResult;

      List<IsarArtist>? artistsOfAlbum;
      List<IsarTrack>? tracksOfAlbum;
      if (withArtists) {
        // check if artists relation has already been loaded
        if (album.artists.isNotEmpty && album.artists is List<IsarArtist>) {
          artistsOfAlbum = album.artists as List<IsarArtist>;
        } else {
          final artistsIds = List<String>.from(album.featuredArtistsIds);
          if (album.albumArtistId != null) {
            artistsIds.add(album.albumArtistId!);
          }
          artistsIds.remove(artistIdToIgnore);
          if (artistsIds.isEmpty) {
            // no artists to load so the artists list is empty
            artistsOfAlbum = const [];
          } else {
            final fetchingArtistsResult =
                await _artistDataSource.getWhereIds(artistsIds);
            if (fetchingArtistsResult.isFailure) {
              return fetchingArtistsResult.mapFailure((error) => error);
            }
            artistsOfAlbum = fetchingArtistsResult.asSuccess.value;
          }
        }
      }
      if (withTracks) {
        if (album.tracksIds.isEmpty) {
          return album.copyWith(artists: artistsOfAlbum).asResult;
        }
        return (await _trackDataSource.getWhereIds(album.tracksIds))
            .flatMapSuccessAsync((tracks) async {
          if (tracks.isEmpty) {
            return album.copyWith(artists: artistsOfAlbum).asResult;
          }
          return (await loadRelationsForTracks(tracks,
                  albumIdToIgnore: album.id))
              .mapSuccess((tracksWithRelations) {
            return album.copyWith(
                tracks: tracksWithRelations, artists: artistsOfAlbum);
          });
        });
      }

      return album
          .copyWith(artists: artistsOfAlbum, tracks: tracksOfAlbum)
          .asResult;
    });
  }

  FutureResult<List<BaseListeningHistoryMonthSummary>>
      loadRelationsForMonthsSummary(
    List<BaseListeningHistoryMonthSummary> summaries,
  ) async {
    return await _loadRelationsForMany(
      summaries,
      loadRelationsForMonthSummary,
      itemRelationsAlreadyLoaded: (instance) =>
          instance.topArtists.isNotEmpty && instance.topTracks.isNotEmpty,
    );
  }

  FutureResult<BaseListeningHistoryMonthSummary> loadRelationsForMonthSummary(
    BaseListeningHistoryMonthSummary summary,
  ) async {
    return summary.asResult;
  }

  FutureResult<List<IsarAlbum>> loadRelationsForAlbums(
    List<IsarAlbum> albums,
  ) async {
    return await _loadRelationsForMany(
      albums,
      loadRelationsForAlbum,
      itemRelationsAlreadyLoaded: (instance) =>
          instance.artists.isNotEmpty && instance.tracks.isNotEmpty,
    );
  }
}
