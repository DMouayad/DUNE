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

import 'playlist_repository.dart';

class LocalMusicLibraryRepository {
  final SavableTrackRepository _trackRepository;
  final SavableAlbumRepository _albumRepository;
  final SavableArtistRepository _artistRepository;
  final SavablePlaylistRepository _playlistRepository;

  const LocalMusicLibraryRepository(
    this._trackRepository,
    this._albumRepository,
    this._artistRepository,
    this._playlistRepository,
  );

  FutureOrResult<MusicLibrary> loadLibrary() async {
    throw UnimplementedError();
  }

  MusicSource get _localSource => MusicSource.local;

  FutureOrResult<List<BaseArtist>> getArtists(
      QuerySortOptions sortOptions) async {
    return await _artistRepository.findAllWhereSource(
        _localSource, sortOptions);
  }

  FutureOrResult<List<BaseTrack>> getTracks(
      QuerySortOptions sortOptions) async {
    throw UnimplementedError();
  }

  FutureOrResult<List<BaseAlbum>> getAlbums(
      QuerySortOptions sortOptions) async {
    throw UnimplementedError();
  }
}
