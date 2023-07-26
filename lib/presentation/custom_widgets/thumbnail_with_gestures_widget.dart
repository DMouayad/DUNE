import 'package:dune/domain/app_preferences/base_app_preferences.dart';
import 'package:dune/domain/audio/base_models/thumbnails_set.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:fluent_ui/fluent_ui.dart' as fluent;

import 'thumbnail_widget.dart';

class ThumbnailWithGesturesWidget extends StatelessWidget {
  const ThumbnailWithGesturesWidget({
    super.key,
    required this.constraints,
    required this.thumbnailsSet,
    required this.placeholder,
  });

  final BoxConstraints constraints;
  final ThumbnailsSet? thumbnailsSet;
  final Widget placeholder;

  @override
  Widget build(BuildContext context) {
    if (thumbnailsSet == null) return placeholder;
    final highQualityThumb =
        thumbnailsSet!.byOrder(ThumbnailQualitiesOrderOption.best, true);
    return InkWell(
      onTap: () {
        fluent.showDialog(
          context: context,
          barrierDismissible: true,
          builder: (context) {
            return Dialog(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ExtendedImage.network(
                  highQualityThumb.url,
                  width: highQualityThumb.width,
                  height: highQualityThumb.height,
                  fit: BoxFit.fill,
                  cache: false,
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
              ),
            );
          },
        );
      },
      child: ThumbnailWidget(
        thumbnailsSet: thumbnailsSet!,
        dimension: constraints.maxWidth,
      ),
    );
  }
}
