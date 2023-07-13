import 'dart:math';

import 'package:dune/domain/audio/base_models/base_track.dart';
import 'package:dune/presentation/custom_widgets/image_place_holder.dart';
import 'package:dune/presentation/custom_widgets/thumbnail_with_gestures_widget.dart';
import 'package:dune/presentation/providers/state_controllers.dart';
import 'package:dune/support/extensions/context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TrackPlayerBarImage extends ConsumerWidget {
  const TrackPlayerBarImage({required this.imageDimension, Key? key})
      : super(key: key);
  final double imageDimension;

  @override
  Widget build(BuildContext context, ref) {
    final currentTrackThumbs = ref.watch(playbackControllerProvider
        .select((playerState) => playerState.currentTrack?.thumbnails));

    return ThumbnailWithGesturesWidget(
      thumbnailsSet: currentTrackThumbs,
      placeholder: const ImagePlaceHolder(),
      constraints:
          BoxConstraints(maxWidth: imageDimension, maxHeight: imageDimension),
    );
  }
}

const minimizedWidth = 66.0;

class PLayerBarTrackInfo extends ConsumerWidget {
  const PLayerBarTrackInfo({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final currentTrack = ref.watch(
        playbackControllerProvider.select((value) => value.currentTrack));
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

class ExpandableTrackInfo extends ConsumerStatefulWidget {
  const ExpandableTrackInfo({super.key});

  @override
  ConsumerState<ExpandableTrackInfo> createState() =>
      _ExpandableTrackInfoState();
}

class _ExpandableTrackInfoState extends ConsumerState<ExpandableTrackInfo>
    with AutomaticKeepAliveClientMixin {
  double? width;

  BaseTrack? currentTrack;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    currentTrack ??= ref.watch(
        playbackControllerProvider.select((value) => value.currentTrack));
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
          vertical: currentTrack == null ? 0 : 6,
        ),
        child: const PLayerBarTrackInfo(),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
