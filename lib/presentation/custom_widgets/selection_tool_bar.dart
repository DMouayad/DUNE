import 'package:dune/presentation/controllers/selection_controller.dart';
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
    return selectionState.selectionEnabled
        ? Container(
            height: 50,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            color: context.colorScheme.surfaceVariant.withOpacity(.5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: context.isPortraitTablet ? 2 : 1,
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
          )
        : const SizedBox.shrink();
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
