import 'package:dune/domain/audio/base_models/thumbnails_set.dart';
import 'package:dune/presentation/custom_widgets/thumbnail_widget.dart';
import 'package:dune/support/extensions/context_extensions.dart';
import 'package:flutter/material.dart';

class CustomCard extends StatefulWidget {
  const CustomCard({
    super.key,
    required this.tag,
    required this.title,
    required this.shape,
    required this.thumbnails,
    this.onTap,
    this.cacheImage = false,
    this.subtitle,
    double? width,
    this.thumbImagePlaceholder,
  }) : width = width ?? 240;

  final String tag;
  final String? title;
  final String? subtitle;
  final BoxShape shape;
  final ThumbnailsSet thumbnails;
  final void Function()? onTap;
  final double width;
  final Widget? thumbImagePlaceholder;
  final bool cacheImage;

  @override
  State<CustomCard> createState() => _CustomCardState();
}

class _CustomCardState extends State<CustomCard> {
  late final defaultImagePadding = const EdgeInsets.all(8);
  final expandedImagePadding = const EdgeInsets.all(2);
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
        mouseCursor: MouseCursor.defer,
        child: Container(
          decoration: BoxDecoration(
            borderRadius:
                widget.shape == BoxShape.circle ? null : rectangleBorderRadius,
            color: widget.shape == BoxShape.rectangle
                ? context.colorScheme.surfaceVariant.withOpacity(.5)
                : null,
            shape: widget.shape,
          ),
          child: Column(
            children: [
              Expanded(
                child: AnimatedContainer(
                  padding: imagePadding,
                  duration: const Duration(milliseconds: 150),
                  margin: EdgeInsets.zero,
                  constraints: const BoxConstraints.expand(),
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    borderRadius: widget.shape == BoxShape.circle
                        ? null
                        : rectangleBorderRadius,
                    shape: widget.shape,
                  ),
                  child: ThumbnailWidget(
                    shape: widget.shape,
                    thumbnailsSet: widget.thumbnails,
                    dimension: widget.width,
                    placeholder: widget.thumbImagePlaceholder,
                    cacheNetworkImage: widget.cacheImage,
                  ),
                ),
              ),
              Expanded(
                flex: 0,
                child: Container(
                  height: 40,
                  padding: const EdgeInsets.symmetric(horizontal: 3),
                  child: Text(
                    widget.title ?? '',
                    textAlign: TextAlign.center,
                    style: context.textTheme.titleSmall,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              if (widget.subtitle?.isNotEmpty ?? false)
                Container(
                  margin: const EdgeInsets.only(bottom: 15, left: 5, right: 5),
                  child: Text(
                    widget.subtitle!,
                    textAlign: TextAlign.center,
                    softWrap: false,
                    overflow: TextOverflow.ellipsis,
                    style: context.textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
