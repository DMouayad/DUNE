import 'package:dune/presentation/custom_widgets/page_body_wrapper.dart';
import 'package:dune/presentation/utils/app_tab_view_helper.dart';
import 'package:dune/presentation/providers/shared_providers.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' as material;
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppTabView extends ConsumerWidget {
  const AppTabView({this.footer, super.key});

  final Widget? footer;

  @override
  Widget build(BuildContext context, ref) {
    return TabView(
      onChanged: (index) => _onTabChanged(index, ref),
      currentIndex: ref.watch(selectedTapIndexProvider),
      footer: footer != null
          ? Padding(
              padding: const EdgeInsetsDirectional.only(end: 8),
              child: footer,
            )
          : null,
      tabs: ref
          .watch(homeScreenTabsProvider)
          .map((e) => Tab(
                key: Key(e.tabKey),
                text: _getTabTitle(e, context),
                onClosed: () {
                  AppTabViewHelper.onCloseTab(e, ref);
                },
                body: PageBodyWrapper(tabsModeEnabled: true, child: e.body),
              ))
          .toList(),
    );
  }

  void _onTabChanged(int index, WidgetRef ref) {
    if (ref.watch(selectedTapIndexProvider) != index) {
      ref.read(selectedTapIndexProvider.notifier).update((state) => index);
    }
  }

  Widget _getTabTitle(TabData e, BuildContext context) {
    return e.type == TabContentType.other
        ? Text(e.title)
        : Row(
            children: [
              Icon(
                switch (e.type) {
                  TabContentType.artist => material.Icons.person_2,
                  TabContentType.album => material.Icons.album,
                  TabContentType.playlist =>
                    material.Icons.playlist_play_outlined,
                  TabContentType.song => material.Icons.audiotrack,
                  _ => throw UnimplementedError(),
                },
                size: 18,
              ),
              const SizedBox(width: 4),
              Expanded(child: Text(e.title)),
            ],
          );
  }
}

class TabData {
  final String title;
  final Widget body;
  final String tabKey;
  final TabContentType type;

  TabData({
    required String title,
    required this.body,
    required this.tabKey,
    this.type = TabContentType.other,
  }) : title = title.replaceAll('/', '');
}

enum TabContentType { song, album, playlist, artist, other }
