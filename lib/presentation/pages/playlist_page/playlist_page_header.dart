import 'package:dune/domain/audio/base_models/base_track.dart';
import 'package:dune/domain/audio/base_models/thumbnails_set.dart';
import 'package:dune/presentation/controllers/selection_controller.dart';
import 'package:dune/presentation/custom_widgets/dune_loading_widget.dart';
import 'package:dune/presentation/custom_widgets/placeholders.dart';
import 'package:dune/presentation/custom_widgets/selection_tool_bar.dart';
import 'package:dune/presentation/custom_widgets/thumbnail_with_gestures_widget.dart';
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
    return Container(
      color: context.colorScheme.background,
      constraints: BoxConstraints.expand(
        height: height,
        width: double.infinity,
      ),
      child: Flex(
        direction: Axis.horizontal,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Hero(
            tag: title,
            child: Padding(
              padding: const EdgeInsets.only(left: 8, right: 18),
              child: ThumbnailWithGesturesWidget(
                cacheImage: true,
                constraints: BoxConstraints.loose(Size.square(height)),
                thumbnailsSet: thumbnailsSet!,
                placeholder: const PlaylistCoverPlaceholder(),
              ),
            ),
          ),
          Expanded(
            child: Stack(
              children: [
                Positioned(
                  top: 0,
                  left: 0,
                  bottom: 0,
                  child: Text(
                    title,
                    softWrap: true,
                    style: context.textTheme.titleLarge?.copyWith(
                      color: context.colorScheme.primary,
                    ),
                  ),
                ),
                if (description != null)
                  AnimatedPositioned(
                    duration: const Duration(milliseconds: 200),
                    bottom: isMinimized ? 6 : height * .3,
                    left: 0,
                    child: SizedBox(
                      width: 330,
                      child: Text(
                        description!,
                        // softWrap: true,
                        maxLines: 3,
                        style: context.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ),
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 250),
                  bottom: height * .1,
                  top: isMinimized ? 0 : null,
                  right: isMinimized ? 0 : null,
                  left: isMinimized ? null : 0,
                  child: TextButton.icon(
                    onPressed: onShuffle,
                    style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.all(
                          context.colorScheme.onPrimaryContainer),
                    ),
                    icon: const Icon(Icons.shuffle, size: 20),
                    label: Text("shuffle (${tracksCount ?? 0} tracks)"),
                  ),
                ),
                if (isFetchingPlaylistInfo)
                  Positioned(
                    top: 0,
                    right: 6,
                    child: DuneLoadingWidget(size: isMinimized ? 14 : 24),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
