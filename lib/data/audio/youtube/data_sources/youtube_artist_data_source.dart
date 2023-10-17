import 'package:dune/domain/audio/base_data_sources/base_artist_data_source.dart';
import 'package:dune/domain/audio/base_models/base_artist.dart';
import 'package:dune/support/utils/result/result.dart';

final class YoutubeArtistDataSource implements BaseArtistDataSource {
  const YoutubeArtistDataSource();

  @override
  FutureOrResult<BaseArtist?> find(String artistId) async {
    return await Result.fromAsync(() async => null);
  }

  @override
  FutureOrResult<List<BaseArtist>> getWhereIds(List<String> ids) {
    // TODO: implement getWhereIds
    throw UnimplementedError();
  }
}
