import 'package:dune/data/audio/isar/data_sources/isar_artist_data_source.dart';
import 'package:dune/data/audio/isar/helpers/isar_models_relation_helper.dart';
import 'package:dune/data/audio/isar/models/isar_artist.dart';
import 'package:dune/domain/audio/base_models/base_artist.dart';
import 'package:dune/domain/audio/base_models/base_track.dart';
import 'package:dune/domain/audio/repositories/artist_repository.dart';
import 'package:dune/support/logger_service.dart';
import 'package:dune/support/utils/result/result.dart';
import 'package:flutter/foundation.dart';

final class IsarArtistRepository
    extends SavableArtistRepository<IsarArtistDataSource> {
  IsarArtistRepository(super.artistDataSource, this._relationHelper);

  final IsarModelsRelationHelper _relationHelper;

  @override
  FutureOrResult<IsarArtist?> getById(String id) async {
    return (await artistDataSource.find(id)).flatMapSuccessAsync((value) async {
      if (value != null) {
        return await _relationHelper.loadRelationsForArtist(value);
      }
      return value.asResult;
    });
  }

  @override
  FutureOrResult<IsarArtist> save(BaseArtist artist) async {
    final newIsarArtist = _getIsarArtistFromBase(artist);

    // first check if an [IsarArtist] was saved in the DB for this artist id.
    // NOTE: [newIsarArtist] instance will always have a non-null [id]
    // property because if [artist.id] is null, it'll be assign a new id
    // that is unique for this artist.
    final fetchingIsarArtistResult =
        await artistDataSource.find(newIsarArtist.id!);
    if (fetchingIsarArtistResult.isFailure) {
      return fetchingIsarArtistResult.mapFailure((error) => error);
    }
    final existingArtist = fetchingIsarArtistResult.requireValue;
    if (existingArtist != null) {
      final IsarArtist updatedArtist = _updateArtistData(
        oldInstance: existingArtist,
        newInstance: newIsarArtist,
      );
      return await artistDataSource.save(updatedArtist);
    } else {
      return await artistDataSource.save(newIsarArtist);
    }
  }

  IsarArtist _getIsarArtistFromBase(BaseArtist baseArtist) {
    return baseArtist is IsarArtist
        ? baseArtist.setIdIfNull()
        : IsarArtist.fromMap(baseArtist.toMap()).setIdIfNull();
  }

  @override
  FutureOrResult<List<IsarArtist>> saveAll(List<BaseArtist> artists) async {
    List<IsarArtist> result = [];
    for (BaseArtist artist in artists) {
      final savingArtistResult = await save(artist);
      if (savingArtistResult.isFailure) {
        Log.e(savingArtistResult);
      } else {
        result.add(savingArtistResult.requireValue);
      }
    }
    return result.asResult;
  }

  IsarArtist _updateArtistData({
    required IsarArtist oldInstance,
    required IsarArtist newInstance,
  }) {
    return newInstance.copyWith(
      tracksIds: {
        ...oldInstance.tracksIds,
        ...newInstance.tracksIds,
      }.toList(),
      albumsIds: {
        ...oldInstance.albumsIds,
        ...newInstance.albumsIds,
      }.toList(),
    );
  }
}
