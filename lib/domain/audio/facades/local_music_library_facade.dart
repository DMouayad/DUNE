import 'package:dune/domain/audio/base_models/base_album.dart';
import 'package:dune/domain/audio/base_models/base_artist.dart';
import 'package:dune/domain/audio/base_models/base_track.dart';
import 'package:dune/domain/audio/base_models/music_library.dart';
import 'package:dune/domain/audio/repositories/local_music_library_repository.dart';
import 'package:dune/support/models/query_options.dart';
import 'package:dune/support/utils/result/result.dart';

final class LocalMusicLibraryFacade {
  final LocalMusicLibraryRepository _repository;

  LocalMusicLibraryFacade(this._repository);

  FutureOrResult<MusicLibrary> loadLibrary() async {
    return await _repository.loadLibrary();
  }

  FutureOrResult<List<BaseArtist>> getArtists(
      QuerySortOptions sortOptions) async {
    return await _repository.getArtists(sortOptions);
  }

  FutureOrResult<List<BaseTrack>> getTracks(
      QuerySortOptions sortOptions) async {
    return await _repository.getTracks(sortOptions);
  }

  FutureOrResult<List<BaseAlbum>> getAlbums(
      QuerySortOptions sortOptions) async {
    return await _repository.getAlbums(sortOptions);
  }
}
