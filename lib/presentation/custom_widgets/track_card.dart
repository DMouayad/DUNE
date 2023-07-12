import 'package:dune/domain/audio/base_models/base_album.dart';
import 'package:dune/domain/audio/base_models/base_artist.dart';
import 'package:dune/domain/audio/base_models/base_track.dart';
import 'package:dune/presentation/custom_widgets/optional_parent_widget.dart';
import 'package:dune/presentation/custom_widgets/track_thumbnail.dart';
import 'package:dune/support/extensions/context_extensions.dart';
import 'package:dune/support/extensions/extensions.dart';
import 'package:flutter/material.dart';

import 'track_card_wrapper.dart';

class TrackCard extends StatelessWidget {
  const TrackCard({
    super.key,
    required this.track,
    required this.color,
    required this.onPlayTrack,
  });

  final BaseTrack track;
  final Color color;
  final void Function() onPlayTrack;

  @override
  Widget build(BuildContext context) {
    return TrackCardWrapper(
      track: track,
      onPlayTrack: onPlayTrack,
      cardColor: color,
      child: TrackCardMainContent(track: track),
    );
  }
}

class TrackCardMainContent extends StatelessWidget {
  const TrackCardMainContent({
    super.key,
    required this.track,
    this.alwaysCenterTitle = false,
    this.onThumbnailPressed,
    this.crossAxisAlignment,
  });

  final BaseTrack<BaseAlbum, BaseArtist> track;
  final bool alwaysCenterTitle;
  final void Function()? onThumbnailPressed;
  final CrossAxisAlignment? crossAxisAlignment;

  @override
  Widget build(BuildContext context) {
    final titleTextStyle = context.textTheme.bodyMedium?.copyWith(
      color: context.colorScheme.onBackground,
      fontWeight: FontWeight.w500,
    );
    final secondaryTextStyle = context.textTheme.bodySmall?.copyWith(
      color: context.colorScheme.onSurfaceVariant,
    );
    final wideSpacer = SizedBox(width: context.screenWidth > 900 ? 36 : 24);

    final double imageDimension = context.isDesktop ? 56 : 48;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: crossAxisAlignment ?? CrossAxisAlignment.center,
      children: [
        const SizedBox(width: 12),
        Expanded(
          flex: 0,
          child: OptionalParentWidget(
            condition: onThumbnailPressed != null,
            parentWidgetBuilder: (child) {
              return InkWell(
                onTap: onThumbnailPressed,
                child: Tooltip(message: 'Tap to play', child: child),
              );
            },
            childWidget: TrackThumbnail(
              track: track,
              dimension: imageDimension,
              cacheNetworkImage: true,
            ),
          ),
        ),
        wideSpacer,
        Expanded(
          flex: context.screenWidth > 900 ? 2 : 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: alwaysCenterTitle
                ? MainAxisAlignment.center
                : MainAxisAlignment.start,
            children: [
              Text(
                track.title,
                overflow: TextOverflow.ellipsis,
                style: titleTextStyle,
              ),
              if (track.artistsNames.isNotEmpty || !alwaysCenterTitle) ...[
                const SizedBox(height: 3),
                Text(
                  track.artistsNames,
                  style: secondaryTextStyle,
                ),
              ],
            ],
          ),
        ),
        wideSpacer,
        if (track.album != null)
          ...() {
            final text = track.album!.title +
                (track.album?.releaseDate != null
                    ? '(${track.album?.releaseDate?.year})'
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
                        child: Text(
                          text,
                          style: secondaryTextStyle,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              wideSpacer,
            ];
          }(),
        Expanded(
          flex: 0,
          child: Text(
            track.duration.formatInHhMmSs,
            overflow: TextOverflow.ellipsis,
            style: context.textTheme.bodySmall?.copyWith(
                // color: context.colorScheme.onPrimaryContainer,
                ),
          ),
        ),
        wideSpacer,
      ],
    );
  }
}
