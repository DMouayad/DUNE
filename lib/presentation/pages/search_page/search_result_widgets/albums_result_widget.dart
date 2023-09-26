import 'package:dune/domain/audio/base_models/base_album.dart';
import 'package:dune/presentation/custom_widgets/album_card.dart';
import 'package:dune/presentation/custom_widgets/shimmer_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'search_result_items_grid.dart';

const _maxAlbumCardHeight = 250.0;

class AlbumsResultWidget extends StatelessWidget {
  const AlbumsResultWidget(this.result, {super.key});

  final AsyncValue<List<BaseAlbum>> result;

  @override
  Widget build(BuildContext context) {
    return SearchResultItemsGrid(
      maxHeight: _maxAlbumCardHeight,
      itemsCount: result.isLoading ? 4 : result.valueOrNull?.length ?? 0,
      childBuilder: (index) {
        return result.when(
          error: (err, stack) => Text('error $err'),
          loading: () => const _AlbumsShimmer(),
          data: (albums) {
            final album = albums.elementAt(index);
            return AlbumCard(album: album, cardWidth: _maxAlbumCardHeight);
          },
        );
      },
    );
  }
}

class _AlbumsShimmer extends StatelessWidget {
  const _AlbumsShimmer();

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
