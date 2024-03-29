import 'package:dune/domain/audio/base_models/thumbnails_set.dart';
import 'package:dune/domain/audio/base_models/track_audio_info.dart';
import 'package:dune/presentation/custom_widgets/image_place_holder.dart';
import 'package:dune/presentation/custom_widgets/thumbnail_with_gestures_widget.dart';
import 'package:dune/presentation/providers/state_controllers.dart';
import 'package:dune/support/extensions/context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
      constraints: BoxConstraints.loose(Size.square(imageDimension)),
    );
  }
}

class PlayerBarTrackInfo extends ConsumerWidget {
  const PlayerBarTrackInfo({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final currentTrack = ref.watch(
        playbackControllerProvider.select((value) => value.currentTrack));
    final streamingQuality = ref.watch(
        playbackControllerProvider.select((value) => value.streamingQuality));
    final trackTitle = currentTrack?.title;
    final artistsNames = currentTrack?.artists.map((e) => e.name).join(', ');
    return currentTrack == null
        ? const SizedBox.shrink()
        : Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 0,
                  child: Text(
                    trackTitle ?? '',
                    style: context.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines:
                        artistsNames == null || artistsNames.isEmpty ? 2 : 1,
                    textAlign: TextAlign.start,
                  ),
                ),
                if (artistsNames != null && artistsNames.isNotEmpty) ...[
                  Expanded(
                    child: Text(
                      artistsNames,
                      maxLines: 1,
                      textAlign: TextAlign.center,
                      style: context.textTheme.bodyMedium,
                    ),
                  ),
                ],
                if (currentTrack.audioInfoSet != null)
                  Text(
                    _getTrackAudioInfoFormatted(currentTrack.audioInfoSet
                        ?.whereQuality(streamingQuality, currentTrack.source)),
                    style: context.textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.w500,
                      color: context.colorScheme.onPrimaryContainer
                          .withOpacity(.6),
                    ),
                  ),
              ],
            ),
          );
  }

  String _getTrackAudioInfoFormatted(TrackAudioInfo? audioInfo) {
    if (audioInfo == null) return '';
    return (audioInfo.kiloBitsPerSecond != null
        ? '${audioInfo.kiloBitsPerSecond!.toInt()} kbps'
        : '');
  }
}
