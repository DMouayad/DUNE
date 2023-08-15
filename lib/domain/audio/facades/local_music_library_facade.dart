import 'package:dune/domain/audio/base_models/base_album.dart';
import 'package:dune/domain/audio/base_models/base_artist.dart';
import 'package:dune/domain/audio/base_models/base_track.dart';
import 'package:dune/domain/audio/base_models/music_library.dart';
import 'package:dune/domain/audio/repositories/local_music_library_repository.dart';
import 'package:dune/support/enums/sorts.dart';
import 'package:dune/support/utils/result/result.dart';

final class LocalMusicLibraryFacade {
  final LocalMusicLibraryRepository _repository;

  LocalMusicLibraryFacade(this._repository);

  FutureOrResult<MusicLibrary> loadLibrary() async {
    return await _repository.loadLibrary();
  }

  FutureOrResult<List<BaseArtist>> getArtists({
    SortType sortBy = SortType.alphabetically,
    bool desc = false,
  }) async {
    return await _repository.getArtists(sortBy, desc);
  }

  FutureOrResult<List<BaseTrack>> getTracks({
    SortType sortBy = SortType.alphabetically,
    bool desc = false,
  }) async {
    return await _repository.getTracks(sortBy, desc);
  }

  FutureOrResult<List<BaseAlbum>> getAlbums({
    SortType sortBy = SortType.alphabetically,
    bool desc = false,
  }) async {
    return await _repository.getAlbums(sortBy, desc);
  }
}
