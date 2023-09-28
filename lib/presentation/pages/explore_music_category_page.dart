import 'dart:math';

import 'package:collection/collection.dart';
import 'package:dune/domain/audio/base_models/base_playlist.dart';
import 'package:dune/presentation/controllers/explore_music_categories_controller.dart';
import 'package:dune/presentation/custom_widgets/cards_grid_view.dart';
import 'package:dune/presentation/custom_widgets/custom_card.dart';
import 'package:dune/presentation/providers/state_controllers.dart';
import 'package:dune/presentation/utils/navigation_helper.dart';
import 'package:dune/support/extensions/context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ExploreMusicCategoryPage extends ConsumerStatefulWidget {
  const ExploreMusicCategoryPage({super.key, this.categoryId, this.title});

  final String? categoryId;
  final String? title;

  @override
  ConsumerState<ExploreMusicCategoryPage> createState() =>
      _ExploreMusicCategoryPageState();
}

class _ExploreMusicCategoryPageState
    extends ConsumerState<ExploreMusicCategoryPage>
    with AutomaticKeepAliveClientMixin<ExploreMusicCategoryPage> {
  ExploreMusicCategoriesControllerState playlistState =
      const AsyncValue.loading();
  List<BasePlaylist> playlists = [];

  @override
  Widget build(BuildContext context) {
    super.build(context);

    if (ref.watch(exploreMusicCategoriesControllerProvider).hasValue) {
      final newCategoryPlaylists =
          ref.watch(exploreMusicCategoriesControllerProvider).value;
      if (newCategoryPlaylists?.categoryId == widget.categoryId) {
        if (_hasSamePlaylists(newCategoryPlaylists?.playlists, playlists)) {
          playlistState = AsyncData(playlistState.value!);
          updateKeepAlive();
        } else {
          playlistState = ref.watch(exploreMusicCategoriesControllerProvider);
          playlists = playlistState.value!.playlists;
          updateKeepAlive();
        }
      }
    }
    final itemCardWidth =
        min(250.0, context.screenWidth * (context.screenWidth < 750 ? .5 : .3));
    return CardsGridView(
      itemCardWidth: itemCardWidth,
      itemCount: playlists.length,
      itemBuilder: (index) =>
          _PlaylistCard(playlist: playlists.elementAt(index)),
    );
  }

  @override
  bool get wantKeepAlive => true;

  bool _hasSamePlaylists(
    List<BasePlaylist>? playlists,
    List<BasePlaylist> playlists2,
  ) {
    final firstIds = playlists?.map((e) => e.id).toList();
    final secondIds = playlists2.map((e) => e.id).toList();
    return const ListEquality().equals(firstIds, secondIds);
  }
}

class _PlaylistCard extends ConsumerWidget {
  const _PlaylistCard({Key? key, required this.playlist}) : super(key: key);
  final BasePlaylist playlist;

  @override
  Widget build(BuildContext context, ref) {
    return CustomCard(
      tag: playlist.id ?? playlist.title!,
      thumbnails: playlist.thumbnails,
      title: playlist.title!,
      shape: BoxShape.rectangle,
      onTap: () {
        NavigationHelper.onPlaylistItemCardPressed(context, playlist: playlist);
      },
    );
  }
}
