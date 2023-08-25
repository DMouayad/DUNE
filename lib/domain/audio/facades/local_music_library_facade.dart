part of 'music_facade.dart';

class LocalMusicLibraryFacade {
  final SavableTrackRepository _trackRepository;
  final SavableAlbumRepository _albumRepository;
  final SavableArtistRepository _artistRepository;

  LocalMusicLibraryFacade(
    this._trackRepository,
    this._albumRepository,
    this._artistRepository,
  );

  MusicLibrary _cachedLibrary = MusicLibrary();

  /// Loads a `MusicLibrary` from local storage.
  /// the [queryOptions] will be used to retrieve this library media(tracks, artists,
  /// albums, playlists).
  FutureOrResult<MusicLibrary> getLibrary([
    QueryOptions queryOptions = QueryOptions.defaultOptions,
  ]) async {
    final library = MusicLibrary();

    await _trackRepository
        .findAllWhereSource(_localSource, queryOptions)
        .foldThen(
          onSuccess: (fetchedTracks) =>
              library.setTracks(fetchedTracks, queryOptions),
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
    final savingTracks = await _trackRepository.saveAll(tracks);
    if (savingTracks.isFailure) {
      return savingTracks.mapFailure((error) => error);
    }
    return await getLibrary();
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
