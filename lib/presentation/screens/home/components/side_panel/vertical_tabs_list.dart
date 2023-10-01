import 'package:dune/presentation/providers/state_controllers.dart';
import 'package:dune/presentation/utils/tabs_helper.dart';
import 'package:fluent_ui/fluent_ui.dart' as fluent;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//
import 'package:dune/navigation/tabs_state.dart';
import 'package:dune/presentation/providers/shared_providers.dart';
import 'package:dune/support/extensions/context_extensions.dart';
import 'package:dune/support/themes/theme_constants.dart';

const _kTabHeight = 38.0;

class VerticalTabsList extends ConsumerWidget {
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
  Widget build(context, ref) {
    final tabsState = ref.watch(tabsStateProvider);
    final tabs = tabsState.tabs;
    return ReorderableListView.builder(
      proxyDecorator: (child, index, anim) =>
          ClipRRect(borderRadius: kBorderRadius, child: child),
      buildDefaultDragHandles: false,
      shrinkWrap: true,
      itemExtent: _kTabHeight,
      itemBuilder: (BuildContext context, int index) {
        final tabData = tabs[index];
        return ReorderableDragStartListener(
          index: index,
          key: Key(index.toString()),
          child: _VerticalTab(
            extended: extended,
            onPressed: () => onTabChanged(index),
            selected: tabData.tabIndex == tabsState.selectedTabIndex,
            data: tabData,
          ),
        );
      },
      itemCount: tabsState.tabsCount,
      onReorder: (oldIndex, newIndex) =>
          TabsHelper.onTabsReorder(oldIndex, newIndex, ref),
      footer: _NewTabButton(onPressed: onAddNewTab),
    );
  }
}

class _NewTabButton extends ConsumerWidget {
  const _NewTabButton({required this.onPressed});

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
            const EdgeInsets.symmetric(horizontal: 4)),
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
          runAlignment: WrapAlignment.start,
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
        elevation: MaterialStateProperty.all(0),
        shape: MaterialStateProperty.all(
            const RoundedRectangleBorder(borderRadius: kBorderRadius)),
        fixedSize:
            MaterialStateProperty.all(const Size.fromHeight(_kTabHeight)),
        padding: MaterialStateProperty.all(const EdgeInsets.all(4)),
        backgroundColor: MaterialStateProperty.resolveWith((states) {
          return selected
              ? ref.watch(appThemeControllerProvider).acrylicWindowEffectEnabled
                  ? context.colorScheme.backgroundOnAcrylicCard
                  : context.colorScheme.backgroundOnCard
              : Colors.transparent;
        }),
        textStyle: MaterialStateProperty.all(context.textTheme.bodyMedium),
        foregroundColor: MaterialStateProperty.resolveWith((states) {
          return selected
              ? context.colorScheme.secondary
              : context.colorScheme.onBackground.withOpacity(.7);
        }),
      ),
      child: Container(
        constraints: const BoxConstraints.expand(height: _kTabHeight),
        child: Stack(
          clipBehavior: Clip.hardEdge,
          alignment: extended ? Alignment.centerLeft : Alignment.center,
          children: [
            const SizedBox(
              height: _kTabHeight,
              width: _kTabHeight,
              child: Icon(fluent.FluentIcons.tab, size: 14),
            ),
            Positioned(
              left: _kTabHeight + (extended ? 0 : 10),
              child: Text(
                data.selectedPage?.title ?? 'new tab',
                maxLines: 1,
                overflow: TextOverflow.clip,
              ),
            ),
            Positioned(
              right: 0,
              child: Visibility(
                visible: extended,
                child: SizedBox(
                  height: _kTabHeight,
                  width: _kTabHeight,
                  child: fluent.IconButton(
                    onPressed: () {
                      ref.read(tabsStateProvider.notifier).update(
                          (state) => state.withTabRemoved(data.tabIndex));
                    },
                    icon: Icon(
                      Icons.close,
                      size: context.isDesktopPlatform ? 16 : 18,
                      color: context.colorScheme.onBackground.withOpacity(.4),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
