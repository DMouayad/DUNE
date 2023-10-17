import 'package:dune/domain/audio/base_models/base_playlist.dart';
import 'package:dune/presentation/custom_widgets/shimmer_widget.dart';
import 'package:dune/presentation/providers/shared_providers.dart';
import 'package:dune/navigation/src/app_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../custom_widgets/custom_card.dart';
import 'search_result_items_grid.dart';

const _maxAlbumCardHeight = 250.0;

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
        ref
            .read(materialSearchBarControllerProvider)
            .closeView(ref.watch(materialSearchBarControllerProvider).text);
        AppNavigation.instance
            .onPlaylistItemCardPressed(context, playlist: playlist);
      },
    );
  }
}

class PlaylistsResultWidget extends StatelessWidget {
  const PlaylistsResultWidget(this.result, {super.key});

  final AsyncValue<List<BasePlaylist>> result;

  @override
  Widget build(BuildContext context) {
    return SearchResultItemsGrid(
      maxHeight: _maxAlbumCardHeight,
      itemsCount: result.isLoading ? 3 : result.valueOrNull?.length ?? 0,
      childBuilder: (index) {
        return result.when(
          error: (err, stack) => Text('error $err'),
          loading: () => const _ShimmerCard(),
          data: (albums) => _PlaylistCard(playlist: albums[index]),
        );
      },
    );
  }
}

class _ShimmerCard extends StatelessWidget {
  const _ShimmerCard();

  @override
  Widget build(BuildContext context) {
    return const ShimmerWidget(
      enabled: true,
      shimmerSize: Size.fromHeight(_maxAlbumCardHeight - 30),
      shape: BoxShape.rectangle,
      borderRadius: 10,
    );
  }
}
