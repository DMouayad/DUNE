import 'package:dune/support/enums/music_source.dart';
import 'package:dune/support/models/query_options.dart';
import 'package:dune/support/utils/result/result.dart';

mixin FindsByMusicSource<T extends Object> {
  FutureOrResult<List<T>> findAllWhereSource(
      MusicSource musicSource, QuerySortOptions sortOptions);

  FutureOrResult<T?> findWhereSource(String id, MusicSource musicSource);
}
