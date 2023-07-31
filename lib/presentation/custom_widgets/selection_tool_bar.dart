import 'package:dune/presentation/controllers/selection_controller.dart';
import 'package:dune/support/extensions/context_extensions.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' as material;

const _toolBarMaxHeight = 180.0;
const _toolBarMinHeight = 54.0;

class PersistentSelectionToolBar<ItemType extends Object>
    extends SliverPersistentHeaderDelegate {
  const PersistentSelectionToolBar({
    required this.controller,
    required this.selectionState,
    required this.onSelectAll,
    this.onDownload,
    this.onRemove,
  });

  final SelectionController<ItemType> controller;
  final SelectionState<ItemType> selectionState;
  final void Function() onSelectAll;
  final void Function()? onDownload;

  /// called when remove/delete option button is pressed
  final void Function()? onRemove;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return selectionState.selectionEnabled
        ? SelectionToolBar<ItemType>(
            controller: controller,
            selectionState: selectionState,
            onSelectAll: onSelectAll,
            onRemove: onRemove,
            onDownload: onDownload,
            isExpanded: shrinkOffset == 0,
          )
        : const SizedBox.shrink();
  }

  @override
  double get maxExtent {
    return selectionState.selectionEnabled
        ? selectionState.selectedValues.isEmpty
            ? _toolBarMinHeight
            : _toolBarMaxHeight
        : 0;
  }

  @override
  double get minExtent =>
      selectionState.selectionEnabled ? _toolBarMinHeight : 0;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}

class SelectionToolBar<ItemType extends Object> extends StatelessWidget {
  const SelectionToolBar({
    required this.controller,
    required this.selectionState,
    required this.onSelectAll,
    required this.isExpanded,
    super.key,
    this.onDownload,
    this.onRemove,
  });

  final SelectionController<ItemType> controller;
  final SelectionState<ItemType> selectionState;
  final void Function() onSelectAll;
  final void Function()? onDownload;
  final void Function()? onRemove;
  final bool isExpanded;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: context.colorScheme.background,
      child: Container(
        color: context.colorScheme.surfaceVariant.withOpacity(.2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 2,
                    child: CommandBar(
                      compactBreakpointWidth: 150,
                      overflowBehavior: CommandBarOverflowBehavior.scrolling,
                      mainAxisAlignment: MainAxisAlignment.end,
                      primaryItems: [
                        _CustomCommandBarButton(
                          FluentIcons.download,
                          "download",
                          onPressed: onDownload ?? () {},
                        ),
                        _CustomCommandBarButton(
                          FluentIcons.add_to,
                          "add to playlist",
                          onPressed: () {},
                        ),
                        if (onRemove != null)
                          _CustomCommandBarButton(
                            FluentIcons.remove,
                            "remove",
                            onPressed: onRemove,
                          ),
                      ],
                    ),
                  ),
                  if (context.screenWidth > 900) const Spacer(),
                  Expanded(
                    flex: context.isDesktop ? 2 : 1,
                    child: CommandBar(
                      compactBreakpointWidth: 300,
                      // overflowBehavior: CommandBarOverflowBehavior.scrolling,
                      // isCompact: true,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      primaryItems: [
                        _CustomCommandBarButton(
                          FluentIcons.cancel,
                          "cancel",
                          onPressed: controller.cancelSelection,
                        ),
                        _CustomCommandBarButton(
                          FluentIcons.clear_selection,
                          "clear",
                          onPressed: controller.clearSelections,
                        ),
                        _CustomCommandBarButton(
                          FluentIcons.select_all,
                          "Select All",
                          onPressed: onSelectAll,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Text(
                      "(${selectionState.selectedValues.length}) selected",
                      style: context.textTheme.titleSmall?.copyWith(
                        color: context.colorScheme.primary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            if (isExpanded) ...[
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GridView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: selectionState.selectedValues.length,
                    gridDelegate:
                        const material.SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 34,
                      mainAxisExtent: 120,
                      mainAxisSpacing: 3,
                      crossAxisSpacing: 3,
                    ),
                    itemBuilder: (context, index) {
                      final entry = selectionState.selectedValues.entries
                          .elementAt(index);
                      return SizedBox(
                        width: 120,
                        child: material.FilterChip(
                          tooltip: 'tap to unselect',
                          label: Text(
                            selectionState.itemToString(entry.value),
                            style: context.textTheme.bodySmall?.copyWith(
                              fontWeight: FontWeight.w500,
                              color: context.colorScheme.onPrimaryContainer,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          showCheckmark: false,
                          selectedColor: context.colorScheme.secondaryContainer,
                          selected: true,
                          onSelected: (selected) {
                            controller.toggleSelectionForItem(
                              entry.key,
                              entry.value,
                            );
                          },
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _CustomCommandBarButton extends CommandBarBuilderItem {
  _CustomCommandBarButton(
    IconData iconData,
    String label, {
    void Function()? onPressed,
    String? tooltipMessage,
  }) : super(
          builder: (context, displayMode, wrappedItem) => Tooltip(
            message: tooltipMessage ?? label,
            child: wrappedItem,
          ),
          wrappedItem: CommandBarButton(
            onPressed: onPressed,
            icon: Icon(iconData),
            label: Text(label),
          ),
        );
}
