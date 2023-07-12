import 'package:dune/domain/audio/base_models/thumbnails_set.dart';
import 'package:dune/presentation/providers/state_controllers.dart';
import 'package:dune/support/extensions/context_extensions.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomCard extends StatefulWidget {
  const CustomCard({
    super.key,
    required this.tag,
    required this.title,
    required this.shape,
    required this.onTap,
    required this.thumbnails,
  });

  final String tag;
  final String? title;
  final BoxShape shape;
  final ThumbnailsSet thumbnails;
  final void Function() onTap;

  @override
  State<CustomCard> createState() => _CustomCardState();
}

class _CustomCardState extends State<CustomCard> {
  late final defaultImagePadding = const EdgeInsets.all(6);
  final expandedImagePadding = EdgeInsets.zero;
  late EdgeInsets imagePadding;

  @override
  void initState() {
    imagePadding = defaultImagePadding;
    super.initState();
  }

  final rectangleBorderRadius = BorderRadius.circular(10);

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: widget.tag,
      child: InkWell(
        onHover: (hovered) => setState(() {
          imagePadding = hovered ? expandedImagePadding : defaultImagePadding;
        }),
        borderRadius: rectangleBorderRadius,
        onTap: widget.onTap,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: widget.shape == BoxShape.rectangle
                ? rectangleBorderRadius
                : null,
            color: widget.shape == BoxShape.rectangle
                ? context.colorScheme.surfaceVariant
                : null,
            shape: widget.shape,
          ),
          child: Column(
            children: [
              Expanded(
                child: AnimatedPadding(
                  padding: imagePadding,
                  duration: const Duration(milliseconds: 150),
                  child: Card(
                    elevation: 4,
                    clipBehavior: Clip.antiAlias,
                    shape: widget.shape == BoxShape.rectangle
                        ? RoundedRectangleBorder(
                            borderRadius: rectangleBorderRadius)
                        : const CircleBorder(),
                    child: Consumer(builder: (context, ref, _) {
                      return ExtendedImage.network(
                        widget.thumbnails
                            .byOrder(ref
                                .watch(appPreferencesController)
                                .thumbnailQualitiesOrder)
                            .url,
                        fit: BoxFit.cover,
                        cache: false,
                        shape: widget.shape,
                        borderRadius: widget.shape == BoxShape.rectangle
                            ? rectangleBorderRadius
                            : null,
                      );
                    }),
                  ),
                ),
              ),
              // const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  widget.title ?? '',
                  textAlign: TextAlign.center,
                  softWrap: false,
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: context.colorScheme.onBackground,
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
