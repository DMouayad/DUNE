import 'package:dune/domain/audio/base_models/base_album.dart';
import 'package:dune/presentation/custom_widgets/shimmer_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../custom_widgets/custom_card.dart';
import 'search_result_items_grid.dart';

const _maxAlbumCardHeight = 250.0;

class AlbumCard extends StatelessWidget {
  const AlbumCard({Key? key, required this.album}) : super(key: key);
  final BaseAlbum album;

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      tag: album.id ?? album.title,
      thumbnails: album.thumbnails,
      title: album.title +
          (album.releaseDate != null ? '\n(${album.releaseDate!.year})' : ''),
      shape: BoxShape.rectangle,
      onTap: () {},
    );
  }
}

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
          data: (albums) => AlbumCard(album: albums[index]),
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
