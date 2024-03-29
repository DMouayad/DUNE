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
      List<IsarTrack> tracks = [];
      if (artist.tracks.isNotEmpty && artist.tracks is List<IsarTrack>) {
        tracks = artist.tracks.cast<IsarTrack>();
      } else {
        final artistTracksIds = List<String>.from(artist.tracksIds);
        artistTracksIds.remove(trackIdToIgnore);

        if (artistTracksIds.isNotEmpty) {
          return (await _trackDataSource.getWhereIds(artistTracksIds))
              .mapSuccessAsync((tracks) async {
            return (await loadRelationsForTracks(tracks,
                    artistToIgnore: artist))
                .mapSuccessTo(
              (tracksWithRelations) =>
                  artist.copyWith(tracks: tracksWithRelations),
            );
          });
        }
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
    IsarArtist? artistToIgnore,
    IsarAlbum? albumToIgnore,
  }) async {
    return await Result.fromAnother(() async {
      // check if artists relation has already been loaded
      IsarTrack trackWithArtists;
      if (track.artists.isNotEmpty &&
          track.artists.length == track.artistsIds.length) {
        trackWithArtists = track.copyWith(artists: track.artists);
      } else {
        final artistsIds = List<String>.from(track.artistsIds);
        artistsIds.remove(artistToIgnore?.id);
        if (artistsIds.isEmpty) {
          // no artists to load but add ignored artist, if present, since
          // it's the only artist for this track.
          trackWithArtists = track
              .copyWith(artists: [if (artistToIgnore != null) artistToIgnore]);
        } else {
          final fetchingArtists =
              await _artistDataSource.getWhereIds(artistsIds);

          if (fetchingArtists.isFailure) return fetchingArtists;

          trackWithArtists = track.copyWith(artists: [
            ...fetchingArtists.requireValue,
            if (artistToIgnore != null) artistToIgnore
          ]);
        }
      }
      if (track.albumId == null || track.albumId == albumToIgnore?.id) {
        return trackWithArtists.copyWith(album: albumToIgnore).asResult;
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
          return trackWithArtists.copyWith(album: albumWithRelations);
        });
      });
    });
  }

  FutureResult<List<IsarTrack>> loadRelationsForTracks(
    List<IsarTrack> tracks, {
    IsarArtist? artistToIgnore,
    IsarAlbum? albumToIgnore,
  }) async {
    return await _loadRelationsForMany(
      tracks,
      (t) => loadRelationsForTrack(t,
          artistToIgnore: artistToIgnore, albumToIgnore: albumToIgnore),
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

      IsarAlbum newAlbum = album.copyWith();
      if (withArtists) {
        // check if artists relation has already been loaded
        if (album.artists.isNotEmpty && album.artists is List<IsarArtist>) {
          // Do nothing - already in the [newAlbum]
        } else {
          if (album.albumArtistId != null) {
            (await _artistDataSource.find(album.albumArtistId!)).fold(
                onSuccess: (artist) {
              newAlbum = newAlbum.copyWith(albumArtist: artist);
            });
          }
          final artistsIds = List<String>.from(album.featuredArtistsIds);
          artistsIds.remove(artistIdToIgnore);
          if (artistsIds.isNotEmpty) {
            (await _artistDataSource.getWhereIds(artistsIds)).fold(
              onSuccess: (artists) =>
                  newAlbum = newAlbum.copyWith(artists: artists),
            );
          }
        }
      }
      if (withTracks && album.tracksIds.isNotEmpty) {
        // load tracks with their relations
        await (await _trackDataSource.getWhereIds(album.tracksIds)).foldAsync(
            onSuccess: (tracks) async {
          if (tracks.isNotEmpty) {
            (await loadRelationsForTracks(tracks, albumToIgnore: album)).fold(
                onSuccess: (tracksWithRelations) {
              newAlbum = newAlbum.copyWith(tracks: tracksWithRelations);
            });
          }
        });
      }

      return newAlbum.asResult;
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
