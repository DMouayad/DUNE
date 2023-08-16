import 'package:dune/support/enums/sort_type.dart';
import 'package:dune/support/models/query_options.dart';
import 'package:isar/isar.dart';

/// Returns a [QueryBuilder] after adding the right sorting to it based on the
/// provided [QuerySortOptions].
///
/// If no matching sort query is available, [baseQuery] will be returned.
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
          (sortOptions.desc ? sortByCreatedAtDescQuery : sortByCreatedAtQuery),
        SortType.alphabetically =>
          (sortOptions.desc ? sortByNameDescQuery : sortByNameQuery),
        SortType.releaseDate => (sortOptions.desc
            ? sortByDateReleasedDescQuery
            : sortByDateReleasedQuery),
      } ??
      baseQuery;
}
