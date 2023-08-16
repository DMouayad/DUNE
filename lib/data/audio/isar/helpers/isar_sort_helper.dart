import 'package:dune/support/enums/sort_type.dart';
import 'package:dune/support/models/query_options.dart';
import 'package:isar/isar.dart';

// extension IsarQueryBuilderExtension<Obj, R, S> on QueryBuilder<Obj, R, S> {
QueryBuilder<Obj, R, S> sortIsarQueryByOptions<Obj, R, S>(
  QueryBuilder<Obj, R, S> baseQuery,
  QuerySortOptions sortOptions, {
  QueryBuilder<Obj, R, S>? sortByCreatedAtQuery,
  QueryBuilder<Obj, R, S>? sortByCreatedAtDescQuery,
  QueryBuilder<Obj, R, S>? sortByNameQuery,
  QueryBuilder<Obj, R, S>? sortByNameDescQuery,
  QueryBuilder<Obj, R, S>? sortByDateReleasedQuery,
  QueryBuilder<Obj, R, S>? sortByDateReleasedDescQuery,
}) {
  return switch (sortOptions.sortBy) {
        SortType.dateAdded =>
          (sortOptions.desc ? sortByCreatedAtQuery : sortByCreatedAtDescQuery),
        SortType.alphabetically =>
          (sortOptions.desc ? sortByNameQuery : sortByNameDescQuery),
        SortType.releaseDate => (sortOptions.desc
            ? sortByDateReleasedQuery
            : sortByDateReleasedDescQuery),
      } ??
      baseQuery;
}
// }
