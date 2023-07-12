import 'package:dune/domain/audio/base_data_sources/base_artist_data_source.dart';
import 'package:dune/domain/audio/base_models/base_artist.dart';
import 'package:dune/support/utils/result/result.dart';

abstract base class ArtistRepository<DataSource extends BaseArtistDataSource> {
  final DataSource _artistDataSource;

  DataSource get artistDataSource => _artistDataSource;

  ArtistRepository(this._artistDataSource);

  FutureOrResult<BaseArtist?> getById(String id) async {
    return await _artistDataSource.find(id);
  }
}

abstract base class SavableArtistRepository<
        DataSource extends BaseArtistDataSource>
    extends ArtistRepository<DataSource> {
  SavableArtistRepository(super.artistDataSource);

  FutureOrResult<BaseArtist> save(BaseArtist artist);

  FutureOrResult<List<BaseArtist>> saveAll(List<BaseArtist> artists);
}
