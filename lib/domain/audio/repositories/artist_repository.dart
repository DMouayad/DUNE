import 'package:dune/domain/audio/base_data_sources/base_artist_data_source.dart';
import 'package:dune/domain/audio/base_models/base_artist.dart';
import 'package:dune/domain/audio/traits/finds_by_music_source.dart';
import 'package:dune/support/utils/result/result.dart';

abstract base class ArtistRepository<DataSource extends BaseArtistDataSource> {
  final DataSource _artistDataSource;

  DataSource get artistDataSource => _artistDataSource;

  ArtistRepository(this._artistDataSource);

  FutureResult<BaseArtist?> getById(String id) async {
    return await _artistDataSource.find(id);
  }
}

abstract base class SavableArtistRepository<
        DataSource extends BaseSavableArtistDataSource>
    extends ArtistRepository<DataSource> with FindsByMusicSource<BaseArtist> {
  SavableArtistRepository(super.artistDataSource);

  FutureResult<BaseArtist> save(BaseArtist artist);

  FutureResult<List<BaseArtist>> saveAll(List<BaseArtist> artists);

  FutureResult<List<BaseArtist>> removeAllById(List<String> ids);
}
