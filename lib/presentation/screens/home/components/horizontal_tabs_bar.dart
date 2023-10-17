import 'package:dune/navigation/navigation.dart';
import 'package:flutter/material.dart';

//
import 'package:dune/support/extensions/context_extensions.dart';
import 'package:dune/presentation/custom_widgets/custom_tab_view.dart';

class HorizontalTabsBar extends StatelessWidget {
  const HorizontalTabsBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: context.colorScheme.background,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 6),
      margin: const EdgeInsets.only(top: 4),
      child: ValueListenableBuilder(
        valueListenable: AppNavigation.instance.tabs!.stateNotifier,
        builder: (context, tabsState, child) {
          return CustomTabView(
            onChanged: AppNavigation.instance.tabs!.selectTabAt,
            onNewPressed: AppNavigation.instance.tabs!.addNewTab,
            onReorder: AppNavigation.instance.tabs!.reorderTab,
            currentIndex: tabsState.selectedTabIndex,
            showScrollButtons: false,
            tabs: tabsState.tabs.map((tabData) {
              return CustomTab(
                text: ValueListenableBuilder(
                  valueListenable: tabData.pageNotifier,
                  builder: (context, page, _) {
                    return Text(
                      page.title,
                      maxLines: 1,
                      overflow: TextOverflow.clip,
                    );
                  },
                ),
                onClosed: () =>
                    AppNavigation.instance.tabs!.removeTabAt(tabData.tabIndex),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
