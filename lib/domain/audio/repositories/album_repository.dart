import 'package:dune/domain/audio/base_data_sources/base_album_data_source.dart';
import 'package:dune/domain/audio/base_models/base_album.dart';
import 'package:dune/domain/audio/traits/finds_by_music_source.dart';
import 'package:dune/support/utils/result/result.dart';

abstract base class AlbumRepository<DataSource extends BaseAlbumDataSource> {
  final DataSource _albumDataSource;

  DataSource get albumDataSource => _albumDataSource;

  AlbumRepository(this._albumDataSource);

  FutureOrResult<BaseAlbum?> getById(String id) async {
    return await _albumDataSource.find(id);
  }
}

abstract base class SavableAlbumRepository<
        DataSource extends BaseSavableAlbumDataSource>
    extends AlbumRepository<DataSource> with FindsByMusicSource<BaseAlbum> {
  SavableAlbumRepository(super.albumDataSource);

  FutureOrResult<BaseAlbum> save(BaseAlbum album);

  FutureOrResult<List<BaseAlbum>> saveAll(List<BaseAlbum> albums);
}
