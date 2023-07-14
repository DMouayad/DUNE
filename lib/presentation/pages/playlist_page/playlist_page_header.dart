import 'package:dune/domain/audio/base_models/thumbnails_set.dart';
import 'package:dune/presentation/custom_widgets/placeholders.dart';
import 'package:dune/presentation/custom_widgets/thumbnail_with_gestures_widget.dart';
import 'package:dune/presentation/custom_widgets/dune_loading_widget.dart';
import 'package:dune/support/extensions/context_extensions.dart';
import 'package:flutter/material.dart';

class PlaylistPageHeader extends StatelessWidget {
  final Color cardColor;
  final String? description;
  final String title;
  final ThumbnailsSet? thumbnailsSet;
  final int? tracksCount;
  final void Function()? onShuffle;
  final bool isFetchingPlaylistInfo;

  const PlaylistPageHeader({
    super.key,
    required this.cardColor,
    required this.description,
    required this.title,
    required this.onShuffle,
    required this.thumbnailsSet,
    required this.tracksCount,
    required this.isFetchingPlaylistInfo,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Stack(
      children: [
        SizedBox(
          width: size.width,
          height: size.width > 500 ? size.height * 0.27 : size.height * 0.23,
          child: LayoutBuilder(
            builder: (context, constraints) {
              final imageSize = Size(
                  size.width > 500
                      ? size.height / 4.4
                      : constraints.maxWidth / 2.8,
                  size.width > 500
                      ? size.height / 4.4
                      : constraints.maxWidth / 2.8);
              return Row(
                children: [
                  Hero(
                    tag: title,
                    child: ThumbnailWithGesturesWidget(
                      constraints: BoxConstraints.tight(imageSize),
                      thumbnailsSet: thumbnailsSet!,
                      placeholder: const PlaylistCoverPlaceholder(),
                    ),
                  ),
                  Expanded(
                    flex: 0,
                    child: Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(16, 16, 8, 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: constraints.maxWidth / 1.7,
                            child: Text(
                              title,
                              style: context.textTheme.titleLarge?.copyWith(
                                color: context.colorScheme.primary,
                              ),
                              softWrap: true,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(height: 10),
                          if (tracksCount != null) ...[
                            Text(
                              '▪ $tracksCount tracks ▪',
                              softWrap: true,
                              style: context.textTheme.titleSmall?.copyWith(
                                color: context.colorScheme.secondary,
                              ),
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.left,
                            ),
                            const SizedBox(height: 10),
                          ],
                          if (description != null) ...[
                            SizedBox(
                              width: constraints.maxWidth / 2,
                              child: Text(
                                description!,
                                softWrap: true,
                                maxLines: 2,
                                style: context.textTheme.titleMedium?.copyWith(
                                  color: context.colorScheme.secondary,
                                ),
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.left,
                              ),
                            ),
                            const Spacer(),
                          ],
                          TextButton.icon(
                            onPressed: onShuffle,
                            icon: const Icon(Icons.shuffle),
                            label: const Text("shuffle"),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
        if (isFetchingPlaylistInfo)
          const Positioned(
            right: 6,
            top: 6,
            child: DuneLoadingWidget(size: 24),
          ),
      ],
    );
  }
}
