import 'package:dune/support/enums/sort_type.dart';
import 'package:dune/support/models/query_options.dart';
import 'package:isar/isar.dart';

/// Returns a [QueryBuilder] after adding the right sorting to it based on the
/// provided [QueryOptions].
///
/// If no matching sort query is available, [baseQuery] will be returned.
QueryBuilder<Obj, R, QAfterLimit> applyQueryOptionsOnIsarQueryBuilder<Obj, R>(
  QueryBuilder<Obj, R, QAfterWhereClause> baseQuery,
  QueryOptions queryOptions, {
  QueryBuilder<Obj, R, QAfterSortBy>? sortByCreatedAtQuery,
  QueryBuilder<Obj, R, QAfterSortBy>? sortByCreatedAtDescQuery,
  QueryBuilder<Obj, R, QAfterSortBy>? sortByNameQuery,
  QueryBuilder<Obj, R, QAfterSortBy>? sortByNameDescQuery,
  QueryBuilder<Obj, R, QAfterSortBy>? sortByDateReleasedQuery,
  QueryBuilder<Obj, R, QAfterSortBy>? sortByDateReleasedDescQuery,
}) {
  final queryWithSorting = switch (queryOptions.sortBy) {
    SortType.dateAdded => (queryOptions.sortDescending
        ? sortByCreatedAtDescQuery
        : sortByCreatedAtQuery),
    SortType.alphabetically =>
      (queryOptions.sortDescending ? sortByNameDescQuery : sortByNameQuery),
    SortType.releaseDate => (queryOptions.sortDescending
        ? sortByDateReleasedDescQuery
        : sortByDateReleasedQuery),
  };
  return queryWithSorting
          ?.offset(queryOptions.offset)
          .limit(queryOptions.limit) ??
      baseQuery.offset(queryOptions.offset).limit(queryOptions.limit);
}
