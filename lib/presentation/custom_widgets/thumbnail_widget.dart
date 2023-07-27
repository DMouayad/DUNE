import 'dart:io';

import 'package:dune/domain/app_preferences/base_app_preferences.dart';
import 'package:dune/domain/audio/base_models/thumbnails_set.dart';
import 'package:dune/presentation/custom_widgets/shimmer_widget.dart';
import 'package:dune/presentation/providers/state_controllers.dart';
import 'package:dune/support/logger_service.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'image_place_holder.dart';

class ThumbnailWidget extends ConsumerWidget {
  const ThumbnailWidget({
    required this.thumbnailsSet,
    required this.dimension,
    this.placeholder,
    this.shape = BoxShape.rectangle,
    this.cacheNetworkImage = true,
    super.key,
  });

  final ThumbnailsSet thumbnailsSet;
  final bool cacheNetworkImage;
  final double dimension;
  final Widget? placeholder;
  final BoxShape shape;

  @override
  Widget build(BuildContext context, ref) {
    final String? localThumbUrl = thumbnailsSet.onlyLocalThumbnailsSet
        .byOrderOrNull(ThumbnailQualitiesOrderOption.best, isNetwork: false)
        ?.url;
    ImageProvider? imageProvider;
    try {
      if (localThumbUrl != null) {
        final imageFile = File(localThumbUrl);
        if (imageFile.existsSync()) {
          imageProvider = ExtendedFileImageProvider(imageFile);
        }
      } else {
        final networkImageUrl = thumbnailsSet
                .byOrderOrNull(
                  ref.watch(appPreferencesController
                      .select((value) => value.thumbnailQualitiesOrder)),
                  isNetwork: true,
                )
                ?.url ??
            thumbnailsSet.any(isNetwork: true)?.url;
        if (networkImageUrl != null) {
          final uri = Uri.tryParse(networkImageUrl);
          final isValidUri = uri != null;
          if (isValidUri) {
            imageProvider = ExtendedNetworkImageProvider(
              networkImageUrl,
              cache: cacheNetworkImage,
            );
          }
        }
      }
    } catch (e) {
      Log.e(e);
    }
    if (imageProvider != null) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: ExtendedImage(
          image: imageProvider,
          fit: BoxFit.cover,
          shape: shape,
          width: dimension,
          height: dimension,
          loadStateChanged: (state) {
            return switch (state.extendedImageLoadState) {
              LoadState.loading => ShimmerWidget(
                  enabled: true,
                  shimmerSize: Size.square(dimension),
                  // direction: const ShimmerDirection.fr(),
                ),
              _ => null,
            };
          },
        ),
      );
    }
    return placeholder ?? const ImagePlaceHolder();
  }
}
