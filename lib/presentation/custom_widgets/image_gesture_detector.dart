import 'package:dune/domain/app_preferences/base_app_preferences.dart';
import 'package:dune/domain/audio/base_models/thumbnails_set.dart';
import 'package:dune/presentation/custom_widgets/shimmer_widget.dart';
import 'package:dune/presentation/providers/state_controllers.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:fluent_ui/fluent_ui.dart' as fluent;
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ImageGestureDetector extends StatelessWidget {
  const ImageGestureDetector({
    super.key,
    required this.constraints,
    required this.thumbnailsSet,
  });

  final BoxConstraints constraints;
  final ThumbnailsSet thumbnailsSet;

  @override
  Widget build(BuildContext context) {
    final highQualityThumb =
        thumbnailsSet.byOrder(ThumbnailQualitiesOrderOption.best);
    return InkWell(
      onTap: () {
        fluent.showDialog(
          context: context,
          barrierDismissible: true,
          builder: (context) {
            return Dialog(
              child: ExtendedImage.network(
                highQualityThumb.url,
                width: highQualityThumb.width,
                height: highQualityThumb.height,
                fit: BoxFit.cover,
                cache: true,
                mode: ExtendedImageMode.gesture,
                initGestureConfigHandler: (state) {
                  return GestureConfig(
                    reverseMousePointerScrollDirection: true,
                    minScale: 0.9,
                    animationMinScale: 0.7,
                    maxScale: 3.0,
                    animationMaxScale: 3.5,
                    speed: 1.0,
                    inertialSpeed: 100.0,
                    initialScale: 0.9,
                    inPageView: false,
                    initialAlignment: InitialAlignment.center,
                  );
                },
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(8),
              ),
            );
          },
        );
      },
      child: Consumer(builder: (context, ref, _) {
        final url = thumbnailsSet
            .byOrder(
                ref.watch(appPreferencesController).thumbnailQualitiesOrder)
            .url;
        return ExtendedImage.network(
          url,
          constraints: constraints,
          fit: BoxFit.fill,
          cache: true,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(10),
          loadStateChanged: (state) {
            return switch (state.extendedImageLoadState) {
              LoadState.loading => ShimmerWidget(
                  enabled: true,
                  shimmerSize: constraints.biggest,
                  direction: const ShimmerDirection.fromTopToBottom(),
                ),
              _ => null,
            };
          },
        );
      }),
    );
  }
}
