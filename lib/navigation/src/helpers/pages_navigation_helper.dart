import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

//
import 'package:dune/domain/audio/base_models/base_album.dart';
import 'package:dune/domain/audio/base_models/base_artist.dart';
import 'package:dune/domain/audio/base_models/base_explore_music_item.dart';
import 'package:dune/domain/audio/base_models/base_playlist.dart';
import 'package:dune/navigation/navigation.dart';
import 'package:dune/presentation/pages/settings_page/settings_page.dart';
import 'package:dune/presentation/providers/state_controllers.dart';

mixin PagesNavigationHelper {
  /// one of [playlist] or [exploreItem] cannot be null.
  void onPlaylistItemCardPressed(
    BuildContext context, {
    BaseExploreMusicItem? exploreItem,
    BasePlaylist? playlist,
  }) {
    assert(playlist != null || exploreItem != null);
    final pagePlaylist = playlist ?? BasePlaylist.fromExploreItem(exploreItem!);
    final path = _getPath('/playlist/${pagePlaylist.id}');
    context.push(path, extra: pagePlaylist);
  }

  void onGoToArtistPage(BuildContext context, BaseArtist artist) {
    final path = _getPath('/artist/${artist.id}');
    if (path != AppNavigation.instance.currentLocation) {
      context.push(path, extra: artist);
    }
  }

  void onGoToAlbumPage(BuildContext context, BaseAlbum album) {
    final path = _getPath('/album/${album.id}');
    if (path != AppNavigation.instance.currentLocation) {
      context.push(path, extra: album);
    }
  }

  String _getPath(String base) {
    // if (AppNavigation.instance.tabsModeEnabled) {
    //   final reg = RegExp(r'^/tabs/\d');
    //   final tabsInfo =
    //       reg.firstMatch(AppNavigation.instance.currentLocation)?[0];
    //   final currentTab = tabsInfo?.split('/').last ?? "0";
    //   return '/tabs/$currentTab$base';
    // } else {
    return base;
    // }
  }

  void onExploreMusicCategoryCardPressed(
    BuildContext context,
    WidgetRef ref, {
    required BaseExploreMusicItem exploreItem,
  }) {
    ref
        .read(exploreMusicCategoriesControllerProvider.notifier)
        .get(exploreItem.sourceId, exploreItem.source);

    final base = RoutePath.exploreMusicCategoryPage
        .replaceAll(':categoryId', exploreItem.sourceId);
    final path = _getPath(base);

    if (path != AppNavigation.instance.currentLocation) {
      context.push(path, extra: exploreItem.title);
    }
  }

  void showSettingsDialog(BuildContext context) {
    showDialog(context: context, builder: (context) => const SettingsDialog());
  }
}
