import 'package:dune/data/audio/isar/repositories/isar_music_repository.dart';
import 'package:dune/data/audio/isar/seeders/isar_track_listening_history_seeder.dart';
import 'package:dune/domain/audio/base_models/base_album.dart';
import 'package:dune/domain/audio/base_models/base_artist.dart';
import 'package:dune/domain/audio/base_models/base_playlist.dart';
import 'package:dune/domain/audio/base_models/base_track.dart';
import 'package:dune/domain/audio/factories/album_factory.dart';
import 'package:dune/domain/audio/factories/artist_factory.dart';
import 'package:dune/domain/audio/factories/playlist_factory.dart';
import 'package:dune/domain/audio/factories/track_factory.dart';
import 'package:dune/domain/audio/seeders/album_seeder.dart';
import 'package:dune/domain/audio/seeders/artist_seeder.dart';
import 'package:dune/domain/audio/seeders/playlist_seeder.dart';
import 'package:dune/domain/audio/seeders/track_seeder.dart';
import 'package:dune/support/enums/music_source.dart';
import 'package:dune/support/helpers/isar_helper.dart';
import 'package:get_it/get_it.dart';
import 'package:isar/isar.dart';

class IsarTestingUtils {
  static late Isar _isar;

  static Isar get isar => _isar;
  static late IsarMusicRepository _isarMusicRepo;

  static IsarMusicRepository get isarMusicRepo => _isarMusicRepo;

  static Future<void> initIsarForTesting() async {
    final isarDBNotOpened = !GetIt.instance.isRegistered<Isar>();
    if (isarDBNotOpened) {
      _isar = await IsarHelper.initForTesting();
      GetIt.instance.registerSingleton<Isar>(_isar);
    } else {
      _isar = GetIt.instance.get();
    }
    _isarMusicRepo = IsarMusicRepository(isar: _isar);
  }

  static Future<void> refreshDatabase() async {
    if (GetIt.instance.isRegistered<Isar>()) {
      _isarMusicRepo = IsarMusicRepository(isar: _isar);
      await _isar.writeTxn(() async => await _isar.clear());
    }
  }

  static IsarTrackListeningHistorySeeder get trackListeningHistorySeeder {
    return IsarTrackListeningHistorySeeder(_isarMusicRepo);
  }

  static Future<List<BaseTrack>> seedTracks(
    int count,
    MusicSource source,
  ) async {
    return await TrackSeeder(_isarMusicRepo.tracks).seedCount(
      count,
      TrackFactory().setMusicSource(source),
    );
  }

  static Future<List<BasePlaylist>> seedPlaylists(
    int count, [
    MusicSource? playlistSource,
    int playlistTracksCount = 1,
  ]) async {
    return await PlaylistSeeder(_isarMusicRepo.playlists).seedCount(
      count,
      factory: PlaylistFactory()
          .setTracksCount(playlistTracksCount)
          .setMusicSource(playlistSource),
    );
  }

  static Future<List<BaseAlbum>> seedAlbums(
    int count, [
    MusicSource? albumMusicSource,
    int? albumTracksCount,
  ]) async {
    return await AlbumSeeder(_isarMusicRepo.albums).seedCount(
      count,
      AlbumFactory()
          .setTracksCount(albumTracksCount)
          .setMusicSource(albumMusicSource),
    );
  }

  static Future<List<BaseArtist>> seedArtists(
    int count, [
    MusicSource? artistMusicSource,
  ]) async {
    return await ArtistSeeder(_isarMusicRepo.artists).seedCount(
      count,
      ArtistFactory().setMusicSource(artistMusicSource),
    );
  }
}
