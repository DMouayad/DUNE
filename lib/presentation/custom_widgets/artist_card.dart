import 'package:dune/domain/audio/base_models/base_artist.dart';
import 'package:dune/presentation/controllers/selection_controller.dart';
import 'package:dune/presentation/custom_widgets/placeholders.dart';
import 'package:dune/navigation/src/app_navigation.dart';
import 'package:flutter/material.dart';

import 'custom_card.dart';
import 'selectable_card.dart';

class ArtistCard extends StatelessWidget {
  const ArtistCard({
    super.key,
    required this.artist,
    this.width,
    this.navigateToDetailsPageOnPressed = true,
  });

  final BaseArtist artist;
  final double? width;
  final bool navigateToDetailsPageOnPressed;

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
      onTap: navigateToDetailsPageOnPressed
          ? () {
              AppNavigation.instance.onGoToArtistPage(context, artist);
            }
          : null,
      tag: artist.id ?? artist.browseId ?? artist.hashCode.toString(),
      title: artist.name,
      thumbnails: artist.thumbnails,
      thumbImagePlaceholder: const ArtistCoverPlaceholder(),
      shape: BoxShape.circle,
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
    final selectionKey = artist.name!;

    return SelectableCard<BaseArtist>(
      selectionKey: selectionKey,
      popupMenu: const SizedBox(),
      onTap: () {
        AppNavigation.instance.onGoToArtistPage(context, artist);
      },
      selectionState: selectionState,
      onSelected: () => onSelected(selectionKey),
      child: ArtistCard(
        artist: artist,
        width: width,
        navigateToDetailsPageOnPressed: false,
      ),
    );
  }
}
