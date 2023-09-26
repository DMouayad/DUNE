import 'package:dune/domain/audio/base_models/base_artist.dart';
import 'package:dune/presentation/controllers/selection_controller.dart';
import 'package:dune/presentation/custom_widgets/placeholders.dart';
import 'package:flutter/material.dart';

import 'custom_card.dart';
import 'selectable_card.dart';

class ArtistCard extends StatelessWidget {
  const ArtistCard({super.key, required this.artist, this.width});

  final BaseArtist artist;
  final double? width;

  const factory ArtistCard.selectable({
    required BaseArtist artist,
    required SelectionState<BaseArtist> selectionState,
    required void Function(String key) onSelected,
    double? width,
  }) = _SelectableArtistCard;

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      width: width,
      tag: artist.id ?? artist.browseId ?? artist.hashCode.toString(),
      title: artist.name,
      thumbnails: artist.thumbnails,
      shape: BoxShape.circle,
      onTap: () {},
    );
  }
}

class _SelectableArtistCard extends ArtistCard {
  final SelectionState<BaseArtist> selectionState;
  final void Function(String key) onSelected;

  const _SelectableArtistCard({
    required super.artist,
    required this.selectionState,
    required this.onSelected,
    super.width,
  });

  @override
  Widget build(BuildContext context) {
    final selectionKey = artist.name ?? artist.hashCode.toString();

    return SelectableCard<BaseArtist>(
      selectionKey: selectionKey,
      popupMenu: const SizedBox(),
      onTap: () {},
      selectionState: selectionState,
      onSelected: () => onSelected(selectionKey),
      child: ArtistCard(artist: artist, width: width),
    );
  }
}
