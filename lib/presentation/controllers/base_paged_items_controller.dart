import 'package:dune/support/models/query_options.dart';
import 'package:dune/support/utils/result/result.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_infinite_scroll/riverpod_infinite_scroll.dart';

/// Provides pagination for a list of items.
///
/// [onLoadItems] will be called to load a new page.
class PagedItemsController<T> extends StateNotifier<QueryOptionsPagedState<T>>
    with PagedNotifierMixin<int, T, QueryOptionsPagedState<T>> {
  PagedItemsController({required this.onLoadItems})
      : super(QueryOptionsPagedState());

  final FutureResult<List<T>> Function(QueryOptions queryOptions) onLoadItems;

  @override
  Future<List<T>?> load(int page, int limit) async {
    // if the page has already been loaded, we only need
    // to set [nextPageKey]
    if (state.previousPageKeys.contains(page)) {
      // why we have to use [addPostFrameCallback]?
      // well, since we're not fetching any items, updating the state right away
      // (while the widget is being built) will throw un exception.
      WidgetsBinding.instance.addPostFrameCallback((_) {
        state = state.copyWith(nextPageKey: page + 1);
      });
      return null;
    }
    final newQueryOptions =
        state.queryOptions.copyWith(page: page, limit: limit);

    (await onLoadItems(newQueryOptions)).mapTo(
      onSuccess: (items) {
        state = state.copyWith(
          records: [...(state.records ?? []), ...items],
          nextPageKey: items.isEmpty ? null : page + 1,
          previousPageKeys:
              items.isEmpty ? null : {...state.previousPageKeys, page}.toList(),
          queryOptions: newQueryOptions,
        );
      },
      onFailure: (e) => [],
    );
    return null;
  }
}

class QueryOptionsPagedState<T> extends PagedState<int, T> {
  final QueryOptions queryOptions;

  QueryOptionsPagedState({
    this.queryOptions = QueryOptions.defaultOptions,
    super.nextPageKey,
    super.error,
    super.previousPageKeys,
    super.records,
  });

  @override
  QueryOptionsPagedState<T> copyWith({
    QueryOptions? queryOptions,
    List<T>? records,
    dynamic error,
    dynamic nextPageKey = undefined,
    List<int>? previousPageKeys,
  }) {
    final sup = super.copyWith(
      records: records,
      previousPageKeys: previousPageKeys,
      nextPageKey: nextPageKey,
      error: error,
    );
    return QueryOptionsPagedState(
      queryOptions: queryOptions ?? this.queryOptions,
      error: sup.error,
      nextPageKey: sup.nextPageKey,
      previousPageKeys: sup.previousPageKeys,
      records: sup.records,
    );
  }
}
