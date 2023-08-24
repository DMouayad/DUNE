import 'package:dune/domain/audio/base_models/base_album.dart';
import 'package:dune/domain/audio/base_models/base_artist.dart';
import 'package:dune/domain/audio/base_models/base_track.dart';
import 'package:dune/domain/audio/base_models/music_library.dart';
import 'package:dune/domain/audio/repositories/album_repository.dart';
import 'package:dune/domain/audio/repositories/artist_repository.dart';
import 'package:dune/domain/audio/repositories/track_repository.dart';
import 'package:dune/support/enums/music_source.dart';
import 'package:dune/support/models/query_options.dart';
import 'package:dune/support/utils/result/result.dart';

import '../repositories/playlist_repository.dart';

class LocalMusicLibraryFacade {
  final SavableTrackRepository _trackRepository;
  final SavableAlbumRepository _albumRepository;
  final SavableArtistRepository _artistRepository;
  final SavablePlaylistRepository _playlistRepository;

  LocalMusicLibraryFacade(
    this._trackRepository,
    this._albumRepository,
    this._artistRepository,
    this._playlistRepository,
  );

  MusicLibrary _cachedLibrary = MusicLibrary();

  /// Loads local library from the local database.
  /// the [queryOptions] will be used to load this library media(tracks, artists,
  /// albums, playlists).
  FutureOrResult<MusicLibrary> loadLibrary(QueryOptions queryOptions) async {
    final library = MusicLibrary();

    await _trackRepository
        .findAllWhereSource(_localSource, queryOptions)
        .foldThen(
          onSuccess: (fetchedTracks) =>
              library.setTracks(fetchedTracks, queryOptions),
        );
    //
    await _playlistRepository
        .findAllWhereSource(_localSource, queryOptions)
        .foldThen(
          onSuccess: (playlists) =>
              library.setPlaylists(playlists, queryOptions),
        );
    await _artistRepository
        .findAllWhereSource(_localSource, queryOptions)
        .foldThen(
          onSuccess: (artists) => library.setArtists(artists, queryOptions),
        );
    await _albumRepository
        .findAllWhereSource(_localSource, queryOptions)
        .foldThen(
          onSuccess: (albums) => library.setAlbums(albums, queryOptions),
        );
    //
    _cachedLibrary = library;
    return library.asResult;
  }

  MusicSource get _localSource => MusicSource.local;

  FutureResult<MusicLibrary> addTracksToLibrary(
    List<BaseTrack> tracks,
  ) async {
    //
    final savingTracks = await _trackRepository.saveAll(tracks);
    if (savingTracks.isFailure) {
      return savingTracks.mapFailure((error) => error);
    }
    return await loadLibrary(QueryOptions.defaultOptions());
  }

  FutureOrResult<List<BaseArtist>> getArtists(QueryOptions queryOptions) async {
    return _cachedLibrary.getArtists(queryOptions)?.asResult ??
        (await _artistRepository.findAllWhereSource(_localSource, queryOptions))
            .fold(
                onSuccess: (value) =>
                    _cachedLibrary.setArtists(value, queryOptions));
  }

  FutureOrResult<List<BaseTrack>> getTracks(QueryOptions queryOptions) async {
    return _cachedLibrary.getTracks(queryOptions)?.asResult ??
        (await _trackRepository.findAllWhereSource(_localSource, queryOptions))
            .fold(onSuccess: (value) {
          _cachedLibrary.setTracks(value, queryOptions);
        });
  }

  FutureOrResult<List<BaseAlbum>> getAlbums(QueryOptions queryOptions) async {
    return _cachedLibrary.getAlbums(queryOptions)?.asResult ??
        (await _albumRepository.findAllWhereSource(_localSource, queryOptions))
            .fold(
          onSuccess: (value) => _cachedLibrary.setAlbums(value, queryOptions),
        );
  }
}
