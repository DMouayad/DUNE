import 'package:dune/domain/audio/base_models/base_album.dart';
import 'package:dune/domain/audio/base_models/base_artist.dart';
import 'package:dune/domain/audio/base_models/base_track.dart';
import 'package:dune/presentation/custom_widgets/thumbnail_widget.dart';
import 'package:dune/presentation/models/selection_state.dart';
import 'package:dune/presentation/providers/state_controllers.dart';
import 'package:dune/support/extensions/context_extensions.dart';
import 'package:dune/support/extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'draggable_track_card.dart';
import 'placeholders.dart';
import 'track_card_pop_up_menu.dart';
import 'selectable_card.dart';

class TrackCard extends ConsumerWidget {
  const TrackCard({
    super.key,
    this.onPlayTrack,
    required this.track,
    required this.selectionState,
    required this.onSelected,
    this.margin,
  });

  /// Called when the user requests to play this track.
  ///
  /// By default(null), this track will be played by [PlaybackController.playSingleTrack()].
  /// You can override this in case of a custom behaviour.
  final void Function()? onPlayTrack;
  final BaseTrack track;
  final SelectionState<BaseTrack> selectionState;
  final void Function(BaseTrack) onSelected;
  final EdgeInsets? margin;

  @override
  Widget build(BuildContext context, ref) {
    return DraggableTrackCard(
      selectionState: selectionState,
      child: Container(
        margin: margin ??
            (context.isPortraitTablet
                ? const EdgeInsets.fromLTRB(6, 12, 6, 0)
                : const EdgeInsets.fromLTRB(12, 3, 12, 3)),
        child: SelectableCard<BaseTrack>(
          selectionKey: track.id,
          onTap: onPlayTrack ??
              () {
                ref
                    .read(playbackControllerProvider.notifier)
                    .player
                    .playSingleTrack(track);
              },
          selectionState: selectionState,
          onSelected: () => onSelected(track),
          popupMenu: TrackCardPopupMenu(
            track,
            onDelete: null,
            onDownload: () {},
            onPlayTrack: onPlayTrack,
            onSelectTrack: () => onSelected(track),
          ),
          child: TrackCardMainContent(track: track),
        ),
      ),
    );
  }
}

class TrackCardMainContent extends StatelessWidget {
  const TrackCardMainContent({
    super.key,
    required this.track,
    this.alwaysCenterTitle = false,
    this.showAlbumName = true,
    this.showArtistsNames = true,
    this.showDuration = true,
    this.crossAxisAlignment,
  });

  final BaseTrack<BaseAlbum, BaseArtist> track;
  final bool alwaysCenterTitle;
  final CrossAxisAlignment? crossAxisAlignment;
  final bool showArtistsNames;
  final bool showAlbumName;
  final bool showDuration;

  @override
  Widget build(BuildContext context) {
    final titleTextStyle =
        context.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500);

    final wideSpacer = SizedBox(width: context.screenWidth > 900 ? 18 : 10);

    return ConstrainedBox(
      constraints: const BoxConstraints(minHeight: 52, maxHeight: 70),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: crossAxisAlignment ?? CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 0,
            child: ThumbnailWidget(
              thumbnailsSet: track.thumbnails,
              dimension: context.trackThumbnailDimension,
              placeholder: const TrackCoverPlaceholder(),
              cacheNetworkImage: true,
            ),
          ),
          wideSpacer,
          Expanded(
            flex: context.screenWidth > 900 ? 2 : 1,
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: alwaysCenterTitle
                    ? MainAxisAlignment.center
                    : MainAxisAlignment.start,
                children: [
                  SelectableText(
                    track.title,
                    // overflow: TextOverflow.ellipsis,
                    style: titleTextStyle,
                    maxLines: 1,
                  ),
                  if (showArtistsNames &&
                      (track.artistsNames.isNotEmpty ||
                          !alwaysCenterTitle)) ...[
                    const SizedBox(height: 6),
                    Wrap(
                      spacing: 4,
                      children: track.artists
                          .map(
                            (e) => e.name != null
                                ? _ClickableText(
                                    text: e.name!,
                                    onClicked: () {},
                                  )
                                : const SizedBox.shrink(),
                          )
                          .toList(),
                    ),
                  ],
                ],
              ),
            ),
          ),
          wideSpacer,
          if (track.album != null)
            ...() {
              final text = track.album!.title +
                  (track.album?.releaseDate != null
                      ? ' ${track.album?.releaseDate?.year}'
                      : '');
              return [
                Expanded(
                  flex: context.screenWidth > 900 ? 2 : 1,
                  child: Tooltip(
                    message: 'Album: $text',
                    waitDuration: const Duration(milliseconds: 600),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.album,
                          size: 16,
                          color: context.colorScheme.onSurfaceVariant
                              .withOpacity(.7),
                        ),
                        const SizedBox(width: 4),
                        Expanded(
                          child: _ClickableText(text: text, onClicked: () {}),
                        ),
                      ],
                    ),
                  ),
                ),
                wideSpacer,
              ];
            }(),
          if (showDuration)
            Expanded(
              flex: 0,
              child: Text(
                track.duration?.formatInHhMmSs ?? 'N/A',
                overflow: TextOverflow.ellipsis,
                style: context.textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          wideSpacer,
        ],
      ),
    );
  }
}

class _ClickableText extends StatefulWidget {
  const _ClickableText({required this.text, required this.onClicked});

  final String text;
  final void Function() onClicked;

  @override
  State<_ClickableText> createState() => _ClickableTextState();
}

class _ClickableTextState extends State<_ClickableText> {
  bool hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => hovered = true),
      onExit: (_) => setState(() => hovered = false),
      child: GestureDetector(
        onTap: widget.onClicked,
        child: Text(
          widget.text,
          style: context.textTheme.bodySmall?.copyWith(
            color: context.colorScheme.secondary,
            fontWeight: hovered ? FontWeight.w500 : null,
            decoration: hovered ? TextDecoration.underline : null,
          ),
          maxLines: 1,
        ),
      ),
    );
  }
}
