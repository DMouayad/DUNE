import 'package:dune/domain/audio/base_models/thumbnails_set.dart';
import 'package:dune/presentation/custom_widgets/thumbnail_widget.dart';
import 'package:dune/support/extensions/context_extensions.dart';
import 'package:flutter/material.dart';

class CustomCard extends StatefulWidget {
  const CustomCard({
    super.key,
    required this.tag,
    required this.title,
    this.subtitle,
    required this.shape,
    required this.onTap,
    required this.thumbnails,
    this.width = 250.0,
    this.thumbImagePlaceholder,
  });

  final String tag;
  final String? title;
  final String? subtitle;
  final BoxShape shape;
  final ThumbnailsSet thumbnails;
  final void Function() onTap;
  final double width;
  final Widget? thumbImagePlaceholder;

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
                child: AnimatedContainer(
                  padding: imagePadding,
                  duration: const Duration(milliseconds: 150),
                  margin: EdgeInsets.zero,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: context.colorScheme.onSurface.withOpacity(.1),
                        spreadRadius: 2,
                      )
                    ],
                    borderRadius: rectangleBorderRadius,
                    shape: widget.shape,
                  ),
                  child: ThumbnailWidget(
                    thumbnailsSet: widget.thumbnails,
                    dimension: widget.width,
                    placeholder: widget.thumbImagePlaceholder,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  widget.title ?? '',
                  textAlign: TextAlign.center,
                  softWrap: false,
                  style: context.textTheme.bodyLarge?.copyWith(
                    color: context.colorScheme.onBackground,
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              if (widget.subtitle != null)
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
