import 'dart:math';

import 'package:dune/domain/audio/base_models/base_track.dart';
import 'package:dune/domain/audio/base_models/thumbnails_set.dart';
import 'package:dune/presentation/controllers/selection_controller.dart';
import 'package:dune/presentation/custom_widgets/placeholders.dart';
import 'package:dune/presentation/custom_widgets/selection_tool_bar.dart';
import 'package:dune/presentation/custom_widgets/thumbnail_with_gestures_widget.dart';
import 'package:dune/presentation/custom_widgets/dune_loading_widget.dart';
import 'package:dune/support/extensions/context_extensions.dart';
import 'package:flutter/material.dart';

class PersistentPlaylistPageHeaderDelegate
    extends SliverPersistentHeaderDelegate {
  final double minHeaderExtent;
  final double maxHeaderExtent;
  final Color cardColor;
  final String? description;
  final String title;
  final ThumbnailsSet? thumbnailsSet;
  final int? tracksCount;
  final void Function()? onShuffle;
  final bool isFetchingPlaylistInfo;
  final SelectionController<BaseTrack> controller;
  final SelectionState<BaseTrack> selectionState;
  final void Function() onSelectAll;
  final void Function()? onDownload;
  final void Function()? onRemove;

  PersistentPlaylistPageHeaderDelegate({
    required this.minHeaderExtent,
    required this.maxHeaderExtent,
    required this.cardColor,
    required this.description,
    required this.title,
    required this.onShuffle,
    required this.thumbnailsSet,
    required this.tracksCount,
    required this.isFetchingPlaylistInfo,
    required this.controller,
    required this.selectionState,
    required this.onSelectAll,
    this.onDownload,
    this.onRemove,
  });

  static const selectionToolbarMinExtent = 60.0;
  static const selectionToolbarMaxExtent = 100.0;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    /// the height of [PlaylistPageHeader] without including the [SelectionToolBar]
    /// height
    final pageHeaderHeight = maxExtent -
        shrinkOffset -
        (selectionState.selectionEnabled ? selectionToolbarMaxExtent : 0);
    final isMinimized = pageHeaderHeight < 70;

    /// whether this persistent header is fully expanded
    final isExpanded = shrinkOffset == 0;
    final selectionToolbarExtent =
        isExpanded ? selectionToolbarMaxExtent : selectionToolbarMinExtent;

    return Column(
      children: [
        Expanded(
          flex: 0,
          child: PlaylistPageHeader(
            height: isMinimized
                ? minExtent -
                    (selectionState.selectionEnabled
                        ? selectionToolbarMinExtent
                        : 0)
                : pageHeaderHeight,
            isMinimized: isMinimized,
            cardColor: cardColor,
            description: description,
            title: title,
            onShuffle: onShuffle,
            thumbnailsSet: thumbnailsSet,
            tracksCount: tracksCount,
            isFetchingPlaylistInfo: isFetchingPlaylistInfo,
          ),
        ),
        if (selectionState.selectionEnabled)
          Expanded(
            flex: 0,
            child: SizedBox(
              height: selectionToolbarExtent,
              child: SelectionToolBar(
                controller: controller,
                selectionState: selectionState,
                onSelectAll: onSelectAll,
                isExpanded: isExpanded,
                onDownload: onDownload,
                onRemove: onRemove,
              ),
            ),
          ),
      ],
    );
  }

  @override
  double get maxExtent =>
      maxHeaderExtent +
      (selectionState.selectionEnabled ? selectionToolbarMaxExtent : 0);

  @override
  double get minExtent =>
      minHeaderExtent +
      (selectionState.selectionEnabled ? selectionToolbarMinExtent : 0);

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}

class PlaylistPageHeader extends StatelessWidget {
  final Color cardColor;
  final String? description;
  final String title;
  final ThumbnailsSet? thumbnailsSet;
  final int? tracksCount;
  final void Function()? onShuffle;
  final bool isFetchingPlaylistInfo;
  final double height;
  final bool isMinimized;

  const PlaylistPageHeader({
    super.key,
    required this.height,
    required this.isMinimized,
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
    final imageSize = Size(height * .9, height);
    return SizedBox(
      width: context.screenWidth,
      height: height,
      child: Container(
        color: context.colorScheme.background,
        child: Stack(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Hero(
                  tag: title,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: ThumbnailWithGesturesWidget(
                      constraints: BoxConstraints.loose(imageSize),
                      thumbnailsSet: thumbnailsSet!,
                      placeholder: const PlaylistCoverPlaceholder(),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 12, 12),
                    child: Wrap(
                      direction: isMinimized ? Axis.horizontal : Axis.vertical,
                      spacing: 10,
                      runAlignment: WrapAlignment.spaceBetween,
                      alignment: WrapAlignment.spaceBetween,
                      children: [
                        Text(
                          title,
                          style: context.textTheme.titleLarge?.copyWith(
                            color: context.colorScheme.primary,
                          ),
                          softWrap: true,
                          overflow: TextOverflow.ellipsis,
                        ),
                        if (!isMinimized) ...[
                          if (tracksCount != null)
                            Text(
                              '▪ $tracksCount tracks ▪',
                              softWrap: true,
                              style: context.textTheme.titleSmall?.copyWith(
                                color: context.colorScheme.secondary,
                              ),
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                            ),
                          if (description != null)
                            SizedBox(
                              width: min(context.screenWidth * .5, 400),
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
            ),
            if (isFetchingPlaylistInfo)
              const Positioned(
                right: 6,
                top: 6,
                child: DuneLoadingWidget(size: 24),
              ),
          ],
        ),
      ),
    );
  }
}
