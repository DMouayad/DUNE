import 'package:dune/domain/audio/base_models/base_explore_music_item.dart';
import 'package:dune/domain/audio/base_models/base_playlist.dart';
import 'package:dune/navigation/app_router.dart';
import 'package:dune/presentation/pages/explore_music_category_page.dart';
import 'package:dune/presentation/pages/playlist_page/playlist_page.dart';
import 'package:dune/presentation/providers/state_controllers.dart';
import 'package:dune/presentation/screens/home/components/app_tab_view.dart';
import 'package:dune/support/extensions/context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'app_tab_view_helper.dart';

class NavigationHelper {
  /// either [playlist] or [exploreItem] should be not null
  static void onPlaylistItemCardPressed(
    BuildContext context,
    WidgetRef ref, {
    BaseExploreMusicItem? exploreItem,
    BasePlaylist? playlist,
    String? currentLocation,
  }) {
    assert(playlist != null || exploreItem != null);
    final source = exploreItem?.source ?? playlist!.source;
    final title = exploreItem?.title ?? playlist!.title;
    final sourceId = exploreItem?.sourceId ?? playlist!.id!;
    // fetch playlist tracks and data
    final description = exploreItem?.description ?? playlist!.description;
    final thumbnails = exploreItem?.thumbnails ?? playlist!.thumbnails;
    final tracksCount = exploreItem?.count;
    final musicSource = exploreItem?.source ?? playlist!.source;
    ref.read(playlistControllerProvider.notifier).get(sourceId, source);
    if (!context.isMobile &&
        ref.watch(appPreferencesController).tabsModeEnabled) {
      final newTab = TabData(
        title: title!,
        tabKey: title,
        type: TabContentType.playlist,
        body: PlaylistPage(
          musicSource: musicSource,
          playlistId: sourceId,
          title: title,
          description: description,
          thumbnails: thumbnails,
          tracksCount: tracksCount,
        ),
      );
      AppTabViewHelper.addNewTab(newTab, ref);
    } else {
      context.push(
        '${currentLocation ?? AppRouter.currentLocation}/playlist/$sourceId',
        extra: (
          tracksCount: tracksCount,
          title: title,
          description: description,
          thumbnails: thumbnails,
          musicSource: musicSource,
        ),
      );
    }
  }

  static void onExploreMusicCategoryCardPressed(
    BuildContext context,
    WidgetRef ref, {
    required BaseExploreMusicItem exploreItem,
  }) {
    ref
        .read(exploreMusicCategoriesControllerProvider.notifier)
        .get(exploreItem.sourceId, exploreItem.source);
    if (!context.isMobile &&
        ref.watch(appPreferencesController).tabsModeEnabled) {
      final newTab = TabData(
        title: exploreItem.title,
        tabKey: exploreItem.title,
        type: TabContentType.other,
        body: ExploreMusicCategoryPage(
          title: exploreItem.title,
          categoryId: exploreItem.sourceId,
        ),
      );
      AppTabViewHelper.addNewTab(newTab, ref);
    } else {
      context.push(
        '${AppRouter.currentLocation}/explore-music-category/${exploreItem.sourceId}',
        extra: (
          categoryId: exploreItem.sourceId,
          title: exploreItem.title,
        ),
      );
    }
  }
}
