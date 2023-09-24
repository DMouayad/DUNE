import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
//
import 'package:dune/support/extensions/context_extensions.dart';
import 'package:dune/presentation/custom_widgets/custom_tab_view.dart';
import 'package:dune/presentation/providers/shared_providers.dart';

class TabsBar extends ConsumerWidget {
  const TabsBar({
    required this.onTabChanged,
    required this.onAddNewTab,
    this.footer,
    super.key,
  });

  final void Function()? onAddNewTab;
  final void Function(int index)? onTabChanged;
  final Widget? footer;

  @override
  Widget build(BuildContext context, ref) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: context.colorScheme.background,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 6),
      margin: const EdgeInsets.only(top: 4),
      child: CustomTabView(
        onChanged: onTabChanged,
        currentIndex: ref.watch(tabsStateProvider).selectedTabIndex,
        onNewPressed: onAddNewTab,
        showScrollButtons: false,
        footer: footer != null
            ? Padding(
                padding: const EdgeInsetsDirectional.only(end: 8),
                child: footer,
              )
            : null,
        tabs: ref
            .watch(tabsStateProvider.select((s) => s.tabs.asMap().entries))
            .map((entry) => CustomTab(
                  text: Text(entry.value.selectedPage?.title ?? 'New tab'),
                  onClosed: () => _onCloseTab(entry.key, ref),
                ))
            .toList(),
      ),
    );
  }

  void _onCloseTab(int index, WidgetRef ref) {
    ref
        .read(tabsStateProvider.notifier)
        .update((state) => state.withTabRemoved(index));
  }
}
