import 'dart:io';

import 'package:dune/domain/audio/base_models/base_track.dart';
import 'package:dune/presentation/providers/state_controllers.dart';
import 'package:dune/support/enums/music_source.dart';
import 'package:dune/support/logger_service.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'image_place_holder.dart';

class TrackThumbnail extends ConsumerWidget {
  const TrackThumbnail({
    this.cacheNetworkImage = true,
    required this.track,
    required this.dimension,
    super.key,
  });

  final BaseTrack track;
  final bool cacheNetworkImage;
  final double dimension;

  @override
  Widget build(BuildContext context, ref) {
    final String? url = switch (track.source) {
      MusicSource.local => track.thumbnails.thumbnailUrls.firstOrNull,
      MusicSource.unknown => null,
      _ => track.thumbnails
          .byOrder(ref.watch(appPreferencesController
              .select((value) => value.thumbnailQualitiesOrder)))
          .url,
    };
    ImageProvider? imageProvider;
    if (url != null) {
      try {
        if (track.source.isOnline || track.source.isUnknown) {
          final uri = Uri.tryParse(url);
          if (uri != null) {
            imageProvider = ExtendedNetworkImageProvider(
              url,
              cache: cacheNetworkImage,
            );
          }
        }
        if (track.source.isLocal || track.source.isUnknown) {
          final imageFile = File(url);
          if (imageFile.existsSync()) {
            imageProvider = ExtendedFileImageProvider(imageFile);
          }
        }
      } catch (e) {
        Log.e(e);
      }
      if (imageProvider != null) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: ExtendedImage(
            image: imageProvider,
            fit: BoxFit.cover,
            width: dimension,
            height: dimension,
          ),
        );
      }
    }
    return const ImagePlaceHolder();
  }
}
