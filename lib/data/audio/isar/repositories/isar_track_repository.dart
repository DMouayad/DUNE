import 'package:dune/data/audio/isar/data_sources/isar_track_data_source.dart';
import 'package:dune/data/audio/isar/helpers/isar_models_relation_helper.dart';
import 'package:dune/data/audio/isar/models/isar_audio_info_set.dart';
import 'package:dune/data/audio/isar/models/isar_track.dart';
import 'package:dune/data/audio/isar/repositories/isar_album_repository.dart';
import 'package:dune/data/audio/isar/repositories/isar_artist_repository.dart';
import 'package:dune/domain/audio/base_models/audio_info_set.dart';
import 'package:dune/domain/audio/base_models/base_track.dart';
import 'package:dune/domain/audio/repositories/track_repository.dart';
import 'package:dune/support/enums/music_source.dart';
import 'package:dune/support/models/query_options.dart';
import 'package:dune/support/utils/result/result.dart';

import '../models/isar_artist.dart';

final class IsarTrackRepository extends SavableTrackRepository {
  final IsarArtistRepository _artistRepository;
  final IsarTrackDataSource _trackDataSource;
  final IsarAlbumRepository _albumRepository;
  final IsarModelsRelationHelper _relationHelper;

  IsarTrackRepository(
    this._albumRepository,
    this._artistRepository,
    this._trackDataSource,
    this._relationHelper,
  ) : super(_trackDataSource);

  @override
  FutureOrResult<IsarTrack?> getById(String id) async {
    return (await _trackDataSource.find(id)).flatMapSuccessAsync((value) async {
      if (value != null) {
        return await _relationHelper.loadRelationsForTrack(value);
      }
      return value.asResult;
    });
  }

  @override
  FutureOrResult<IsarTrack> save(BaseTrack track) async {
    final IsarTrack newTrack = IsarTrack.fromBase(track);
    // first we check if an [IsarTrack] exists for this track.
    final existentIsarTrackResult = await _trackDataSource.find(track.id);
    if (existentIsarTrackResult.isFailure) {
      return existentIsarTrackResult.mapFailure((error) => error);
    }
    bool saveTrackArtists = true;
    bool saveTrackAlbum = true;
    IsarTrack? trackToSave;
    final existentTrack = existentIsarTrackResult.requireValue;
    // if a track was found, update its data if needed
    if (existentTrack != null) {
      if (existentTrack.artistsIds != newTrack.artistsIds) {
        trackToSave = newTrack.copyWithIsar(
            artistsIds: <String>{
          ...newTrack.artistsIds,
          ...existentTrack.artistsIds
        }.toList());
      } else {
        saveTrackArtists = false;
      }
      if (newTrack.albumId == null) {
        trackToSave = (trackToSave ?? newTrack).copyWithIsar(
          albumId: existentTrack.albumId,
        );
        saveTrackAlbum = false;
      }
    }
    trackToSave ??= newTrack;
    // save the [IsarTrack] instance
    final savingTrackResult = await _trackDataSource.save(trackToSave);
    if (savingTrackResult.isFailure) return savingTrackResult;

    IsarTrack isarTrack = savingTrackResult.requireValue;

    if (saveTrackArtists && isarTrack.artists.isNotEmpty) {
      final savingTrackArtistsResult =
          await _artistRepository.saveAll(isarTrack.artists);
      if (savingTrackArtistsResult.isFailure) {
        return savingTrackArtistsResult.mapFailure((error) => error);
      }
      final List<IsarArtist> artists = savingTrackArtistsResult.requireValue;
      isarTrack = isarTrack.copyWithIsar(artists: artists);
    }
    if (saveTrackAlbum && isarTrack.album != null) {
      final savingAlbumResult = await _albumRepository.save(isarTrack.album!);
      if (savingAlbumResult.isFailure) {
        return savingAlbumResult.mapFailure((error) => error);
      }
    }
    return isarTrack.asResult;
  }

  @override
  FutureVoidResult saveTrackAudioInfo(
    BaseTrack track,
    AudioInfoSet audioInfo,
  ) async {
    return await Result.fromAnother(() async {
      final updatedTrack = IsarTrack.fromBase(track).copyWithIsar(
        isarAudioInfoSet: IsarAudioInfoSet.from(audioInfo),
      );
      return (await save(updatedTrack)).mapSuccessToVoid();
    });
  }

  @override
  FutureOrResult<List<BaseTrack>> findAllWhereSource(
    MusicSource musicSource,
    QueryOptions sortOptions,
  ) async {
    return (await _trackDataSource.findAllWhereSource(musicSource, sortOptions))
        .flatMapSuccessAsync((value) async {
      if (value.isNotEmpty) {
        return await _relationHelper.loadRelationsForTracks(value);
      }
      return value.asResult;
    });
  }

  @override
  FutureOrResult<BaseTrack?> findWhereSource(
    String id,
    MusicSource musicSource,
  ) async {
    return (await _trackDataSource.findWhereSource(id, musicSource))
        .flatMapSuccessAsync((value) async {
      if (value != null) {
        return await _relationHelper.loadRelationsForTrack(value);
      }
      return value.asResult;
    });
  }
}
