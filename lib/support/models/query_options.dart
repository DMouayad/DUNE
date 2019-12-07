import 'package:dune/support/enums/sort_type.dart';
import 'package:equatable/equatable.dart';

class QueryOptions extends Equatable {
  static const defaultOptions = QueryOptions(
      sortBy: SortType.alphabetically, sortDescending: false, page: 1);

  const QueryOptions({
    this.sortBy = SortType.alphabetically,
    this.sortDescending = false,
    this.page = 1,
    this.limit = 15,
  });

  final SortType sortBy;
  final bool sortDescending;
  final int limit;
  final int page;

  int get offset => page * limit;

  QueryOptions copyWith({
    SortType? sortBy,
    bool? sortDescending,
    int? limit,
    int? page,
  }) {
    return QueryOptions(
      sortBy: sortBy ?? this.sortBy,
      sortDescending: sortDescending ?? this.sortDescending,
      limit: limit ?? this.limit,
      page: page ?? this.page,
    );
  }

  @override
  List<Object?> get props => [sortBy, sortDescending, limit, page];
}
