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
    this.cardWidth,
  });

  const factory AlbumCard.selectable({
    required BaseAlbum album,
    required SelectionState<BaseAlbum> selectionState,
    required void Function(String key) onSelected,
    double? cardWidth,
  }) = _SelectableAlbumCard;

  final BaseAlbum album;
  final double? cardWidth;

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      tag: album.id ?? album.title,
      thumbnails: album.thumbnails,
      width: cardWidth,
      thumbImagePlaceholder: const AlbumCoverPlaceholder(),
      title: album.title,
      subtitle: _getSubtitle(album),
      shape: BoxShape.rectangle,
    );
  }

  String _getSubtitle(BaseAlbum album) {
    var text = album.artists.firstOrNull?.name ?? '';
    if (album.releaseDate != null) text = '$text - ${album.releaseDate!.year}';
    return text;
  }
}

class _SelectableAlbumCard extends AlbumCard {
  final SelectionState<BaseAlbum> selectionState;
  final void Function(String key) onSelected;

  const _SelectableAlbumCard({
    required super.album,
    super.cardWidth,
    required this.selectionState,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    final selectionKey = album.title;

    return SelectableCard<BaseAlbum>(
      selectionKey: selectionKey,
      popupMenu: const SizedBox(),
      onTap: () {},
      selectionState: selectionState,
      onSelected: () => onSelected(selectionKey),
      child: AlbumCard(album: album, cardWidth: cardWidth),
    );
  }
}
