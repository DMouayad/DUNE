import 'dart:math';

import 'package:dune/domain/audio/base_models/base_track.dart';
import 'package:dune/domain/audio/base_models/thumbnails_set.dart';
import 'package:dune/presentation/custom_widgets/image_place_holder.dart';
import 'package:dune/presentation/custom_widgets/thumbnail_with_gestures_widget.dart';
import 'package:dune/support/extensions/context_extensions.dart';
import 'package:flutter/material.dart';

class TrackPlayerBarImage extends StatelessWidget {
  const TrackPlayerBarImage({
    required this.currentTrackThumbs,
    required this.imageDimension,
    Key? key,
  }) : super(key: key);
  final double imageDimension;
  final ThumbnailsSet? currentTrackThumbs;

  @override
  Widget build(BuildContext context) {
    return ThumbnailWithGesturesWidget(
      thumbnailsSet: currentTrackThumbs,
      placeholder: const ImagePlaceHolder(),
      constraints:
          BoxConstraints(maxWidth: imageDimension, maxHeight: imageDimension),
    );
  }
}

const minimizedWidth = 66.0;

class PLayerBarTrackInfo extends StatelessWidget {
  const PLayerBarTrackInfo(this.currentTrack, {super.key});

  final BaseTrack? currentTrack;

  @override
  Widget build(BuildContext context) {
    final trackTitle = currentTrack?.title;
    final artistsNames = currentTrack?.artists.map((e) => e.name).join(', ');
    return currentTrack == null
        ? const SizedBox.shrink()
        : Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  trackTitle ?? '',
                  style: context.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w500,
                    color: context.colorScheme.secondary,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: artistsNames == null ? 3 : 1,
                  textAlign: TextAlign.start,
                ),
              ),
              if (artistsNames != null && artistsNames.isNotEmpty) ...[
                Expanded(
                  child: Text(
                    artistsNames,
                    maxLines: 1,
                    textAlign: TextAlign.center,
                    style: context.textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.w500,
                      color: context.colorScheme.onBackground.withOpacity(.88),
                    ),
                  ),
                ),
              ],
            ],
          );
  }
}

class ExpandableTrackInfo extends StatefulWidget {
  const ExpandableTrackInfo(this.currentTrack, {super.key});

  final BaseTrack? currentTrack;

  @override
  State<ExpandableTrackInfo> createState() => _ExpandableTrackInfoState();
}

class _ExpandableTrackInfoState extends State<ExpandableTrackInfo> {
  double? width;

  @override
  Widget build(BuildContext context) {
    width ??= max(160.0, context.screenWidth * .2);

    return MouseRegion(
      onEnter: (event) {
        setState(() => width = context.screenWidth * .3);
      },
      onExit: (event) {
        setState(() => width = null);
      },
      child: AnimatedContainer(
        width: width,
        height: 50,
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(
          horizontal: 7,
          vertical: widget.currentTrack != null ? 0 : 6,
        ),
        child: PLayerBarTrackInfo(widget.currentTrack),
      ),
    );
  }
}
