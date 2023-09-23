import 'package:collection/collection.dart';
import 'package:dune/presentation/models/tabs_state.dart';
import 'package:dune/presentation/providers/shared_providers.dart';
import 'package:dune/support/extensions/context_extensions.dart';
import 'package:dune/support/themes/theme_constants.dart';
import 'package:fluent_ui/fluent_ui.dart' as fluent;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

const _kTabHeight = 40.0;

class VerticalTabsList extends ConsumerStatefulWidget {
  const VerticalTabsList({
    required this.onTabChanged,
    required this.onAddNewTab,
    super.key,
    required this.extended,
  });

  final bool extended;
  final void Function(int index) onTabChanged;
  final void Function() onAddNewTab;

  @override
  ConsumerState<VerticalTabsList> createState() => _VerticalTabsListState();
}

class _VerticalTabsListState extends ConsumerState<VerticalTabsList> {
  @override
  Widget build(context) {
    final tabsState = ref.watch(tabsStateProvider);
    final tabs = tabsState.tabs;
    return ReorderableListView.builder(
      proxyDecorator: (child, index, anim) =>
          ClipRRect(borderRadius: kBorderRadius, child: child),
      buildDefaultDragHandles: false,
      shrinkWrap: true,
      // 8 = item's vertical margin * 2
      itemExtent: _kTabHeight + 4,
      itemBuilder: (BuildContext context, int index) {
        final tabData = tabs[index];
        return ReorderableDragStartListener(
          index: index,
          key: Key(index.toString()),
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 2.0),
            child: _VerticalTab(
              extended: widget.extended,
              onPressed: () => widget.onTabChanged(index),
              selected: tabData.tabIndex == tabsState.selectedTabIndex,
              data: tabData,
            ),
          ),
        );
      },
      itemCount: tabsState.tabsCount,
      onReorder: (int oldIndex, int newIndex) {
        if (newIndex < tabs.length - 1 && newIndex != oldIndex) {
          setState(() => tabs.swap(oldIndex, newIndex));
        }
      },
      footer: _NewTabButton(
          onPressed: widget.onAddNewTab, extended: widget.extended),
    );
  }
}

class _NewTabButton extends ConsumerWidget {
  const _NewTabButton({required this.onPressed, required this.extended});

  final bool extended;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context, ref) {
    return FilledButton(
      clipBehavior: Clip.hardEdge,
      onPressed: onPressed,
      style: ButtonStyle(
        elevation: MaterialStateProperty.all(0),
        shape: MaterialStateProperty.all(
            const RoundedRectangleBorder(borderRadius: kBorderRadius)),
        fixedSize:
            MaterialStateProperty.all(const Size.fromHeight(_kTabHeight)),
        padding: MaterialStateProperty.all(
            const EdgeInsets.symmetric(horizontal: 10)),
        foregroundColor: MaterialStateProperty.all(
            context.colorScheme.onPrimaryContainer.withOpacity(.5)),
        backgroundColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.hovered)) {
            return context.colorScheme.onPrimaryContainer.withOpacity(.1);
          }
          return Colors.transparent;
        }),
        textStyle:
            MaterialStateProperty.all(context.textTheme.bodySmall?.copyWith(
          fontWeight: FontWeight.w500,
        )),
      ),
      child: const fluent.SizedBox(
        height: _kTabHeight,
        width: double.infinity,
        child: Wrap(
          clipBehavior: Clip.hardEdge,
          runAlignment: WrapAlignment.center,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            SizedBox(
              height: _kTabHeight,
              width: _kTabHeight,
              child: Icon(Icons.add, size: 20),
            ),
            Text('New Tab'),
          ],
        ),
      ),
    );
  }
}

class _VerticalTab extends ConsumerWidget {
  _VerticalTab({
    required this.extended,
    required this.selected,
    required this.data,
    required this.onPressed,
  }) : super(key: Key(data.tabIndex.toString()));

  final void Function() onPressed;
  final bool selected;
  final TabData data;
  final bool extended;

  @override
  Widget build(BuildContext context, ref) {
    return FilledButton.tonal(
      onPressed: onPressed,
      style: ButtonStyle(
        elevation: selected ? null : MaterialStateProperty.all(0),
        shape: MaterialStateProperty.all(
            const RoundedRectangleBorder(borderRadius: kBorderRadius)),
        fixedSize:
            MaterialStateProperty.all(const Size.fromHeight(_kTabHeight)),
        padding: MaterialStateProperty.all(const EdgeInsets.all(4)),
        backgroundColor: MaterialStateProperty.resolveWith((s) {
          return selected ? context.colorScheme.background : Colors.transparent;
        }),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 10.0, right: 4),
        child: Row(
          children: [
            const fluent.Padding(
              padding: EdgeInsets.only(right: 10.0),
              child: Icon(fluent.FluentIcons.tab, size: 18),
            ),
            Expanded(
              child: Visibility(
                visible: extended,
                child: Text(
                  data.selectedPage?.title ?? 'new tab',
                  style: context.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w400,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.clip,
                ),
              ),
            ),
            Visibility(
              visible: extended,
              child: fluent.IconButton(
                onPressed: () {
                  ref
                      .read(tabsStateProvider.notifier)
                      .update((state) => state.withTabRemoved(data.tabIndex));
                },
                icon: Icon(
                  Icons.close,
                  size: context.isDesktopPlatform ? 16 : 18,
                  color: context.colorScheme.onBackground.withOpacity(.4),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
