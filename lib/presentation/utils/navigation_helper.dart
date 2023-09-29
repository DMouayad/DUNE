import 'package:dune/domain/audio/base_models/base_artist.dart';
import 'package:dune/presentation/providers/shared_providers.dart';
import 'package:dune/support/themes/theme_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

//
import 'package:dune/presentation/pages/settings_page/settings_page.dart';
import 'package:dune/domain/audio/base_models/base_explore_music_item.dart';
import 'package:dune/domain/audio/base_models/base_playlist.dart';
import 'package:dune/navigation/app_router.dart';
import 'package:dune/presentation/providers/state_controllers.dart';

class NavigationHelper {
  /// one of [playlist] or [exploreItem] cannot be null.
  static void onPlaylistItemCardPressed(
    BuildContext context, {
    BaseExploreMusicItem? exploreItem,
    BasePlaylist? playlist,
  }) {
    assert(playlist != null || exploreItem != null);
    final pagePlaylist = playlist ?? BasePlaylist.fromExploreItem(exploreItem!);
    final path = _getPath('/playlist/${pagePlaylist.id}', 'playlist');
    context.push(path, extra: pagePlaylist);
  }

  static void onGoToArtistPage(BuildContext context, BaseArtist artist) {
    final path = _getPath('/artist/${artist.id}', 'artist');
    if (path != AppRouter.currentLocation) {
      context.push(path, extra: artist);
    }
  }

  static _getPath(String relativePath, String pathKeyword) {
    final currentArtistPagePathIndex =
        AppRouter.currentLocation.indexOf(RegExp('/$pathKeyword/'));
    if (currentArtistPagePathIndex != -1) {
      var path = AppRouter.currentLocation
          .replaceRange(currentArtistPagePathIndex, null, '');
      return path + relativePath;
    }
    return AppRouter.currentLocation + relativePath;
  }

  static void onExploreMusicCategoryCardPressed(
    BuildContext context,
    WidgetRef ref, {
    required BaseExploreMusicItem exploreItem,
  }) {
    ref
        .read(exploreMusicCategoriesControllerProvider.notifier)
        .get(exploreItem.sourceId, exploreItem.source);

    final String path;
    final base = RoutePath.exploreMusicCategoryPage
        .replaceAll(':categoryId', exploreItem.sourceId);
    if (AppRouter.tabsModeEnabled) {
      final currentTab = ref.watch(tabsStateProvider).selectedTabIndex;
      path = '/tabs/$currentTab$base';
    } else {
      path = base;
    }
    if (path != AppRouter.currentLocation) {
      context.push(
        path,
        extra: (categoryId: exploreItem.sourceId, title: exploreItem.title),
      );
    }
  }

  static void showSettingsDialog(BuildContext context) {
    showDialog(context: context, builder: (context) => const SettingsDialog());
  }
}

class SettingsDialog extends ConsumerWidget {
  const SettingsDialog({super.key});

  @override
  Widget build(BuildContext context, ref) {
    // we're listening to theme changes here because the theme of dialog and its children
    // doesn't get updated by default when the user toggles the theme mode.
    final theme = ref.watch(appThemeControllerProvider).materialThemeData;
    return Dialog(
      backgroundColor: theme.colorScheme.background,
      shape: const RoundedRectangleBorder(borderRadius: kBorderRadius),
      child: Theme(
        data: theme,
        child: const Stack(
          children: [
            SettingsPage(),
            Positioned(top: 10, right: 10, child: CloseButton()),
          ],
        ),
      ),
    );
  }
}
