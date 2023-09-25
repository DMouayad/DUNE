import 'package:dune/presentation/controllers/base_paged_items_controller.dart';
import 'package:dune/presentation/controllers/selection_controller.dart';
import 'package:dune/presentation/custom_widgets/persistent_page_header.dart';
import 'package:dune/support/enums/sort_type.dart';
import 'package:dune/support/extensions/context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:riverpod_infinite_scroll/riverpod_infinite_scroll.dart';

class LibraryItemsPage<T extends Object> extends ConsumerWidget {
  const LibraryItemsPage({
    super.key,
    required this.title,
    required this.pagedBuilder,
    required this.selectionControllerProvider,
    required this.itemsControllerProvider,
    required this.itemBuilder,
    required this.onSelectAll,
    this.onShuffleItems,
  });

  final Widget Function(PagingController<int, T> controller,
      PagedChildBuilderDelegate<T> builder) pagedBuilder;
  final String title;
  final StateNotifierProvider<SelectionController<T>, SelectionState<T>>
      selectionControllerProvider;
  final StateNotifierProvider<PagedItemsController<T>,
      QueryOptionsPagedState<T>> itemsControllerProvider;
  final void Function() onSelectAll;
  final void Function()? onShuffleItems;
  final Widget Function(BuildContext context, T item, int index) itemBuilder;

  @override
  Widget build(BuildContext context, ref) {
    final tracksState = ref.watch(itemsControllerProvider);
    return CustomScrollView(
      primary: true,
      slivers: [
        SliverPersistentHeader(
          pinned: true,
          delegate: PersistentPageHeaderDelegate<T>(
            trailingPositionBuilder: (headerMinimized, child) {
              return Positioned(
                bottom: headerMinimized ? 0 : 4,
                right: 0,
                left: 0,
                child: child,
              );
            },
            title: title,
            maxHeaderExtent: 100,
            minHeaderExtent: 80,
            itemsCount: tracksState.records?.length,
            onShuffle: onShuffleItems,
            selectionController: ref.read(selectionControllerProvider.notifier),
            selectionState: ref.watch(selectionControllerProvider),
            onSelectAll: onSelectAll,
            actions: [
              DropdownMenu(
                enableSearch: false,
                label: const Text('Sort By'),
                inputDecorationTheme: const InputDecorationTheme(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.zero,
                ),
                initialSelection: tracksState.queryOptions.sortBy,
                onSelected:
                    ref.read(itemsControllerProvider.notifier).setSortType,
                dropdownMenuEntries: SortType.values
                    .map((e) => DropdownMenuEntry(value: e, label: e.name))
                    .toList(),
              ),
              DropdownMenu(
                enableSearch: false,
                label: const Text('Order'),
                inputDecorationTheme: const InputDecorationTheme(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.zero,
                ),
                initialSelection: tracksState.queryOptions.sortDescending,
                onSelected: ref
                    .read(itemsControllerProvider.notifier)
                    .setIsDescendingOrder,
                dropdownMenuEntries: [
                  ('Descending', true),
                  ('Ascending', false)
                ]
                    .map((e) => DropdownMenuEntry(value: e.$2, label: e.$1))
                    .toList(),
              ),
            ],
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          sliver: RiverPagedBuilder<int, T>(
            provider: itemsControllerProvider,
            pullToRefresh: false,
            limit: ref.read(itemsControllerProvider).queryOptions.limit,
            itemBuilder: itemBuilder,
            firstPageKey: 1,
            noItemsFoundIndicatorBuilder: (context, controller) =>
                const _NoItemsFoundWidget(),
            noMoreItemsIndicatorBuilder: (context, controller) {
              return Center(
                child: Text(
                  "You've reached the end",
                  style: context.textTheme.bodyMedium,
                ),
              );
            },
            pagedBuilder: pagedBuilder,
          ),
        ),
      ],
    );
  }
}

class _NoItemsFoundWidget extends StatelessWidget {
  const _NoItemsFoundWidget();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Wrap(
        direction: Axis.vertical,
        alignment: WrapAlignment.center,
        crossAxisAlignment: WrapCrossAlignment.center,
        spacing: 10,
        children: [
          Icon(
            Icons.not_listed_location_outlined,
            color: context.colorScheme.primary,
          ),
          Text(
            'No items found',
            style: context.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
          const Text(
            'Note: in the settings page, you can specify where to look for music on your device',
          ),
        ],
      ),
    );
  }
}
