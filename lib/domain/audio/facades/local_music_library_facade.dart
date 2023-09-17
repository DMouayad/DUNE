part of 'music_facade.dart';

class LocalMusicLibraryFacade {
  final SavableTrackRepository _trackRepository;
  final SavableAlbumRepository _albumRepository;
  final SavableArtistRepository _artistRepository;
  final AudioLibraryScanner _libraryScanner;

  LocalMusicLibraryFacade(
    this._trackRepository,
    this._albumRepository,
    this._artistRepository,
    this._libraryScanner,
  );

  MusicLibrary _cachedLibrary = MusicLibrary();

  /// Scans the given [path] for audio files and save their info as [BaseTrack]s
  /// in the local storage.
  ///
  /// returns a [MusicLibrary] with the newly added tracks, albums and artists.
  FutureOrResult<MusicLibrary> addMusicDirectory(String path) async {
    return (await _libraryScanner.scanDirectory(path))
        .flatMapSuccessAsync((value) async => await addTracksToLibrary(value));
  }

  /// Deletes all [BaseTrack] from local storage which exists in the directory
  /// at given [path].
  ///
  /// returns a [MusicLibrary] **without** the removed tracks, albums and artists.
  FutureOrResult<MusicLibrary> removeMusicDirectory(String path) async {
    return await Result.fromAnother(() async {
      // 1. remove all tracks in the directory at path.
      final removeTracksResult = await _trackRepository.removeByDirectory(path);
      if (removeTracksResult.isFailure) return removeTracksResult;

      // 2. remove those tracks albums
      final albumsIds = _extractAlbumsIds(removeTracksResult.requireValue);
      final removeAlbumsResult =
          await _albumRepository.removeAllById(albumsIds);
      if (removeAlbumsResult.isFailure) return removeAlbumsResult;

      // 3. remove those tracks artists
      final artistsIds = _extractArtistsIds(removeTracksResult.requireValue);
      final removeArtistsResult =
          await _artistRepository.removeAllById(artistsIds);
      if (removeArtistsResult.isFailure) return removeArtistsResult;
      // 4. re-load the library from storage and return it
      return await getLibrary();
    });
  }

  List<String> _extractAlbumsIds(List<BaseTrack> tracks) {
    return tracks
        .map((e) => e.album?.id)
        .where((id) => id != null)
        .toList()
        .cast<String>();
  }

  List<String> _extractArtistsIds(List<BaseTrack> tracks) {
    return tracks
        .map((e) => e.artists.map((e) => e.id))
        .expand((ids) => ids)
        .where((id) => id != null)
        .toList()
        .cast<String>();
  }

  /// Loads a `MusicLibrary` from local storage.
  /// the [queryOptions] will be used to retrieve this library
  /// media: tracks, artists, albums.
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

  /// Saves the given [tracks] in local storage then returns
  /// a `MusicLibrary` with the new tracks added.
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
    return await _getFromCachedLibrary(
      _cachedLibrary.getArtists(queryOptions),
      ifAbsent: () async => await _artistRepository.findAllWhereSource(
          _localSource, queryOptions),
      onIfAbsentSuccess: (value) =>
          _cachedLibrary.setArtists(value, queryOptions),
    );
  }

  FutureOrResult<List<BaseTrack>> getTracks(QueryOptions queryOptions) async {
    return await _getFromCachedLibrary(
      _cachedLibrary.getTracks(queryOptions),
      ifAbsent: () async =>
          await _trackRepository.findAllWhereSource(_localSource, queryOptions),
      onIfAbsentSuccess: (value) =>
          _cachedLibrary.setTracks(value, queryOptions),
    );
  }

  FutureOrResult<List<BaseAlbum>> getAlbums(QueryOptions queryOptions) async {
    return await _getFromCachedLibrary(
      _cachedLibrary.getAlbums(queryOptions),
      ifAbsent: () async =>
          await _albumRepository.findAllWhereSource(_localSource, queryOptions),
      onIfAbsentSuccess: (value) =>
          _cachedLibrary.setAlbums(value, queryOptions),
    );
  }

  /// a helper function
  ///
  /// if [cachedItems] is empty, it calls [ifAbsent] to get the items from
  /// local storage.
  /// then if [ifAbsent] is a success, calls [onIfAbsentSuccess]
  FutureOrResult<T> _getFromCachedLibrary<T extends List>(
    T cachedItems, {
    required FutureOrResult<T> Function() ifAbsent,
    required void Function(T value) onIfAbsentSuccess,
  }) async {
    if (cachedItems.isNotEmpty) return cachedItems.asResult;
    return (await ifAbsent()).fold(onSuccess: onIfAbsentSuccess);
  }
}
