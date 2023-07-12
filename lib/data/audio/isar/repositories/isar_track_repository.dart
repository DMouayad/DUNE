import 'package:dune/data/audio/isar/data_sources/isar_track_data_source.dart';
import 'package:dune/data/audio/isar/helpers/isar_models_relation_helper.dart';
import 'package:dune/data/audio/isar/models/isar_audio_info_set.dart';
import 'package:dune/data/audio/isar/models/isar_track.dart';
import 'package:dune/data/audio/isar/models/isar_track_audio_info.dart';
import 'package:dune/data/audio/isar/repositories/isar_album_repository.dart';
import 'package:dune/data/audio/isar/repositories/isar_artist_repository.dart';
import 'package:dune/domain/audio/base_models/audio_info_set.dart';
import 'package:dune/domain/audio/base_models/base_track.dart';
import 'package:dune/domain/audio/repositories/track_repository.dart';
import 'package:dune/support/logger_service.dart';
import 'package:dune/support/utils/result/result.dart';

import '../models/isar_album.dart';
import '../models/isar_artist.dart';
import '../models/isar_duration.dart';
import '../models/isar_thumbnails_set.dart';

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

  FutureOrResult<List<IsarTrack>> saveAll(List<BaseTrack> tracks) async {
    List<IsarTrack> result = [];
    for (BaseTrack track in tracks) {
      final savingTrackResult = await save(track);
      if (savingTrackResult.isFailure) {
        Log.e(savingTrackResult);
      } else {
        result.add(savingTrackResult.requireValue);
      }
    }
    return result.asResult;
  }

  @override
  FutureOrResult<IsarTrack> save(BaseTrack track) async {
    final IsarTrack newTrack = _getIsarTrackFromBase(track);
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
        trackToSave = newTrack.copyWith(
            artistsIds: <String>{
          ...newTrack.artistsIds,
          ...existentTrack.artistsIds
        }.toList());
      } else {
        saveTrackArtists = false;
      }
      if (newTrack.albumId == null) {
        trackToSave = (trackToSave ?? newTrack).copyWith(
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
      isarTrack = isarTrack.copyWith(artists: artists);
    }
    if (saveTrackAlbum && isarTrack.album != null) {
      final savingAlbumResult = await _albumRepository.save(isarTrack.album!);
      if (savingAlbumResult.isFailure) {
        return savingAlbumResult.mapFailure((error) => error);
      }
    }
    return isarTrack.asResult;
  }

  IsarTrack _getIsarTrackFromBase(BaseTrack baseTrack) {
    final isarTrack = IsarTrack(
      id: baseTrack.id,
      title: baseTrack.title,
      isExplicit: baseTrack.isExplicit,
      source: baseTrack.source,
      thumbnails: IsarThumbnailsSet.fromMap(baseTrack.thumbnails.toMap()),
      views: baseTrack.views,
      isarDuration: IsarDuration(inSeconds: baseTrack.duration.inSeconds),
      category: baseTrack.category,
      year: baseTrack.year,
      isarAudioInfoSet: _getIsarTrackAudioInfoSet(baseTrack.audioInfoSet),
    );
    final extractedArtists =
        _artistRepository.extractArtistsFromTrack(baseTrack);
    final albumArtistsIds = List<String>.from(extractedArtists.artistsIds);
    final albumArtistId =
        albumArtistsIds.isNotEmpty ? albumArtistsIds.removeAt(0) : null;
    final album = IsarAlbum.tryFromMap(baseTrack.album?.toMap())?.copyWith(
      albumArtistId: albumArtistId,
      featuredArtistsIds: albumArtistsIds,
      tracksIds: [baseTrack.id],
      tracks: [isarTrack],
    ).setIdIfNull();
    return isarTrack.copyWith(
      album: album,
      albumId: album?.id,
      artistsIds: extractedArtists.artistsIds,
      artists: extractedArtists.artists,
    );
  }

  IsarAudioInfoSet? _getIsarTrackAudioInfoSet(AudioInfoSet? audioInfo) {
    if (audioInfo == null) return null;
    final items = audioInfo.items
        .map((e) => IsarTrackAudioInfo(
              bitrateInKb: e.bitrateInKb,
              format: e.format,
              totalBytes: e.totalBytes,
              url: e.url,
              quality: e.quality,
            ))
        .toList();
    return IsarAudioInfoSet(isarAudioInfoList: items);
  }

  @override
  FutureVoidResult saveTrackAudioInfo(
    BaseTrack track,
    AudioInfoSet audioInfo,
  ) async {
    return await Result.fromAnother(() async {
      final updatedTrack = _getIsarTrackFromBase(track).copyWith(
        isarAudioInfoSet: _getIsarTrackAudioInfoSet(audioInfo),
      );
      return (await save(updatedTrack)).mapSuccessToVoid();
    });
  }
}
