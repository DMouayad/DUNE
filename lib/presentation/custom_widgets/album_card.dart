import 'package:dune/domain/audio/base_models/base_album.dart';
import 'package:dune/presentation/controllers/selection_controller.dart';
import 'package:flutter/material.dart';

import 'custom_card.dart';
import 'placeholders.dart';
import 'selectable_card.dart';

class AlbumCard extends StatelessWidget {
  const AlbumCard({
    super.key,
    required this.album,
    required this.selectionState,
    required this.onSelected,
    this.cardWidth,
  });

  final BaseAlbum album;
  final SelectionState<BaseAlbum> selectionState;
  final void Function() onSelected;
  final double? cardWidth;

  @override
  Widget build(BuildContext context) {
    final selectionKey = album.id ?? album.hashCode.toString();

    return SelectableCard<BaseAlbum>(
      selectionKey: selectionKey,
      popupMenu: const SizedBox(),
      onTap: () {},
      selectionState: selectionState,
      onSelected: onSelected,
      child: CustomCard(
        tag: album.id ?? album.title,
        thumbnails: album.thumbnails,
        width: cardWidth,
        thumbImagePlaceholder: const AlbumCoverPlaceholder(),
        title: album.title,
        subtitle: _getSubtitle(album),
        shape: BoxShape.rectangle,
      ),
    );
  }

  String _getSubtitle(BaseAlbum album) {
    var text = album.artists.firstOrNull?.name ?? '';
    if (album.releaseDate != null) text = '$text - ${album.releaseDate!.year}';
    return text;
  }
}
