import 'dart:math';

import 'package:dune/presentation/controllers/selection_controller.dart';
import 'package:dune/presentation/models/selection_state.dart';
import 'package:dune/support/extensions/context_extensions.dart';
import 'package:fluent_ui/fluent_ui.dart';

class SelectionToolBar extends StatelessWidget {
  const SelectionToolBar({
    required this.controller,
    required this.selectionState,
    required this.onSelectAll,
    super.key,
    this.onDownload,
    this.onRemove,
  });

  final SelectionController controller;
  final SelectionState selectionState;
  final void Function() onSelectAll;
  final void Function()? onDownload;
  final void Function()? onRemove;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      color: context.colorScheme.surfaceVariant.withOpacity(.5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "(${selectionState.selectedValues.length}) Selected",
            style: context.textTheme.titleMedium?.copyWith(
              color: context.colorScheme.primary,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: CommandBar(
                compactBreakpointWidth: 300,
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
                ]),
          ),
          Spacer(
            flex: context.isPortraitTablet ? 0 : 1,
          ),
          Expanded(
            flex: context.isPortraitTablet ? 1 : 2,
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
        ],
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
