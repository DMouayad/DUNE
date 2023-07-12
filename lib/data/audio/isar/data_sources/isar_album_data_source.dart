import 'package:dune/data/audio/isar/models/isar_album.dart';
import 'package:dune/domain/audio/base_data_sources/base_album_data_source.dart';
import 'package:dune/support/utils/result/result.dart';
import 'package:isar/isar.dart';

class IsarAlbumDataSource implements BaseAlbumDataSource<IsarAlbum> {
  IsarAlbumDataSource(this._isar);

  final Isar _isar;

  @override
  FutureOrResult<IsarAlbum?> find(String albumId) async {
    return await Result.fromAsync(
      () async =>
          await _isar.isarAlbums.filter().idEqualTo(albumId).findFirst(),
    );
  }

  @override
  FutureOrResult<IsarAlbum> save(IsarAlbum album) async {
    return await Result.fromAsync(() async {
      final id =
          await _isar.writeTxn(() async => await _isar.isarAlbums.put(album));
      return album.copyWith(isarId: id);
    });
  }

  FutureOrResult<List<IsarAlbum>> saveAll(List<IsarAlbum> albums) async {
    return await Result.fromAsync(() async {
      await _isar.writeTxn(() async {
        await _isar.isarAlbums.putAll(albums);
      });
      return albums;
    });
  }

  @override
  FutureOrResult<List<IsarAlbum>> getWhereIds(List<String> ids) async {
    return await Result.fromAsync(() async {
      return await _isar.isarAlbums
          .where()
          .anyOf(ids, (q, id) => q.idEqualTo(id))
          .findAll();
    });
  }
}
