import 'package:dune/support/themes/theme_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

//
import 'package:dune/presentation/pages/settings_page/settings_page.dart';
import 'package:dune/domain/audio/base_models/base_explore_music_item.dart';
import 'package:dune/domain/audio/base_models/base_playlist.dart';
import 'package:dune/navigation/app_router.dart';
import 'package:dune/presentation/providers/shared_providers.dart';
import 'package:dune/presentation/providers/state_controllers.dart';

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
    final source = exploreItem?.source ?? playlist!.musicSource;
    final title = exploreItem?.title ?? playlist!.title;
    final sourceId = exploreItem?.sourceId ?? playlist!.id!;
    // fetch playlist tracks and data
    final description = exploreItem?.description ?? playlist!.description;
    final thumbnails = exploreItem?.thumbnails ?? playlist!.thumbnails;
    final tracksCount = exploreItem?.count;
    final musicSource = exploreItem?.source ?? playlist!.musicSource;
    ref.read(playlistControllerProvider.notifier).get(sourceId, source);

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

  static void onExploreMusicCategoryCardPressed(
    BuildContext context,
    WidgetRef ref, {
    required BaseExploreMusicItem exploreItem,
  }) {
    ref
        .read(exploreMusicCategoriesControllerProvider.notifier)
        .get(exploreItem.sourceId, exploreItem.source);

    final basePath = 'explore-music-category/${exploreItem.sourceId}';
    final path = ref.read(appPreferencesController).tabsMode.isEnabled
        ? '/tabs/${ref.read(tabsStateProvider).selectedTabIndex}/$basePath'
        : basePath;

    context.push(
      path,
      extra: (categoryId: exploreItem.sourceId, title: exploreItem.title),
    );
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
