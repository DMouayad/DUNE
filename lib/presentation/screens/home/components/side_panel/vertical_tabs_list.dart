import 'package:dune/presentation/providers/shared_providers.dart';
import 'package:dune/presentation/providers/state_controllers.dart';
import 'package:dune/presentation/utils/constants.dart';
import 'package:fluent_ui/fluent_ui.dart' as fluent;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//
import 'package:dune/navigation/navigation.dart';
import 'package:dune/support/extensions/context_extensions.dart';
import 'package:dune/support/themes/theme_constants.dart';

import 'new_vertical_tab_button.dart';

class VerticalTabsList extends ConsumerWidget {
  const VerticalTabsList({super.key, required this.extended});

  final bool extended;

  @override
  Widget build(context, ref) {
    return ValueListenableBuilder(
        valueListenable: AppNavigation.instance.tabs!.stateNotifier,
        builder: (context, tabsState, _) {
          return ReorderableListView.builder(
            proxyDecorator: (child, index, _) =>
                ClipRRect(borderRadius: kBorderRadius, child: child),
            buildDefaultDragHandles: false,
            shrinkWrap: true,
            itemExtent: kVerticalTabHeight,
            itemBuilder: (BuildContext context, int index) {
              final tabData = tabsState.tabs[index];
              return ReorderableDragStartListener(
                index: index,
                key: Key(index.toString()),
                child: VerticalTab(
                  extended: extended,
                  selected: tabData.tabIndex == tabsState.selectedTabIndex,
                  data: tabData,
                ),
              );
            },
            onReorderStart: (_) => ref
                .read(isReorderingVerticalTabsProvider.notifier)
                .state = true,
            onReorderEnd: (_) => ref
                .read(isReorderingVerticalTabsProvider.notifier)
                .state = false,
            itemCount: tabsState.tabsCount,
            onReorder: AppNavigation.instance.tabs!.reorderTab,
            footer: const NewVerticalTabButton(),
          );
        });
  }
}

class VerticalTab extends ConsumerWidget {
  VerticalTab({
    required this.extended,
    required this.selected,
    required this.data,
  }) : super(key: Key(data.tabIndex.toString()));

  final bool selected;
  final TabData data;
  final bool extended;

  @override
  Widget build(BuildContext context, ref) {
    return FilledButton.tonal(
      onPressed: () {
        AppNavigation.instance.tabs!.selectTabAt(data.tabIndex);
      },
      style: ButtonStyle(
        elevation: MaterialStateProperty.all(0),
        shape: MaterialStateProperty.all(
            const RoundedRectangleBorder(borderRadius: kBorderRadius)),
        fixedSize: MaterialStateProperty.all(
            const Size.fromHeight(kVerticalTabHeight)),
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
        constraints: const BoxConstraints.expand(height: kVerticalTabHeight),
        child: Stack(
          clipBehavior: Clip.hardEdge,
          alignment: extended ? Alignment.centerLeft : Alignment.center,
          children: [
            const SizedBox(
              height: kVerticalTabHeight,
              width: kVerticalTabHeight,
              child: Icon(fluent.FluentIcons.tab, size: 14),
            ),
            Positioned(
              left: kVerticalTabHeight + (extended ? 0 : 10),
              child: ValueListenableBuilder(
                valueListenable: data.pageNotifier,
                builder: (context, page, _) {
                  return Text(
                    page.title,
                    maxLines: 1,
                    overflow: TextOverflow.clip,
                  );
                },
              ),
            ),
            Positioned(
              right: 0,
              child: Visibility(
                visible: extended,
                child: SizedBox(
                  height: kVerticalTabHeight,
                  width: kVerticalTabHeight,
                  child: fluent.IconButton(
                    onPressed: () {
                      AppNavigation.instance.tabs!.removeTabAt(data.tabIndex);
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
