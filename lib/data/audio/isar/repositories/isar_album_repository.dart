import 'package:dune/data/audio/isar/data_sources/isar_album_data_source.dart';
import 'package:dune/data/audio/isar/helpers/isar_models_relation_helper.dart';
import 'package:dune/data/audio/isar/models/isar_album.dart';
import 'package:dune/domain/audio/base_models/base_album.dart';
import 'package:dune/domain/audio/repositories/album_repository.dart';
import 'package:dune/support/logger_service.dart';
import 'package:dune/support/utils/result/result.dart';

final class IsarAlbumRepository
    extends SavableAlbumRepository<IsarAlbumDataSource> {
  IsarAlbumRepository(super.albumDataSource, this._relationHelper);

  final IsarModelsRelationHelper _relationHelper;

  @override
  FutureOrResult<IsarAlbum?> getById(String id) async {
    return (await albumDataSource.find(id)).flatMapSuccessAsync((value) async {
      if (value != null) {
        return await _relationHelper.loadRelationsForAlbum(value);
      }
      return value.asResult;
    });
  }

  @override
  FutureOrResult<IsarAlbum> save(BaseAlbum album) async {
    final newIsarAlbum = _getIsarAlbumFromBase(album).setIdIfNull();
    // first check if an [IsarAlbum] was saved in the DB for this album id.
    final fetchingIsarAlbumResult =
        await albumDataSource.find(newIsarAlbum.id!);
    return await fetchingIsarAlbumResult
        .flatMapSuccessAsync((existingAlbum) async {
      if (existingAlbum != null) {
        final IsarAlbum updatedAlbum = _updateAlbumData(
          oldInstance: existingAlbum,
          newInstance: newIsarAlbum,
        );
        return await albumDataSource.save(updatedAlbum);
      } else {
        return await albumDataSource.save(newIsarAlbum);
      }
    });
  }

  IsarAlbum _getIsarAlbumFromBase(BaseAlbum baseAlbum) {
    return baseAlbum is IsarAlbum
        ? baseAlbum
        : IsarAlbum.fromMap(baseAlbum.toMap());
  }

  @override
  FutureOrResult<List<IsarAlbum>> saveAll(List<BaseAlbum> albums) async {
    List<IsarAlbum> result = [];
    for (BaseAlbum album in albums) {
      final savingAlbumResult = await save(album);
      if (savingAlbumResult.isFailure) {
        Log.e(savingAlbumResult);
      } else {
        result.add(savingAlbumResult.requireValue);
      }
    }
    return result.asResult;
  }

  IsarAlbum _updateAlbumData({
    required IsarAlbum oldInstance,
    required IsarAlbum newInstance,
  }) {
    return newInstance.copyWith(
      tracksIds: {
        ...oldInstance.tracksIds,
        ...newInstance.tracksIds,
      }.toList(),
      albumArtistId:
          newInstance.albumArtistId == null ? oldInstance.albumArtistId : null,
      featuredArtistsIds: {
        ...oldInstance.featuredArtistsIds,
        ...newInstance.featuredArtistsIds,
      }.toList(),
    );
  }
}
