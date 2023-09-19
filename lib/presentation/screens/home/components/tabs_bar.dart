import 'package:dune/support/extensions/context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluent_ui/fluent_ui.dart' as fluent;

//
import 'package:dune/navigation/app_router.dart';
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
        borderRadius: BorderRadius.circular(10),
        color: context.colorScheme.background,
      ),
      padding: EdgeInsets.zero,
      margin: const EdgeInsets.symmetric(horizontal: 6),
      child: CustomTabView(
        onChanged: onTabChanged,
        currentIndex: ref.watch(tabsStateProvider).selectedTabIndex,
        minTabWidth: 130,
        onNewPressed: onAddNewTab,
        showScrollButtons: false,
        header: Row(
          children: [
            const SizedBox(width: 4),
            fluent.IconButton(
              style: fluent.ButtonStyle(
                iconSize: fluent.ButtonState.all(18),
              ),
              icon: const fluent.Icon(fluent.FluentIcons.history),
              onPressed: () {},
            ),
            const SizedBox(width: 10),
            fluent.IconButton(
              style: fluent.ButtonStyle(
                iconSize: fluent.ButtonState.all(18),
              ),
              icon: const fluent.Icon(fluent.FluentIcons.back),
              onPressed: () {
                final canPop = AppRouter.router.canPop();
                if (canPop) {
                  AppRouter.router.pop();
                  ref
                      .read(tabsStateProvider.notifier)
                      .update((state) => state.withPreviousPageSelected());
                }
              },
            ),
            const SizedBox(width: 12),
          ],
        ),
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
